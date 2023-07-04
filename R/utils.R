#' get_ipc
#'
#' @param path por defecto, una carpeta temporal donde se descarga una planilla
#'
#' @return data.frame
#' @export
#' 
#'
#' @examples
#' \donttest{
#' get_ipc()
#' }
get_ipc <- function(path = tempdir()){
  
  assertthat::assert_that(is.character(path), msg = "Sorry... :( \n \t folder parameter must be character")
  assertthat::assert_that(.x = curl::has_internet(), msg = "No internet access was detected. Please check your connection.")
  
  u <- budgetuy::urls_ine %>% dplyr::filter(indice == "IPC") %>% dplyr::select(url) %>% dplyr::pull()
  f <- fs::path(path, "IPC_serie_base2022.xls")
  if (identical(.Platform$OS.type, "unix")) {
    try(utils::download.file(u, f, mode = 'wb', method = 'wget'))
  } else {
    try(utils::download.file(u, f, mode = 'wb', method = 'libcurl'))
  }
  suppressMessages({
    df <- readxl::read_xls(f)
    df <- df %>%
      dplyr::slice(7, 10:length(df[[1]])-3)
    names(df) <- df[1,]
    df <- df[-c(1:4),]
    df <- janitor::clean_names(df) %>%
      dplyr::mutate(fecha = janitor::excel_numeric_to_date(as.numeric(as.character(.data$mes_y_ano)), date_system = "modern")) %>%
      dplyr::select(fecha, dplyr::everything(), -mes_y_ano)
  })
  
  return(df)
}


#' round_off
#'
#' @param x vector
#' @param digits number of digits 
#'
#' @return vector
#' @export
#'
#' @examples
#' round_off(5.8888)
round_off <- function (x, digits=0) {
  posneg = sign(x)
  y = trunc(abs(x) * 10 ^ (digits + 1)) / 10
  y = floor(y * posneg + 0.5) / 10 ^ digits
  return(y)
}



#' values_format
#'
#' @param data data.frame
#' @param x variable a convertir
#' @param to a miles ('thousand') o millones ('million')
#'
#' @return data.frame
#' @export
#'
#' @examples
#'#' 
values_format <- function (data = NULL, x = NA_character_, to = "thousand") {
  
  if(to == "thousand"){
  data <- data %>% 
    dplyr::mutate(x = budgetuy::round_off(.data[[x]] / 1e3, 1),
                  x = format(x, big.mark = ".", decimal.mark = ",")) 
  }
  
  if(to == "million"){
    data <- data %>% 
      dplyr::mutate(x = budgetuy::round_off(.data[[x]] / 1e6, 1),
                    x = format(x, big.mark = ".", decimal.mark = ","))
  }
 return(data) 
}

#' checkdate
#'
#' @param date character date 'yyyy-mm-dd'
#'
#' @return TRUE if date is valid date
#' @export
#'
#' @examples
#'#' 
checkdate <- function(date = NA_character_) {
  x <- as.Date(date, "%Y-%m-%d")
  if(!is.na(x)){
    tryCatch(lubridate::is.Date(x), 
             error = function(e) return(FALSE))  
  } else{
    return(FALSE)
  }
  
}



#' Pipe operator
#' See \code{dplyr::\link[dplyr]{\%>\%}} for details.
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom dplyr %>%
#' @usage lhs \%>\% rhs
NULL
