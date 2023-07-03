#' currency_converter
#'
#' @param data data.frame
#' @param x variable numerica a convertir
#' @param money_from por defecto, pesos uruguayos
#' @param money_to por defecto, dolares estadounidenses
#' @param value 'buy', 'sell', 'mean'
#' @param ebrou si es TRUE utiliza la cotizacion eBROU
#' @param base_date fecha de la cotizacion a utilizar
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
                               base_date = Sys.Date()-1){
  
  df <- budgetuy::cotizaciones %>% 
    dplyr::filter(fecha %in% base_date) %>% 
    dplyr::select(dplyr::starts_with(money_to))
  
  if(value == "buy"){
    df <- df %>% dplyr::select(paste(money_to, "compra"))
  } else if(value == "sell"){
    df <- df %>% dplyr::select(paste(money_to, "venta"))
  } else{
    df <- df %>% dplyr::select(paste(money_to, "compra"), paste(money_to, "venta")) #%>% rowSums()
  }
    
  data <- data %>% 
    dplyr::mutate(x_usd = .data[[x]]/df[1])
  
  return(data)
}