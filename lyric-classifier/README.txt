=== LYRIC CLASSIFIER ===

O modelo desenvolvido, utilizando classificador Naive Bayes Multinomial, obteve 91.25% de acurácia no conjunto de testes.

Os arquivos do projeto estão organizador da seguinte forma:

-> 'input': diretório contendo os dados que foram utilizados no processo de criação do modelo, incluindo os conjuntos de treino 'X_train.dat'/'y_train.dat' e testes 'X_test.dat'/'y_test.dat', utilizados no processo de verificação de acurácia do classificador resultante, extraídos numa proporção 90 e 10% dos dados originais, respectivamente.
-> 'notebooks': contém os notebooks produzidos para a exploração dos dados e elaboração do classificador. Estes notebooks contém TODO O DETALHAMENTO dos processos conduzidos neste projeto, inclusive as análises, conclusões e trabalhos futuros, sendo que os notebooks devem ser lidos na ordem:
	1. analysis.ipynb
	2. model.ipynb
	3. webapp.ipynb (opcional, apenas testes para produção do webapp flask)
-> 'resources': arquivos utilizados e/ou criados durante processo de criação do modelo e execução no webapp flask.
-> 'static': arquivos de customização do layout (css, js) do webapp flask construído.
-> 'templates': arquivos html do webapp.

WEBAPP: Para a execução do webapp flask contruído, deve ser seguidos os seguintes passos:
	1. Instalar o Python 3.6.1 ou superior no computador, bem como os pacotes descritos no arquivo requirements.txt (ou instalar a distribuição Anaconda e o pacote adicional 'wtforms')
	2. Após extrair a pasta 'lyric-classifier' no computador, executar o seguinte comando no terminal:
		'python PATH/lyric-classifier/app.py'
	3. Acessar o endereço informado no prompt de comando no navegador, resultante da etapa anterior (em geral, http://127.0.0.1:5000)

OBSERVAÇÕES IMPORTANTES: 
	1. O webapp desenvolvido também está disponível no endereço https://lyric-classifier.herokuapp.com/
	2. Os arquivos estão disponíveis também no Github, em https://github.com/diegocavalca/data-science/tree/master/lyric-classifier