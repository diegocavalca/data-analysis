setwd('/Volumes/Toshiba/Github/data-science/bibliometric-analysis/src/')
library(bibliometrix)

D <- readLines("scopus2.bib")
M <- convert2df(D, dbsource = "scopus", format = "bibtex")

### (grafico) Processar resultados bibliometricos
results <- biblioAnalysis(M, sep = ";")
#plot(x = results, k = 10, pause = FALSE)
View(results$Authors)


convert2dataframe <- function(file, dbsource = "isi", format = "bibtex") 
{
  if (length(setdiff(dbsource, c("isi", "scopus"))) > 0) {
    cat("\n 'dbsource' argument is not properly specified")
    cat("\n 'dbsource' argument has to be a character string matching 'isi or 'scopus'.\n")
  }
  if (length(setdiff(format, c("plaintext", "bibtex"))) > 0) {
    cat("\n 'format' argument is not properly specified")
    cat("\n 'format' argument has to be a character string matching 'plaintext or 'bibtex'.\n")
  }
  #file = iconv(file, "latin1", "ASCII", sub = "")
  switch(dbsource, isi = {
    switch(format, bibtex = {
      M = isibib2df(file)
    }, plaintext = {
      M = isi2df(file)
    })
  }, scopus = {
    M = scopus2df(file)
  })
  M$PY = as.numeric(M$PY)
  M$TC = as.numeric(M$TC)
  if ("AU" %in% names(M)) {
    M$AU = gsub(",", " ", M$AU)
    AUlist = strsplit(M$AU, ";")
    AU = lapply(AUlist, function(l) {
      l = trim(l)
      name = strsplit(l, " ")
      lastname = unlist(lapply(name, function(ln) {
        ln[1]
      }))
      firstname = lapply(name, function(ln) {
        f = paste(substr(ln[-1], 1, 1), collapse = " ")
      })
      AU = paste(lastname, unlist(firstname), sep = " ", 
                 collapse = ";")
      return(AU)
    })
    M$AU = unlist(AU)
  }
  return(M)
}

bibliometricAnalysis <- function (M, sep = ";") 
{
  Authors = NULL
  Authors_frac = NULL
  FirstAuthors = NULL
  PY = NULL
  FAffiliation = NULL
  Affiliation = NULL
  Affiliation_frac = NULL
  CO = rep(NA, dim(M)[1])
  TC = NULL
  TCperYear = NULL
  SO = NULL
  Country = NULL
  DE = NULL
  ID = NULL
  MostCitedPapers = NULL
  Tags <- names(M)
  if ("PY" %in% Tags) {
    Years = table(PY)
  }
  if ("AU" %in% Tags) {
    listAU = strsplit(as.character(M$AU), sep)
    listAU = lapply(listAU, function(l) trim.leading(l))
    listAU = lapply(listAU, function(l) {
      l = trim.leading(l)
      l = sub(" ", ",", l, fixed = TRUE)
      l = sub(",,", ",", l, fixed = TRUE)
      l = gsub(" ", "", l, fixed = TRUE)
    })
    nAU = unlist(lapply(listAU, length))
    fracAU = unlist(sapply(nAU, function(x) {
      rep(1/x, x)
    }))
    AU = gsub(" ", "", unlist(listAU), fixed = TRUE)
    Authors = sort(table(AU), decreasing = TRUE)
    Authors_frac = aggregate(fracAU, by = list(AU), "sum")
    names(Authors_frac) = c("Author", "Frequency")
    Authors_frac = Authors_frac[order(-Authors_frac$Frequency), 
                                ]
    FirstAuthors = lapply(listAU, function(l) l[[1]])
    listAUU = strsplit(as.character(M$AU[nAU > 1]), sep)
    AuMultiAuthoredArt = length(unique(gsub(" ", "", unlist(listAUU), 
                                            fixed = TRUE)))
  }
  if ("TC" %in% Tags) {
    TC = as.numeric(M$TC)
    PY = as.numeric(M$PY)
    CurrentYear = as.numeric(format(Sys.Date(), "%Y"))
    TCperYear = TC/(CurrentYear - PY)
    if (sum(names(M) %in% "JI") == 1) {
      MostCitedPapers = data.frame(paste(M$AU, paste("(", 
                                                     M$PY, ")", sep = ""), M$JI, sep = ","), TC, TCperYear)
    }
    else {
      MostCitedPapers = data.frame(paste(M$AU, paste("(", 
                                                     M$PY, ")", sep = ""), M$SO, sep = ","), TC, TCperYear)
    }
    MostCitedPapers = MostCitedPapers[order(TC, decreasing = TRUE), 
                                      ]
    names(MostCitedPapers) = c("Paper         ", "TC", "TCperYear")
  }
  if ("CR" %in% Tags) {
    CR = tableTag(M, "CR", sep)
  }
  if ("ID" %in% Tags) {
    ID = tableTag(M, "ID", sep)
  }
  if ("DE" %in% Tags) {
    DE = tableTag(M, "DE", sep)
  }
  if ("SO" %in% Tags) {
    SO = gsub(",", "", M$SO, fixed = TRUE)
    SO = sort(table(SO), decreasing = TRUE)
  }
  if (("C1" %in% Tags) & (sum(!is.na(M$C1)) > 0)) {
    AFF = gsub("\\[.*?\\] ", "", M$C1)
    listAFF = strsplit(AFF, sep, fixed = TRUE)
    nAFF = unlist(lapply(listAFF, length))
    listAFF[nAFF == 0] = "NA"
    fracAFF = unlist(sapply(nAFF, function(x) {
      rep(1/x, x)
    }))
    AFF = trim.leading(unlist(listAFF))
    Affiliation = sort(table(AFF), decreasing = TRUE)
    Affiliation_frac = aggregate(fracAFF, by = list(AFF), 
                                 "sum")
    names(Affiliation_frac) = c("Affiliation", "Frequency")
    Affiliation_frac = Affiliation_frac[order(-Affiliation_frac$Frequency), 
                                        ]
    FAffiliation = lapply(listAFF, function(l) l[1])
    data("countries", envir = environment())
    countries = as.character(countries[[1]])
    if (M$DB[1] == "SCOPUS") {
      FA = paste(FAffiliation, ";", sep = "")
      RP = paste(M$RP, ";", sep = "")
      countries = as.character(sapply(countries, function(s) paste0(s, 
                                                                    ";", collapse = "")))
    }
    else if (M$DB[1] == "ISI") {
      FA = FAffiliation
      RP = paste(M$RP, ".", sep = "")
      countries = as.character(sapply(countries, function(s) paste0(s, 
                                                                    ".", collapse = "")))
    }
    for (i in 1:length(countries)) {
      ind = which(regexpr(countries[i], FA, fixed = TRUE) != 
                    -1)
      if (length(ind) > 0) {
        CO[ind] = countries[i]
      }
      indd = which(regexpr(countries[i], RP, fixed = TRUE) != 
                     -1)
      if (length(indd) > 0) {
        CO[indd] = countries[i]
      }
    }
    CO = gsub(";", "", CO)
    CO = gsub("\\.", "", CO)
    CO = gsub("UNITED STATES", "USA", CO)
    Country = sort(table(CO), decreasing = TRUE)
  }
  results = list(Articles = dim(M)[1], Authors = Authors, AuthorsFrac = Authors_frac, 
                 FirstAuthors = unlist(FirstAuthors), nAUperPaper = nAU, 
                 Apparences = sum(nAU), nAuthors = dim(Authors), AuMultiAuthoredArt = AuMultiAuthoredArt, 
                 MostCitedPapers = MostCitedPapers, Years = PY, FirstAffiliation = unlist(FAffiliation), 
                 Affiliations = Affiliation, Aff_frac = Affiliation_frac, 
                 CO = CO, Countries = Country, TotalCitation = TC, TCperYear = TCperYear, 
                 Sources = SO, DE = DE, ID = ID)
  class(results) <- "bibliometrix"
  return(results)
}