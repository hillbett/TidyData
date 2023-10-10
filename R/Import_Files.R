#' Import Excel files
#'
#' Read multiple excel data sets to R
#'
#' @param path input file directory
#' @param pattern input pattern as either .xls, .xlsx or csv
#'
#' @return A tibble with tidy dataset
#' @export
#'
#' @examples
#' clean_ELISA(path = "C:/Users/hkiprono/Desktop/R_packages/test_data_TidyElisa",pattern = c(".xls",".xlsx"))
#'
#'

Import <- function(path, pattern = c(".xls", ".xlsx", ".csv")) {

  # 1.0 Read the files
  all_paths <- list.files(path = path, pattern = pattern, full.names = TRUE)

  if (length(all_paths) == 0) {
    stop("No files matching the specified pattern found in the directory.")
  }

  # 2.0 Read the file contents
  read_and_combine <- function(file_path){
    tryCatch(
      {
        data <- readxl::read_excel(file_path)
        return(data)
      },
      error = function(e){
        warning(paste("Error reading file:", file_path, "|", e$message))
        return(NULL)
      }
    )
  }

  file_data <- all_paths |>
    purrr::set_names(basename) %>%
    purrr::map(read_and_combine) %>%
    purrr::list_rbind()

  return(file_data)
}
