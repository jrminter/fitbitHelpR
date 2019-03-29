#' Extract Fitbit sleep data
#' 
#' Extract the sleep data from a very messy "csv" file exported
#' from the FitBit web site
#' 
#' @param csvFileName The path to the .csv file with activity data
#' 
#' @param bVerbose Print warnings if TRUE. Default: False
#' 
#' @return a tibble
#' 
#' @import dplyr scales
#' 
#' @export
#' 
#' @examples
#' 

extract_fitbit_sleep_data <- function(csvFileName, bVerbose = FALSE){
  headBody <- "Body"
  headFoods <- "Foods"
  headActivities <- "Activities"
  headSleep <- "Sleep"
  headFoodLog <- "Food Log"
  lines <- readLines(csvFileName)
  idBody<- grep(headBody, lines)[1]
  idFoods <- grep(headFoods, lines)[1]
  idActivities <- grep(headActivities, lines)[1]
  idSleep<- grep(headSleep, lines)[1]
  idFoodLog1<- grep(headFoodLog, lines)[1]
  idFoodLog2<- grep(headFoodLog, lines)[2]
  idFoodLog3<- grep(headFoodLog, lines)[3]
  linesFoodLogStarts <- grep(headFoodLog,lines)
  nDays <- length(linesFoodLogStarts)

  if(bVerbose){
    print("Header line numbers in file...")
    print(sprintf("Body header at line: %d", idBody))
    print(sprintf("Foods header at line: %d", idFoods))
    print(sprintf("Activities header at line: %d", idActivities))
    print(sprintf("Sleep header at line: %d", idSleep))
    print(sprintf("Food log header 1 at line: %d", idFoodLog1))
    print(sprintf("Food log header 2 at line: %d", idFoodLog2))
    print(sprintf("Food log header 3 at line: %d", idFoodLog3))
  
    print("FoodLogStarts")
    print(linesFoodLogStarts)
    print("Number of Food Log Entries:")
    print(length(linesFoodLogStarts))
  }
  lengthSleep = idSleep-idActivities

  df <- read.table(csvFileName, header=TRUE,
                   skip = idSleep,
                   stringsAsFactors = FALSE,
                   nrow = nDays,
                   sep=',')

  # Need to extract the date from the Sleep data 
  # x <- df$Start.Time

  proc_str <- function(x) {
    res <- unlist(unlist(strsplit(x, " "))[1])
    return(res)
  }

  # func <- unlist(strsplit(x, " "))[1]
  # need a as.POSIXct class to plot...
  
  df$start_date = as.POSIXct(unlist(lapply(df$Start.Time, proc_str)))

  # set the names for reasonablce headers..
  names(df) <- c("start_date_time", "end_date_time", "min_asleep", "min_awake",
                 "num_awakenings", "time_in_bed", "min_rem_sleep",
                 "min_lt_sleep",  "min_deep_sleep", "start_date")

  tbl <- as_tibble(df)
  # return the tibble
  tbl
}
