# Nexus Server Manager

Gerenciador de servidores de jogos para Windows.

**[Baixar o software para Windows](https://github.com/ElorinDev/nexus-server-manager/releases/latest)**

Na página da versão, baixe o único ZIP do programa. Extraia a pasta e execute `NexusServerManager.exe`.

Requer Windows de 64 bits e .NET Framework 4.7.2 ou superior.

As próximas versões podem ser instaladas em **Ajuda → Atualizações do Nexus**. Pare os servidores antes de atualizar.

**Migração para a 1.0.11:** se usa a 1.0.10 ou anterior, baixe o ZIP novo uma vez, feche o Nexus e substitua os cinco arquivos do programa, preservando as pastas de dados. Depois, as atualizações continuam pelo aplicativo.

[Licença do Nexus](LICENSE). Os avisos dos componentes incorporados acompanham o software em `AVISOS.txt`.

## Catálogo de jogos

A partir do Nexus **1.0.9**, abra **Plugins → Catálogo de jogos** para instalar e atualizar os plugins disponíveis. Começamos por **RuneScape: Dragonwilds**. Depois de instalar o plugin, use **Novo servidor** para baixar o servidor do jogo.

A tela de atualização do Nexus também consulta novidades dos plugins instalados pelo catálogo. Os plugins têm versões próprias: novos jogos e correções podem ser publicados sem recompilar o aplicativo.

[Catálogo, downloads e instruções de publicação](plugins/README.md). Cada plugin inclui sua própria licença e notas de validação.
## Atualizações públicas e arquivo técnico privado

A partir da **1.0.11**, o software continua disponível para qualquer usuário e as atualizações não exigem login no GitHub. O Nexus consulta a versão publicada e baixa o mesmo ZIP oferecido na release, conferindo sua integridade antes de instalar. O código-fonte do aplicativo e os arquivos técnicos ficam em um repositório privado.

A página de cada release continua oferecendo somente o ZIP do software como anexo. Os plugins do catálogo mantêm suas próprias licenças e publicações.
