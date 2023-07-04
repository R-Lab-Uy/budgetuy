#' c2c
#' @description convierte de pesos uruguayos corrientes a constantes
#' @param end_date fecha final para la conversion "yyyy-mm-dd"
#' @param index indice a utilizar para convertir (IPC, IPAB)
#' @param level por defecto, general
#' @param data data frame con los montos a convertir
#' @param x variable de data con los valores a convertir
#' @param start_date variable de data con la fecha correspondiente a los valores "yyyy-mm-dd"
#'
#' @return data.frame
#' @export
#' @importFrom rlang .data
#'
#'@examples
#'#'
c2c <- function(end_date = NA_character_,
                index = "IPC",
                level = "G", 
                data = NULL,
                x = NA_character_,
                start_date = NA_character_) {
  
  assertthat::assert_that(checkdate(end_date), msg = "Sorry... :( \n \t end_date parameter is not a validate date")
  assertthat::assert_that(is.character(x), msg = "Sorry... :( \n \t x parameter must be character")
  assertthat::assert_that(is.character(start_date), msg = "Sorry... :( \n \t start_date parameter must be character")
  assertthat::assert_that(is.data.frame(data), msg = "Sorry... :( \n \t data parameter must be data frame")
  
  if(index == "IPC" & level == "G"){
    df <- budgetuy::ipc_base2022
  }
  
   data <- data %>% 
      dplyr::mutate(
          fecha = as.Date(.data[[start_date]], "%Y-%m-%d"))

    indice_base <- df %>%
       dplyr::filter(fecha == as.Date(end_date, "%Y-%m-%d")) %>%
       dplyr::select(indice) %>%
       as.numeric()
     
    rows1 <- which(df$fecha %in% data$fecha)
     
   indice <- df %>%
       dplyr::slice(rows1) %>%
       dplyr::select(fecha, indice) %>% 
       dplyr::mutate(indice = as.numeric(indice))#ya guardarlo numeric en el data
     
    data <- dplyr::left_join(data, indice, by = "fecha")

    data <- data %>%
      dplyr::mutate(deflactor = indice_base/indice) %>% 
      dplyr::mutate(x_const = as.numeric(.data[[x]])*deflactor) %>% 
      dplyr::select(-fecha, - deflactor, -indice)

  return(data)

}


