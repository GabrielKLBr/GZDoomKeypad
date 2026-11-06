# Compatibilidade

## Verificações da versão inicial

A colocação dos painéis foi verificada nos 36 mapas do Ultimate Doom. Todos os acessos identificados passaram nos episódios 1, 2 e 3 e em sete dos nove mapas do episódio 4. A E1M3 está incluída nessa verificação.

Os testes funcionais também verificaram códigos diferentes em duas portas da mesma cor, rejeição de senhas cruzadas, confirmação ao soltar, buzz e fechamento no erro, leitura pausada do papel e sons do keypad.

## Limitações conhecidas

- **E4M2 e E4M8:** algumas entradas de mecanismos de barras ainda não recebem painel. Os demais acessos reconhecidos desses mecanismos podem ter painéis; não há garantia de disponibilidade em todos os lados nesses dois mapas.
- Portas inteiramente controladas por scripts ACS, chaves compostas ou classes de outros mods não são convertidas automaticamente.
- Portais, pisos 3D e áreas sem uma superfície fixa adequada podem exigir ajuste específico.
- Somente single-player.

A geração usa as ações de fechadura padrão e a geometria dos setores, sem uma lista de nomes de mapas. Isso permite seu uso em mapas personalizados Doom, Hexen e UDMF, respeitando as limitações acima.

Ao adicionar o mod ou trocar de versão, inicie uma fase/partida nova para gerar os painéis. Saves antigos mantêm os atores já existentes.
