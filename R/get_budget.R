#' get_budget
#'
#' @param year anio del credito presupuestal 
#' @param level a nivel nacional ('national') o subnacional ('subnational')
#' @param folder carpeta donde descargar el archivo
#' @param toR convertir a formato RData
#'
#' @return file
#' @export
#'
#' @examples
#' \donttest{
#' get_budget(year = 2021, toR = FALSE)
#' }
get_budget <- function(year = 2021, level = "national", folder = tempdir(), toR = TRUE){
  
  # checks ----
  assertthat::assert_that(.x = curl::has_internet(), msg = "No internet access was detected. Please check your connection.")
  stopifnot(is.numeric(year) | is.null(year) | length(year) <= 1)
  if (!is.character(folder) | length(folder) != 1) {
    message(stringr::str_glue("Sorry... ;( \n \t You must enter a directory..."))
  }
  
  # download ----
  try(dir.create(folder))
  
  all_years <- 2011:2022
  
  if (!is.null(year) & any(year %in% all_years) == FALSE) {
    stop("Sorry... ;( \n \t At the moment is only available data for the period 2011 to 2022")
  }
  
  if (is.null(year)) {
    year <- max(all_years)
  }
  
  urls <- budgetuy::urls_opp %>%
    dplyr::filter(nivel == {{level}}) %>% 
    dplyr::mutate(file = paste0(folder, "/credito_presupuestal_", all_years, ".csv"))
  
  links <- urls %>% dplyr::filter(.data$yy %in% year)


  u1 <- links$link
  f1 <- links$file
  y <- links$yy
  
  if (!file.exists(f1)) {
    message(stringr::str_glue("Trying to download Credito Presupuestal {y}..."))
    try(utils::download.file(u1, f1, mode = "wb", method = "libcurl"))
  } else {
    message(stringr::str_glue("Credito presupuestal {y} already exists, the download is omitted"))
  }
  
  # read----
  archivo <- fs::dir_ls(folder, regexp = "\\.csv$")
  archivo <- archivo[which.max(file.info(archivo)$mtime)]
  ext <- fs::path_ext(archivo)
  uncompressed_formats <- c("csv", "xlsx")
  
  if (ext %in% c(uncompressed_formats) != TRUE) {
    formats_string <- paste(c(uncompressed_formats[length(uncompressed_formats) - 1]),
                            collapse = ", ")
    formats_string <- paste(c(uncompressed_formats[length(uncompressed_formats)]),
                            collapse = " o ")
    stop(stringr::str_glue("The metadata in {archivo} indicates that this file is not useful. \n \t Make sure the format is {formats_string}."))
  }
  
  if (ext %in% "csv") {
    message(stringr::str_glue("The metadata in {archivo} indicates that the uncompressed format is suitable,  \n \t Trying to read..."))
    #d <- readr::read_csv(archivo, show_col_types = FALSE)
    d <- utils::read.csv(archivo)
    d <- d %>%
      dplyr::mutate_if(is.character,stringi::stri_trans_general,"latin-ascii")
  }
  if (ext %in% "xlsx") {
    message(stringr::str_glue("The metadata in {archivo} indicates that the uncompressed format is suitable,  \n \t Trying to read..."))
    #d <- readr::read_csv(archivo, show_col_types = FALSE)
    d <- readxl::read_xlsx(archivo)
    
  }
  
  if (any(class(d) %in% "data.frame")) {
    message(stringr::str_glue("{archivo} could be read as tibble :-)"))
    #d <- janitor::clean_names(d)
  } else {
    stop(stringr::str_glue("{archivo} could not be read as tibble :-("))
  }
  
  # standarize names
  names(d) <- tolower(names(d))
  
  # fix class variables
  if(level =="national"){
    d <- d %>% 
      dplyr::mutate(apertura = gsub(",", ".", apertura),
                    credito = gsub(",", ".", credito),
                    ejecutado = gsub(",", ".", ejecutado)) %>% 
      dplyr::mutate_at(dplyr::vars(apertura, credito, ejecutado), as.numeric)  
  }
  
  
  # save ----
  if (isTRUE(toR)) {
    save(d, file = fs::path(folder, paste0("credito_presupuestal_", year, ".Rdata")))
    message(stringr::str_glue("The credito presupuestal {year} has been saved in R format"))
    csv <- fs::dir_ls(folder, regexp = "\\.csv$")
    fs::file_delete(archivo)
    fs::file_delete(csv)
  }
  names(d)[1] <- "anio"
  return(d)

}


#' summary_budget
#'
#' @param data data.frame
#' @param level area, organismo
#'
#' @return data.frame
#' @export
#'
#' @examples
#'#' 
summary_budget <- function (data = budgetuy::presupuesto_2021, level = "org") {
  
  data_sum <- data %>%  
    dplyr::group_by(organismo_nombre, anio) %>% 
    dplyr::summarise_at(dplyr::vars(apertura, credito, ejecutado), sum, na.rm = FALSE) %>% 
    dplyr::mutate("% ejecutado" = budgetuy::round_off(ejecutado/credito*100, 1)) %>% 
    dplyr::ungroup()
}
