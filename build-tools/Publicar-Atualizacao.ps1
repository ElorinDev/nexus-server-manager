param(
    [Parameter(Mandatory=$true)][string]$ProgramDirectory,
    [string]$Repository = 'fabriciodba/nexus-server-manager',
    [Parameter(Mandatory=$true)][string]$ReleaseNotesFile,
    [string]$OutputDirectory,
    [string[]]$AdditionalAssets = @(),
    [switch]$Publish
)
$ErrorActionPreference = 'Stop'
if ($Repository -notmatch '^[A-Za-z0-9][A-Za-z0-9-]{0,38}/[A-Za-z0-9_.-]+$') { throw 'Repositorio invalido.' }
$ProgramDirectory = [IO.Path]::GetFullPath($ProgramDirectory)
$mainExecutable = Join-Path $ProgramDirectory 'NexusServerManager.exe'
$version = [version](Get-Item -LiteralPath $mainExecutable).VersionInfo.FileVersion
$tag = 'v' + $version.ToString(3)
if (-not $OutputDirectory) { $OutputDirectory = Join-Path (Split-Path $ProgramDirectory -Parent) ('publicacao-' + $tag) }
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
if (Test-Path -LiteralPath $OutputDirectory) { throw 'Use uma pasta de saida nova para evitar arquivos de outra publicacao.' }
New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
$rootNames = @('NexusServerManager.exe','NexusServerManager.exe.config','MahApps.Metro.dll','Nexus.ico','LICENSE-WindowsGSM.txt','LEIA-ME.txt','AVISOS.txt')
$files = @($rootNames | ForEach-Object { $path = Join-Path $ProgramDirectory $_; if (Test-Path -LiteralPath $path -PathType Leaf) { Get-Item -LiteralPath $path } })
$files += @(Get-ChildItem -LiteralPath (Join-Path $ProgramDirectory 'bin') -File -Recurse | Where-Object { $_.Extension -in @('.dll','.exe','.config','.json','.pdb','.rsp') })
$entries = @()
$assets = @{}
foreach ($file in $files) {
    if ($file.Length -le 0) { continue }
    $relative = $file.FullName.Substring($ProgramDirectory.TrimEnd('\').Length + 1).Replace('\','/')
    $hash = (Get-FileHash -LiteralPath $file.FullName -Algorithm SHA256).Hash.ToLowerInvariant()
    $assetName = 'nexus-file-' + $hash + '.bin'
    if (-not $assets.ContainsKey($assetName)) {
        $assetPath = Join-Path $OutputDirectory $assetName
        Copy-Item -LiteralPath $file.FullName -Destination $assetPath
        $assets[$assetName] = $assetPath
    }
    $entries += [ordered]@{ path=$relative; sha256=$hash; size=$file.Length; url="https://github.com/$Repository/releases/download/$tag/$assetName" }
}
$manifest = [ordered]@{ schemaVersion=1; product='Nexus Server Manager'; version=$version.ToString(); notes=[IO.File]::ReadAllText([IO.Path]::GetFullPath($ReleaseNotesFile)); files=$entries }
$manifestPath = Join-Path $OutputDirectory 'nexus-update.json'
$utf8 = New-Object Text.UTF8Encoding($false)
[IO.File]::WriteAllText($manifestPath, ($manifest | ConvertTo-Json -Depth 8), $utf8)
Write-Output "Manifesto pronto: $manifestPath ($($entries.Count) arquivos; $($assets.Count) downloads unicos)"
if (-not $Publish) { return }
if (-not (Get-Command gh -ErrorAction SilentlyContinue)) { throw 'Instale o GitHub CLI e autentique com gh auth login.' }
$existing = & gh release view $tag --repo $Repository --json tagName 2>$null
if ($LASTEXITCODE -eq 0) { throw "A versao $tag ja existe. Publique com um novo numero de versao." }
& gh release create $tag --repo $Repository --draft --title "Nexus Server Manager $($version.ToString(3))" --notes-file ([IO.Path]::GetFullPath($ReleaseNotesFile))
if ($LASTEXITCODE -ne 0) { throw 'Falha ao criar a versao em rascunho.' }
$upload = @($assets.Values) + @($manifestPath) + @($AdditionalAssets | ForEach-Object { [IO.Path]::GetFullPath($_) })
# Keep the version in draft until all assets are uploaded successfully.
for ($offset = 0; $offset -lt $upload.Count; $offset += 12) {
    $last = [Math]::Min($offset + 11, $upload.Count - 1)
    $batch = @($upload[$offset..$last])
    & gh release upload $tag @batch --repo $Repository
    if ($LASTEXITCODE -ne 0) { throw 'Falha no envio. A versao permanece como rascunho e nao e oferecida pelo atualizador.' }
}
& gh release edit $tag --repo $Repository --draft=false --latest
if ($LASTEXITCODE -ne 0) { throw 'Falha ao publicar a versao; confira o rascunho no GitHub.' }
Write-Output "Versao publicada: https://github.com/$Repository/releases/tag/$tag"
