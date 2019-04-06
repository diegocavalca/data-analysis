# FINCH LYRIC CLASSIFIER
---

Projeto desenvolvido durante o processo seletivo para a vaga de cientista de dados na Finch Soluções.

## INFORMAÇÕES GERAIS

O modelo desenvolvido, utilizando classificador Naïve Bayes Multinomial, obteve ~90% de acurácia no conjunto de testes. 

Para mais detalhes do pipeline de construção do modelo, visualizar os notebooks disponíveis no diretório 'notebooks'.

O webapp desenvolvido foi publicado e está disponível no endereço http://diegocavalca.pythonanywhere.com/

Além disso, os arquivos deste projeto estão disponíveis* também em minha conta no Github para melhor avaliação, em https://github.com/diegocavalca/data-science/tree/master/lyric-classifier.

## ESTRUTURA DE DIRETÓRIOS E ARQUIVOS

Os arquivos do projeto estão organizador da seguinte forma:

- 'input': diretório contendo os dados que foram utilizados no processo de criação do modelo, incluindo os conjuntos de treino 'X_train.dat'/'y_train.dat' e testes 'X_test.dat'/'y_test.dat', utilizados no processo de verificação de acurácia do modelo de ML.
- 'notebooks': contém os notebooks produzidos para a exploração dos dados e elaboração do classificador. Estes notebooks contém TODO O DETALHAMENTO dos processos conduzidos neste projeto, inclusive as análises, conclusões e trabalhos futuros, sendo que os notebooks devem ser lidos na ordem:
	1. data_analysis.ipynb => contempla a exploração de dados e estabelecimento de hipótese;
	2. machine_learning.ipynb => descreve o pipeline de construção e otimização do modelo;
	3. webapp.ipynb (opcional, apenas testes para produção do webapp flask).
- 'resources': arquivos utilizados e/ou criados durante processo de criação do modelo e execução no webapp flask.
- 'webapp': arquivos da aplicação web do Classificador de Gênero Musical;
	- 'webapp/static': arquivos de customização do layout (css, js) do webapp flask construído.
	- 'webapp/templates': arquivos html do webapp.

## EXECUÇÃO DO WEBAPP

Para a execução do webapp flask contruído, deve ser seguidos os seguintes passos:

	1. Instalar o Python 3.6.1 ou superior no computador (instalar a distribuição Anaconda), bem como os pacotes descritos no arquivo requirements.txt;

	2. Baixar e extrair os arquivos deste projeto em uma pasta no computador, executar o seguinte comando no terminal:
		'python PATH/webapp/app.py'

	3. Acessar o endereço informado no prompt de comando no navegador, resultante da etapa anterior (em geral, http://127.0.0.1:5000)

---
* Estarão disponíveis durante o tempo do processo seletivo; após a finalização, irei remover o diretório.
