# GZDoomKeypad

Mod para GZDoom que substitui cartões e caveiras de chave por folhas com senhas e acrescenta keypads às portas.

## Download e instalação

Baixe **[GZDoomKeypad.pk3](https://github.com/GabrielKLBr/GZDoomKeypad/releases/latest/download/GZDoomKeypad.pk3)** e carregue-o junto do seu IWAD no **GZDoom 4.14.2 ou superior**.

```text
gzdoom -iwad DOOM.WAD -file GZDoomKeypad.pk3
```

Funciona em single-player com Doom, Doom II e mapas compatíveis. Inicie uma fase ou partida nova ao adicionar o mod.

## Como jogar

- Pegue uma folha para ler os códigos. A leitura pausa a partida.
- Os códigos aparecem grandes e centralizados, sem identificar a cor ou a porta.
- Cada porta tem uma senha aleatória de quatro dígitos. Portas diferentes da mesma cor têm senhas diferentes; a folha apresenta esses códigos em ordem embaralhada.
- Procure o keypad em uma parede próxima à porta e pressione **Usar**. O mesmo código funciona nos painéis dos dois lados da mesma porta.
- O mundo continua em movimento enquanto o teclado está aberto.
- Segure uma tecla para ver sua imagem pressionada; o dígito só é registrado ao soltar. Soltar o mouse fora da tecla cancela essa entrada.
- **Confere** valida a senha: acerto abre a porta, toca o som de abertura e pisca a luz antes de fechar; erro toca o buzz e fecha o teclado. Confere não toca o clique comum.
- **X** apaga a entrada e fecha ao soltar. **Esc** também fecha.
- O papel coletado aparece como preview no canto inferior esquerdo. Use a roda do mouse ou as setas para mudar de página.
- Também é possível digitar os números pelo teclado.

As interfaces preservam a proporção das imagens dentro de uma área de até 65% da largura e da altura da tela.

## Sons

| Arquivo | Evento |
| --- | --- |
| `paper.mp3` | Coleta de uma folha |
| `keypadpress.mp3` | Pressão de uma tecla comum, acompanhada por um breve pulso verde |
| `keypadopen.mp3` | Senha correta e porta acionada |
| `buzz.mp3` | Senha incorreta |

Segurar uma tecla não repete o som nem o pulso da luz.

## Compatibilidade dos mapas

A colocação dos painéis usa a geometria dos acessos às portas, sem depender do nome da fase. A busca considera setores vizinhos conectados e paredes fixas, incluindo superfícies inferiores e superiores estáticas, e evita montar painéis nas folhas móveis das portas.

São reconhecidas as fechaduras padrão por cor em `Door_LockedRaise`, `Generic_Door` e `locknumber`, nos formatos de mapa Doom, Hexen e UDMF. Faces e barras acionadas pelo mesmo mecanismo compartilham o código desse mecanismo.

Portas inteiramente controladas por ACS, fechaduras compostas, classes de chave de outros mods e geometrias especiais sem uma parede disponível podem precisar de adaptação. Não há suporte a multiplayer.

**Limitação conhecida:** algumas entradas de barras em E4M2 e E4M8 ainda não recebem painel. Veja [compatibilidade e mapas verificados](docs/COMPATIBILITY.md).

## Compilar

No Windows, execute na pasta do projeto:

```powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\Build.ps1
```

O script converte a folha BMP, gera os glifos a partir de `DePixelHalbfett.ttf` e empacota `mod/` como **GZDoomKeypad.pk3**. Nenhum IWAD ou executável do GZDoom é incluído.

## Estrutura

- `mod/ZSCRIPT`: lógica das portas, senhas, interação e interfaces.
- `mod/MAPINFO`, `mod/TEXTURES` e `mod/SNDINFO`: registro do mod, sprites e sons.
- `mod/sounds/`: áudios do projeto.
- `sprites/`: recursos visuais originais.
- `DePixelHalbfett.ttf`: fonte usada nos papéis.
- `Build.ps1`: geração do pacote.

Projeto de **[GabrielKLBr](https://github.com/GabrielKLBr)**.
