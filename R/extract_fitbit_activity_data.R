#' Extract activity data
#' 
#' Extract the activity data from a very messy "csv" file exported
#' from the FitBit web site
#' 
#' @param csvFileName The path to the .csv file with activity data
#' 
#' @return a tibble
#' 
#' @export
#' 
#' @examples
#' 

extract_fitbit_activity_data<- function(csvFileName){
  lines <- readLines(csvFileName)
  # Find the first Sleep line. I don't enter any so all 0
  idSleep<- grep("Sleep", lines)[1]
  # Find the first Activities line
  idActivities <- grep("Activities", lines)[1]
  lengthActivites = idSleep-idActivities
  tbl <- as.tbl(read.table(csvFileName, header=TRUE,
                           skip = idActivities,
                           nrow = lengthActivites-4,
                           sep=','))
  names(tbl) <- c("Date","BurnCals","Steps","Distance","Floors",
                  "SedentaryMins","LtActiveMins", "MedActiveMins",
                  "VeryActiveMins","ActiveCals")
  tbl$Date <- as.Date(tbl$Date)
  tbl$BurnCals <- as.numeric(tbl$BurnCals)
  tbl$ActiveCals <- as.numeric(tbl$ActiveCals)
  tbl$Steps <- as.numeric(tbl$Steps)
  tbl$SedentaryMins <- as.numeric(tbl$SedentaryMins)
  return(tbl)
}

