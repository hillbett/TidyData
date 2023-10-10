#' Cleans ELISA PLate Plan
#'
#' Read in individuals ELISA Plate plans and performs data set merge.
#'
#' @param path input file directory
#'
#' @return A tibble with tidy dataset
#' @export
#'
#' @examples
#' clean_ELISA(path = "(C:/Users/hkiprono/3.0 CHMI/)")
#'
clean_ELISA <- function(path){

  # 1.0 Read paths to files.
  all_paths <- list.files(path = path,  pattern = c("*.xls","*.xlsx"),
                          full.names = TRUE)

  # 2.0 Read the file contents
  all_paths |>
    purrr::set_names(basename) |>
    purrr::map(readxl::read_excel) |>
    purrr::list_rbind()
}
