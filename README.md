# Nexus Server Manager

Gerenciador de servidores de jogos para Windows.

**[Baixar o software para Windows](https://github.com/ElorinDev/nexus-server-manager/releases/latest)**

Na página da versão, baixe o único ZIP do programa. Extraia a pasta e execute `NexusServerManager.exe`.

Requer Windows de 64 bits e .NET Framework 4.7.2 ou superior.

As próximas versões podem ser instaladas em **Ajuda → Atualizações do Nexus**. Pare os servidores antes de atualizar.

**Migração do canal antigo:** se usa a 1.0.10 ou anterior, baixe o ZIP novo uma vez, feche o Nexus e substitua os cinco arquivos do programa, preservando as pastas de dados. Depois, as atualizações continuam pelo aplicativo.

[Licença do Nexus](LICENSE). Os avisos dos componentes incorporados acompanham o software em `AVISOS.txt`.

## Interface e navegação

Na versão **1.0.14**, a tela **Início** reúne a biblioteca, o console, os eventos e os ajustes do servidor selecionado. O menu **Automação**, à esquerda, permite escolher um servidor e configurar suas rotinas de início, recuperação, atualizações, backups, agenda e alertas.

Use o único botão **Novo servidor** para instalar um jogo. Para aproveitar arquivos existentes, escolha **Importar existente** dentro dessa tela. O card de sugestão e os atalhos repetidos de criação foram removidos.

## Catálogo de jogos

Abra **Plugins → Baixar plugins** para instalar e atualizar os plugins disponíveis no Nexus **1.0.13 ou superior**. O catálogo existe desde a versão 1.0.9. Começamos por **RuneScape: Dragonwilds**. Depois de instalar o plugin, use **Novo servidor** para baixar o servidor do jogo.

Na tela **Baixar plugins**, use **Verificar novidades** para consultar atualizações dos plugins instalados pelo catálogo. Os plugins têm versões próprias: novos jogos e correções podem ser publicados sem recompilar o aplicativo.

Novos plugins podem usar `Nexus.Plugins` e o SDK Nexus a partir da versão **1.0.12**. Os plugins existentes continuam compatíveis.

[Catálogo, downloads e instruções de publicação](plugins/README.md). Cada plugin inclui sua própria licença e notas de validação.
## Atualizações públicas e arquivo técnico privado

A partir da **1.0.11**, o software continua disponível para qualquer usuário e as atualizações não exigem login no GitHub. O Nexus consulta a versão publicada e baixa o mesmo ZIP oferecido na release, conferindo sua integridade antes de instalar. O código-fonte do aplicativo e os arquivos técnicos ficam em um repositório privado.

A página de cada release continua oferecendo somente o ZIP do software como anexo. Os plugins do catálogo mantêm suas próprias licenças e publicações.
