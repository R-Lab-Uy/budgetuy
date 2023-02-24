#' get_ipc
#'
#' @param folder por defecto, una carpeta temporal donde se descarga una planilla
#'
#' @return data.frame
#' @export
#' 
#'
#' @examples
#' \donttest{
#' get_ipc()
#' }
get_ipc <- function(folder = tempdir()){
  
  assertthat::assert_that(is.character(folder), msg = "Sorry... :( \n \t folder parameter must be character")
  assertthat::assert_that(.x = curl::has_internet(), msg = "No internet access was detected. Please check your connection.")
  
  u <- "https://www.ine.gub.uy/c/document_library/get_file?uuid=2e92084a-94ec-4fec-b5ca-42b40d5d2826&groupId=10181"
  f <- fs::path(folder, "IPC gral var M_B10.xls")
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
      dplyr::select(.data$fecha, dplyr::everything(), -.data$mes_y_ano)
    ipc_base2010 <- df
  })
  
  return(ipc_base2010)
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


#' Pipe operator
#' See \code{dplyr::\link[dplyr]{\%>\%}} for details.
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom dplyr %>%
#' @usage lhs \%>\% rhs
NULL
