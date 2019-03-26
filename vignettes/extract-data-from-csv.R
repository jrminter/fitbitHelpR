## ---- echo=FALSE---------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warning=FALSE, comment=NA)
# suppressWarnings(suppressMessages(suppressPackageStartupMessages(library(dplyr))))

## ----getCsvFile----------------------------------------------------------

inF <- system.file("extdata", "2019-01.csv", package = "fitbitHelpR")
lines <- readLines(inF) 
length(lines)

## ----l1to5, echo=FALSE---------------------------------------------------
for (i in seq(from=1, to=5)){
  print(lines[i])
}

## ----l34to50, echo=FALSE-------------------------------------------------
for (i in seq(from=34, to=50)){
  print(lines[i])
}

## ----l67to72,echo=FALSE--------------------------------------------------

for (i in seq(from=67, to=72)){
  print(lines[i])
}


## ---- message=FALSE------------------------------------------------------
library(fitbitHelpR)
tbl <- extract_fitbit_activity_data(inF)
tbl



