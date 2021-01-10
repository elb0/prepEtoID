#' prep_peer
#'
#' @param ps_export The csv exported from peerScholar.
#' @param gradebook_export The csv exported from your Canvas gradebook. Must have the assessment you want to process as a column.
#' @param roster_from_grouper The class roster, exported from the UT Advanced Group tool. Could be any csv with the columns \code{Student Number} and \code{Email} to allow you to match as peerScholar uses email as the only uniique ID and the Canvas gradebook needs student ID.
#' @param activity_name The name of the activity you are grading, exactly as shown in the gradebook csv.
#' @param total_points The number of points the assessment is out of on Canvas. Defaults to 1 so the grade is just a proportion.
#'
#' @return Writes a csv of the form "import_acitivity name_date.csv" into the current directory.

prep_peer <-function(ps_export, gradebook_export, roster_from_grouper,
                     activity_name, total_points = 1){
  # Merge peerScholar data with roster from grouper
  merge_for_id <- roster_from_grouper %>%
    left_join(ps_export, by = "Email") %>%
    mutate(activity_grade = `Final Grade`/`Grade Total`*total_points)

  # Create new file for importing to gradebook
  gradebook_import <- gradebook_export %>%
    filter(!is.na(ID)) %>%
    left_join(merge_for_id, by = c("Integration ID" = "Student Number")) %>%
    select(1:6, activity_grade)

  names(gradebook_import)[7] <- activity_name

  write_csv(gradebook_import, paste0("import_", activity_name, "_", Sys.Date(), ".csv"))
}

