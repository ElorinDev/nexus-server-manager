# Atualizações do Nexus

No aplicativo, abra **Ajuda > Atualizações do Nexus > Verificar agora**.
O repositório padrão é `fabriciodba/nexus-server-manager`, público no GitHub.
A opção de verificar ao abrir vem ativada. A instalação sempre depende do
botão **Atualizar agora**; a consulta ao abrir apenas avisa sobre novas versões.

O Nexus compara o SHA-256 de cada arquivo publicado com os arquivos locais
e baixa somente os componentes diferentes. Os downloads são conferidos antes
de fechar o aplicativo. Pare os servidores e aguarde instalações, backups ou
outras tarefas antes de aplicar a atualização. O aplicativo reabre ao terminar.

As pastas `servers`, `configs`, `plugins`, `backups` e `logs` não são destinos
permitidos no pacote de atualização. A fonte escolhida e a preferência de
consulta ficam em `configs/nexus-updates.json`.

## Recuperação

Antes de substituir arquivos, o helper guarda os originais em
`.nexus-updates/history/<identificador>/original`. Uma falha durante a troca
provoca uma tentativa automática de restaurar os arquivos já substituídos.
Depois de uma atualização concluída, o botão **Restaurar anterior** permite
reverter os arquivos do programa. Ele também exige os servidores parados.
Os backups do atualizador são diferentes dos backups dos jogos e não são
apagados automaticamente.

Se uma falha exigir recuperação manual, o caminho do backup é informado na
mensagem de erro. O registro da última operação fica em
`.nexus-updates/result.txt` e é exibido no registro de eventos do aplicativo.
Interrupções de energia ou encerramento forçado do helper podem exigir essa
recuperação manual.

## Publicar a próxima versão

1. Aumente `AssemblyVersion` e `AssemblyFileVersion` no projeto e o rótulo de
   versão da barra lateral. Compile com `Compilar.cmd`.
2. Prepare uma pasta do programa contendo os binários novos e os arquivos de
   distribuição. Nunca use uma pasta com dados privados como fonte de publicação.
3. Escreva as novidades em um arquivo de texto UTF-8.
4. Execute o script abaixo. Sem `-Publish`, ele apenas prepara os arquivos locais.

```powershell
.\build-tools\Publicar-Atualizacao.ps1 `
  -ProgramDirectory 'C:\Nexus-nova-versao' `
  -Repository 'fabriciodba/nexus-server-manager' `
  -ReleaseNotesFile 'C:\publicacao\novidades.txt' `
  -OutputDirectory 'C:\publicacao\arquivos' `
  -Publish
```

O GitHub CLI precisa estar instalado e autenticado na conta com acesso ao
repositório. Nenhum token é distribuído no aplicativo. O script cria a release
como rascunho, envia o manifesto `nexus-update.json` e os arquivos identificados
por SHA-256, e só depois torna a versão pública e mais recente. Não reutilize
o mesmo número de versão para alterar uma release já publicada.

O parâmetro opcional `-AdditionalAssets` permite anexar os ZIPs do programa e
do código-fonte. O manifesto oferece apenas arquivos do programa permitidos
pela lista do atualizador. Os arquivos em `bin` aceitos são `.dll`, `.exe`,
`.config`, `.json`, `.pdb` e `.rsp`; arquivos de tamanho zero são ignorados.

## Validar mudanças no atualizador

```powershell
.\build-tools\Test-Updates.ps1 -Executable '.\compilado\NexusServerManager.exe'
```

Os testes cobrem atualização incremental, validação de manifesto, preservação
de dados, corrupção, interrupção, cancelamento, destino bloqueado e rollback.
`Test-UpdateHelper.ps1` também verifica o processo separado e a reabertura em
uma pasta de teste nova. Para esse teste sem UAC, forneça uma compilação de
teste com manifesto `asInvoker`; a distribuição normal mantém o manifesto de
administrador.

## Pacote enxuto a partir da versao 1.0.5

Depois de `Compilar.cmd`, execute `Empacotar.cmd`. O pacote em `distribuicao`
contem apenas o executavel, sua configuracao, o guia e as licencas.
As bibliotecas de compatibilidade ficam embutidas. MahApps, Roslyn e Newtonsoft
sao extraidos na primeira abertura; SteamCMD e baixado ao instalar um jogo
que o utiliza. Nao inclua as pastas criadas durante o uso no pacote de publicacao.
A pasta limpa gerada por Empacotar.cmd pode ser usada no parametro
`-ProgramDirectory` do script Publicar-Atualizacao.ps1.
