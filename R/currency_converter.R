#' currency_converter
#'
#' @param data data.frame
#' @param x variable numerica a convertir
#' @param money_from por defecto, pesos uruguayos
#' @param money_to por defecto, dolares estadounidenses
#' @param value 'buy' (compra), 'sell' (venta), 'mean' (promedio)
#' @param ebrou si es TRUE utiliza la cotizacion eBROU
#' @param end_date fecha de la cotizacion a utilizar
#'
#' @return data.frame
#' @export
#'
#' @examples
#'#' 
currency_converter <- function(data = NULL,
                               x = NA_character_,
                               money_from = "UYU", 
                               money_to = "USD",
                               value = "buy",
                               ebrou = FALSE,
                               end_date = Sys.Date()-1){
  
  assertthat::assert_that(checkdate(end_date), msg = "Sorry... :( \n \t end_date parameter is not a validate date")
  assertthat::assert_that(is.data.frame(data), msg = "Sorry... :( \n \t data parameter must be data frame")
  assertthat::assert_that(is.character(x), msg = "Sorry... :( \n \t x parameter must be character")
  assertthat::assert_that(money_from!=money_to, msg = "Sorry... :( \n \t money_from and money_to parameter must be different currency")
 # assertthat::assert_that(money_from!="UYU"&money_to!="UYU", msg = "Sorry... :( \n \t this package only convert from UYU or to UYU")
  
  df <- budgetuy::cotizaciones %>% 
    dplyr::filter(fecha %in% end_date) %>% 
    dplyr::select(dplyr::starts_with(money_to)) %>% 
    dplyr::as_tibble()
    
  if(nrow(df) == 0){
    message(stringr::str_glue("No hay datos de cotizaciones de {end_date}"))
  }
  
  if(money_from == "UYU") {
    if(value == "buy"){
      df <- df %>% dplyr::select(paste(money_to, "compra"))
    } else if(value == "sell"){
      df <- df %>% dplyr::select(paste(money_to, "venta"))
    } else{
      df <- df %>% 
        dplyr::select(paste(money_to, "compra"), paste(money_to, "venta")) %>%
        dplyr::mutate(promedio = rowMeans(.)) %>% 
        dplyr::select(promedio)
    }
    
    data <- data %>% 
      dplyr::mutate(x_usd = .data[[x]]/df[[1]])
  } 
  
  if(money_to == "UYU") {
    if(value == "buy"){
      df <- df %>% dplyr::select(paste(money_from, "compra"))
    } else if(value == "sell"){
      df <- df %>% dplyr::select(paste(money_from, "venta"))
    } else{
      df <- df %>%
        dplyr::select(paste(money_from, "compra"), paste(money_from, "venta")) %>%
        dplyr::mutate(promedio = rowMeans(.)) %>% 
        dplyr::select(promedio)
    }
    
    data <- data %>% 
      dplyr::mutate(x_uyu = .data[[x]]*df[[1]])
  }
  
  return(data)
}
