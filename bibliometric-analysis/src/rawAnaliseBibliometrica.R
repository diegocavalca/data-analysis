### Preparando o ambiente...
diretorio <- dirname(sys.frame(1)$ofile)
setwd(diretorio)

### Pacotes necessários...
# Principais
library(bibliometrix)

### Carregar base de dados bibliométrica
D <- readLines("scopus.bib")
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

### (grafico) Processar resultados bibliometricos
results <- biblioAnalysis(M, sep = ";")
plot(x = results, k = 10, pause = FALSE)

### (console) Resumo dos resultados 
S <- summary(object = results, k = 10, pause = FALSE)

### (console/viewer) PAPERS mais citados no conjunto
CR_Papers = citations(M, field = "article", sep = ";")
CR_Papers <- as.data.frame(CR_Papers$Cited[1:10])
names(CR_Papers) <- c('Paper', 'Citations')
CR_Papers
View(CR_Papers)

### (console/viewer) AUTORES mais citados no conjunto
CR_Authors = citations(M, field = "author", sep = ";")
CR_Authors <- as.data.frame(CR_Authors$Cited[1:10])
names(CR_Authors) <- c('Author', 'Citations')
CR_Authors
View(CR_Authors)

### (console/viewer) Fator de dominância de autores (razao entre primeira autoria e multiautoria)
DF <- dominance(results, k = 10)
DF
View(DF)

### (console/viewer) Tabela H-index por autores mais produtivos 
# Obs.: H-index = número de artigos com citações maiores ou iguais a esse número
authors = gsub(",", " ", names(results$Authors)[1:10])
indices <- Hindex(M, authors, sep = ";", years=10)
HI <- indices$H
HI
View(HI)

########## Bibliometric network matrices ##########
# Manuscript’s attributes are connected to each other through the manuscript 
# itself: author(s) to journal, keywords to publication date, etc.
# These connections of different attributes generate bipartite networks that 
# can be represented as rectangular matrices (Manuscripts x Attributes).
########## Bibliometric network matrices ##########

# (grafico) Rede de colaboracao por pais
M <- metaTagExtraction(M, Field = "AU_CO", sep = ";")
NetMatrix <- biblioNetwork(M, analysis = "collaboration", network = "countries", sep = ";")
networkPlot(NetMatrix, n = 20, Title = "Country Collaboration", type = "circle", size=TRUE, remove.multiple=FALSE)

# (grafico) Rede de co-ocorrencias de palavras-chave (20 keywords)
NetMatrix <- biblioNetwork(M, analysis = "co-occurrences", network = "keywords", sep = ";")
networkPlot(NetMatrix, n = 20, Title = "Keyword Co-occurrences", type = "kamada", size=T)