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
Dependendo da versão do matlab e do opencv utilizadas esse valor pode variar e gerar agrupamentos diferentes para o mesmo limiar. Varie entre limiares de 0.25 a 0.35 para obter o resultado desejado.

Se não quiser regerar as features e utilizar as que foram geradas no projeto, faça o download das mesmas no link: [https://drive.google.com/drive/folders/1pPgOgs3SepgIjjaUx2m7Fl0q9Y5XXada?usp=sharing](https://drive.google.com/drive/folders/1pPgOgs3SepgIjjaUx2m7Fl0q9Y5XXada?usp=sharing) o link contém um .mat para cada frame agrupado. No link [https://drive.google.com/file/d/1Pct7_37W4ji4_q3aEec7Dhk8JgP-0XNH/view?usp=sharing](https://drive.google.com/file/d/1Pct7_37W4ji4_q3aEec7Dhk8JgP-0XNH/view?usp=sharing) há um .mat com a estrutura informando quais os índices originais dos frames agrupados e no link [https://drive.google.com/drive/folders/1uPQIJJ8fTzS3YHLev-oRvh6-wGdRjems?usp=sharing](https://drive.google.com/drive/folders/1uPQIJJ8fTzS3YHLev-oRvh6-wGdRjems?usp=sharing) é possível baixar também os mapas de fixação individuais e de grupo originais e agrupados utilizando os mesmos indíces. 

### 2. Geração de mapas de fixação
As funções que estão na pasta Aux_Methods geram os mapas de fixação. 

O arquivo montaFixacao.m lê os dados do xlsx de saida do Tobii e salva as fixações de cada participante em .mat.
O arquivo generateFixations.m lê os .mat salvos e gera os mapas de fixação individuais e por grupo.
O arquivo consolida.m dentro da pasta FixationMaps agrupa os mapas de fixação de acordo com a lista de índices de frames agrupados geradas na etapa anterior. Lembre-se de checar as variáveis que indicam o grupo, paths e quantidades de indivíduos.


### 3. Seleção de features
Há dois métodos de seleção disponíveis: relieff e Algoritmo Genético. A implementação com algoritmo genético não está retornando bons resultados, é necessário trocar a implementação. 
Atualmente a seleção de caracteristicas é feita durante o processo de validação cruzada ao se chamar a função trainAndTestModel, o parâmetro select define se vão ser utilizadas direto as features utilizadas no projeto (0), se será selecionado com relieff (1), com algoritmo genético (2) ou todas as variáveis.

Há uma pequena diferença nas features que estão no código e nas descritas na dissertação, as que retornam um resultado melhorado estão no código.

### 4. Treinamento dos modelos de atenção visual

Os modelos são treinados no arquivo trainAndTestModel. Atualmente há 3 opções de algoritmos para treinamento: redes neurais, svm e regressão logística.

### 5. Definição do critério de classificação de TEA

O arquivo execClass.m já realiza a validação cruzada com o treinamento do modelo, incluindo a etapa de seleção de variáveis e avalia se ao comparar o mapa gerado pelo modelo com os mapas individuais é possível classificar um indivíduo corretamente como TEA ou DT. Para isso compara todos os frames de um indivíduo e cria a curva ROC. A partir da curva ROC é possível aplicar o método de Youden para definir o threshold de quantos frames são necessários para essa classificação.


## Possíveis diferenças de resultados obtidos entre o código atual e o publicado na dissertação:
Como citado antes, podem ocorrer diferenças nos resultados obtidos. Um dos motivos é que não foram salvas as versões utizadas no projeto original. Por isso, principalmente na parte de agrupamento de movimento, teste alguns limiares diferentes.
Outro é que houve uma confusão nos índices das features dos resultados descritos, as features que geram melhores resultados são as que estão cravadas no arquivo trainAndTestModel na opção 0 do select, variável que define a técnica de Seleção de features.

## TODO - Melhorias sugeridas
- [ ] Revisar e reorganizar o código de geração de mapas

- [ ] Separar a etapa de treinamento em seleção de features, treinamento dos modelos e definição do critério de classificação de TEA

- [ ] Limpar arquivos não utilizados

- [ ] Corrigir o código de seleção de features de algoritmo genético

- [ ] Trocar o agrupamento de features para ser realizado com um algoritmo de similaridade de imagens (como ssim) ao invés de limiar de movimento



## Caso utilize este projeto, favor citar os responsáveis:

COLOCAR CITACAO DO ARTIGO AQUI!







