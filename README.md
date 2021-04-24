# Modelo de atenção para classificação de TEA

Algoritmo desenvolvido com base na dissertação de mestrado ["Classificador para auxílio ao diagnóstico de TEA baseado em um modelo computacional de atenção visual"](https://www.teses.usp.br/teses/disponiveis/100/100131/tde-01022018-100042/publico/Corrigida_Jessica_Oliveira.pdf)

## Pre-requisitos:
Se desejar extrair características é necessário ter instalado:
- Módulo opencv e opencv-contrib
- Mexopencv: https://github.com/kyamagu/mexopencv
*importante garantir que a versão dos dois esteja casada*

- Se desejar extrair as características de Itti usadas no projeto origial é necessário garantir que a versão do **Matlab seja 2011 ou anterior**, caso não tenha acesso a essa versão comente a linha 27 do arquivo ExtractFeatures/saliency.m que gera essas características. Lembre-se de posteriormente eliminiar as posições que ficaram zeradas do vetor de features.

*Dica: para facilitar a execução do projeto, ao abrir o Matlab no painel que exibe os arquivos clique com o botáo direito em cima da pasta do projeto e vá em Add Path -> Folders and Subfolders. Ou use a função add_path do matlab*

## Pipeline de execução

### 1. Extração de features:
Para extrair as características dos estimulos visuais chame a função extractAllFeatues passanda a pasta que contem os frames e a pasta onde devem ser gerados os outputs.

Caso queira utilizar os frames originais, eles estão disponíveis no link: https://drive.google.com/drive/folders/1lCDPIFWNmFfNHUsYWU_L3VVXxx6BIDWU?usp=sharing

**Importante:** caso troque os frames, lembre-se de atualizar as variáveis no início do código que definem início e fim de frame e se o movimento biológico está a esquerda ou direita.

O código de extração é dividido em 4 etapas:
- Primeira etapa: gerar características de saliencia por frame. Essas características são baseadas no projeto anterior desenvolvido por Judd;
- Segunda etapa: gera features que variam de acordo com a lateralidade do frame. São basicamente as features de movimento geométrico e biológico;
- Terceira etapa: Calcula features de centro das cenas e da tela;
- Quarta e última etapa: realiza o agrupamente de frames de acordo com o valor da média de movimento entre frames.

### 2. Geração de mapas de fixação


### 3. Seleção de features


### 4. Treinamento dos modelos de atenção visual


### 5. Definição do critério de classificação de TEA


## Exemplos de arquivo de execução geral

- O arquivo XXXX reproduz o pipe completo deste projeto.


## Caso utilize este projeto, favor citar os responsáveis:

COLOCAR CITACAO DO ARTIGO AQUI!







