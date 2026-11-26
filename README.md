# Nexus Server Manager

Gerenciador local de servidores de jogos para Windows, com interface em português,
catálogo de instalação, console, plugins e atualizações pelo aplicativo.

## Instalar

Baixe o pacote **Nexus-Server-Manager-1.0.4.zip** na
[versão mais recente](https://github.com/fabriciodba/nexus-server-manager/releases/latest),
extraia a pasta completa e execute `NexusServerManager.exe`.
Requer Windows de 64 bits e .NET Framework 4.7.2 ou superior.

Esta é a primeira versão com o atualizador integrado. Instale-a uma vez.
Nas próximas versões, use **Ajuda > Atualizações do Nexus > Verificar agora > Atualizar agora**.
Pare os servidores e aguarde tarefas em andamento antes de aplicar uma atualização.

O atualizador baixa somente arquivos alterados, verifica SHA-256, guarda a versão
anterior e reabre o programa. Servidores, configurações, plugins, logs e backups
dos jogos são preservados. A verificação ao abrir pode ser desativada na mesma tela.

## Código-fonte e publicação

O ZIP **Nexus-Server-Manager-Fonte-1.0.4.zip** nas releases contém o projeto completo,
dependências, compilador e testes. Extraia e execute `Compilar.cmd`.

Consulte [ATUALIZACOES.md](ATUALIZACOES.md) para recuperação, testes e publicação.
O [script de publicação](build-tools/Publicar-Atualizacao.ps1) prepara o manifesto e
publica uma release completa antes de oferecê-la aos aplicativos instalados.

O manifesto utilizado pelo programa fica em
`https://github.com/fabriciodba/nexus-server-manager/releases/latest/download/nexus-update.json`.

## Licença

Adaptação do WindowsGSM v1.23.1, de TatLead e colaboradores, sob licença MIT.
Consulte [LICENSE](LICENSE). Os avisos das dependências acompanham os pacotes.
