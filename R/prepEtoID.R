#' prepEtoID
#'
#' @param source_export The data from your source, e.g. MS Forms. Must have a column called \code{Email} and column called \code{Grade}
#' @param gradebook_export The data exported from your Canvas gradebook. Must have the assessment you want to process as a column.
#' @param roster_from_grouper The class roster, exported from the UT Advanced Group tool. Could be any csv with the columns \code{Student Number} and \code{Email} to allow you to match to a source, like MS Forms, that has email as the only uniique ID and the Canvas gradebook needs student ID.
#' @param activity_name The name of the activity you are grading, exactly as shown in the gradebook csv.
#'
#' @return Writes a csv of the form "import_acitivity name_date.csv" into the current directory.

prepEtoID <-function(source_export, gradebook_export, roster_from_grouper,
                     activity_name){
  # Merge sourse data with roster from grouper
  merge_for_id <- roster_from_grouper %>%
    left_join(source_export, by = "Email") %>%
    select(`Student Number`, Grade)

  # Create new file for importing to gradebook
  gradebook_import <<- gradebook_export %>%
    filter(!is.na(ID)) %>%
    left_join(merge_for_id, by = c("Integration ID" = "Student Number")) %>%
    select(1:6, "Grade")

  names(gradebook_import)[7] <- activity_name

  # Let's you examine the result by putting gradebook_import in the Global Environment
  assign(gradebook_import, envir = .GlobalEnv)

  write_csv(gradebook_import, paste0("import_", activity_name, "_", Sys.Date(), ".csv"))
}

