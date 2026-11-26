param([string]$BuildDirectory, [string]$OutputDirectory)
$ErrorActionPreference = 'Stop'
$sourceRoot = Split-Path $PSScriptRoot -Parent
if (-not $BuildDirectory) { $BuildDirectory = Join-Path $sourceRoot 'compilado' }
$BuildDirectory = [IO.Path]::GetFullPath($BuildDirectory)
if (-not $OutputDirectory) { $OutputDirectory = Join-Path $sourceRoot 'distribuicao' }
$OutputDirectory = [IO.Path]::GetFullPath($OutputDirectory)
$executable = Join-Path $BuildDirectory 'NexusServerManager.exe'
$version = ([version](Get-Item -LiteralPath $executable).VersionInfo.FileVersion).ToString(3)
$packageName = 'Nexus-Server-Manager-' + $version
$package = Join-Path $OutputDirectory $packageName
$archive = Join-Path $OutputDirectory ($packageName + '.zip')
if ((Test-Path -LiteralPath $package) -or (Test-Path -LiteralPath $archive)) { throw 'O destino ja existe. Use uma pasta de saida nova.' }
New-Item -ItemType Directory -Path $package -Force | Out-Null
foreach ($name in @('NexusServerManager.exe','NexusServerManager.exe.config')) { Copy-Item -LiteralPath (Join-Path $BuildDirectory $name) -Destination $package }
Copy-Item -LiteralPath (Join-Path $sourceRoot 'LICENSE') -Destination (Join-Path $package 'LICENSE-WindowsGSM.txt')
Copy-Item -LiteralPath (Join-Path $sourceRoot 'distribuicao-modelo\AVISOS.txt') -Destination $package
$guide = [IO.File]::ReadAllText((Join-Path $sourceRoot 'distribuicao-modelo\LEIA-ME.txt')).Replace('{VERSAO}', $version)
[IO.File]::WriteAllText((Join-Path $package 'LEIA-ME.txt'), $guide, (New-Object Text.UTF8Encoding($true)))
Compress-Archive -LiteralPath $package -DestinationPath $archive -CompressionLevel Optimal
Write-Output "Pacote enxuto: $archive"
