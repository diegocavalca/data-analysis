# COGNITIVO.AI - TESTE TÉCNICO

Análise da qualidade de vinhos com *Machine Learning*.

## QUESTÕES

**a. Como foi a definição da sua estratégia de modelagem?**

R: Conforme explicado no notebook, o processo de Análise Exploratória de Dados (EDA, do inglês *Exploratory Data Analysis*) forneceu insights significativos sobre o dataset, suas característias, inconsistências e potenciais. Assim, a modelagem tomou como base o Oversamplig dos dados, a fim de lidar com o forte desbalanceamento de classes existentes. Ainda, a engenharia de atributos adotada envolveu etapas de Codificação One-hot (variável categórica 'Type') e Centralização dos dados, de modo que se buscou construir um pipeline de pré-processamento que viabilizasse a construção de um modelo classificador baseado em Machine Learning eficiente para o problema em questão.

Após o pré-processamento, e análise de diferentes abordagens de classificadores (uma vez que tratamos o problema de análise de classificador como uma saída discreta), avaliamos um conjunto de 5 diferentes algoritmos supervisionados utilizando Validação Cruzada (com 10 folds), que validaram a modelagem desenvolvida.

**b. Como foi definida a função de custo utilizada?**

R: A função de custo escolhida para o modelo final de Floresta Aleatória foi a 'entropia' ([*entropy*](https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html), que mensura o ganho de informação obtido no processo de estruturação/split das árvores), a qual foi definida analiticamente através do método de pesquisa em grade aleatorizada (RandomizedSearchCV), onde se avaliou a melhor combinação possível de hiperparâmetros - incluindo a função de custo - em um conjunto discreto de opções.

Apesar do viés analítico da escolha, cabe destacar que, conforme [1], a função de custo em si tem pouco efeito prático para esta classe de algoritmo em questão, uma vez que o custo em si é uma medida de impureza da amostragem que está sendo avaliada em cada nó, e todas as métricas são bastante consistentes, em geral; todavia, uma estratégia mais efetiva é escolher cuidadosamente o método de poda das árvores de decisão, o qual tem maior impacto na qualidade do modelo final.

**c. Qual foi o critério utilizado na seleção do modelo final?**

R: A avaliação dos modelos foi feita com base na métrica *F1-Score*, uma vez que o objetivo era avaliar o desempenho do modelo na perspectiva de seus acertos (Precisão) e seus erros (*Recall*), tanto de maneira geral (todas as classes) quanto individual (para cada classe - *classification_report*).
Assim, conforme detalhado no notebook, o modelo final foi escolhido a partir de um benchmarking com modelos concorrentes que foram avaliados sob as mesmas condições utilizando Validação Cruzada. A partir do momento da escolha do melhor modelo, o mesmo foi submetido a um *RandomizedSearchCV* (pesquisa em grade aleatorizada) de seus hiperparâmetros, que visou definir "o modelo 'ótimo'", o qual foi avaliado novamente com Validação Cruzada K-folds e Split de Treino/Teste.

**d. Qual foi o critério utilizado para validação do modelo? Por que escolheu utilizar este método?**

R: Foi escolhido a Validação cruzada com 10-folds, uma vez que esta estratégia consegue mensurar com integridade a robustez do modelo, garantindo uma avaliação completa a cerca da generalização do modelo.

**e. Quais evidências você possui de que seu modelo é suficientemente bom?**

R: A partir da combinação da Validação Cruzada com K-folds e a métrica F1-Score, o modelo obteve um desempenho médio final `~89,6%` para <u>TODO</u> o conjunto de dados (10-folds CV) e `~95%` no conjunto de teste, fatores que - em geral - podem indicar um resultado suficientemente "bom", . Todavia, ainda há muitas alternativas que potencialmente poderiam otimizar os resultados, através de estratégias mais avançadas, tais como:

	1. Pré-processamento mais completo (redução da dimensionalidade, clustering, permutação de atributos, etc.);
	2. Otimização mais fina de hiperparâmetros;
	3. Avaliar modelos mais complexos (Ensembles Hierárquicos, XGboost, e Redes neurais, por exemplo);
	4. Adotar threshold de confiança nas sugestões do modelo (automatizar apenas classificações nas quais o modelo possui "confiança"/probabilidade > C em sua sugestoes - mitigando o risco de erros da IA);

Porém, é importante ressaltar que o **critério de aceitação** - ou definição de "bom" - é subjetivo, devendo ser definido cuidadosamente junto ao <u>cliente e especialistas no domínio</u> de aplicação, a fim de que se entenda por completo os interesses do projeto e os riscos envolvidos nas sugestões do modelo de ML/IA.

## REFERÊNCIAS:

	[1] Introduction to Data Mining, 2005. Disponível em https://www-users.cs.umn.edu/~kumar001/dmbook/
	[2] https://scikit-learn.org/stable/user_guide.html
	[3] https://towardsdatascience.com/a-deep-dive-into-imbalanced-data-over-sampling-f1167ed74b5
	[4] https://scikit-learn.org/stable/auto_examples/model_selection/plot_randomized_search.html
	[5] https://machinelearningmastery.com/how-to-tune-algorithm-parameters-with-scikit-learn/