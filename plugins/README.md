# Plugins do Nexus

Catálogo de jogos do Nexus Server Manager, disponível a partir da versão **1.0.9**.

No aplicativo, abra **Plugins → Catálogo de jogos**, selecione o jogo e clique em **Instalar plugin**. Depois abra **Novo servidor** para baixar os arquivos do servidor de jogo.

**Ajuda → Atualizações do Nexus** também consulta o catálogo e informa as novas versões dos plugins instalados por ele. As versões dos plugins são independentes da versão do Nexus: um novo jogo pode ser publicado aqui sem recompilar o programa. O download é feito somente para o plugin selecionado.

## Publicar um jogo ou uma atualização

Para plugins novos no Nexus **1.0.12 ou superior**, use `namespace Nexus.Plugins`, `using Nexus;` e `using Nexus.Engine;`. Por exemplo, a classe pública `MeuJogo` no arquivo `MeuJogo.cs` será `Nexus.Plugins.MeuJogo`. O construtor recebe `Nexus.ServerConfig` e deve aceitar `null` durante a leitura dos metadados. Defina `MinimumNexusVersion` como `1.0.12` ou superior. Plugins existentes no formato antigo continuam compatíveis; não é necessário republicá-los apenas por essa mudança.

1. Crie `plugins/sources/<id>/` com `metadata.json`, o arquivo `<EntryPoint>.cs` e `LICENSE.txt`. Use `rsdragonwilds` como exemplo.
2. Informe nome, versão, versão mínima do Nexus, descrição, instruções, autor, origem e licença em `metadata.json`.
3. Compile e confira o carregamento do plugin no Nexus. Registre nas notas o que foi validado.
4. Execute `python plugins/tools/build_catalog.py` na raiz do repositório. Ele gera o pacote ZIP e atualiza `plugins/catalog.json` com tamanho e SHA-256.
5. Revise e envie as alterações para `main`. O próximo acesso ao catálogo já verá a novidade.

Para atualizar um plugin, aumente `Version` antes de gerar o pacote. Não substitua o ZIP de uma versão publicada. Preserve os pacotes antigos: instalações que já consultaram o catálogo ainda podem precisar deles. Se uma mudança exigir um Nexus mais recente, aumente `MinimumNexusVersion`.

Os pacotes ficam nesta pasta e **não são anexados às releases do software**, que continuam oferecendo apenas o ZIP do Nexus.

## Instalação e dados

Pare os servidores antes de instalar ou substituir um plugin. O Nexus confere o SHA-256, o conteúdo do ZIP e o carregamento do código antes da troca. Arquivos locais adicionais são preservados e a pasta anterior fica em `.nexus-plugins/history`. Servidores, configurações e mundos permanecem em suas pastas.

Plugins importados manualmente aparecem como manuais; ao instalar a versão do catálogo, ela passa a ser acompanhada por ele. Alterações manuais no código também são indicadas e a cópia anterior é preservada quando ele é substituído.

Download manual: extraia o ZIP de `packages/<id>/<versão>.zip` para a pasta `plugins` da instalação e use **Plugins → Recarregar**.

Cada plugin tem sua própria licença, incluída no código-fonte e no pacote. O plugin inicial de Dragonwilds é distribuído sob MIT com os avisos de seu autor preservados. As notas descrevem a validação realizada; a presença no catálogo não significa que uma instalação real do servidor já foi testada.
