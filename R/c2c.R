# montos <- readxl::read_xlsx("montos.xlsx")

#' c2c
#' @description convierte de pesos uruguayos corrientes a constantes
#' @param to por defecto, 'constant' para convertir a pesos constantes
#' @param base_month mes base
#' @param base_year anio base
#' @param index indice a utilizar para convertir (IPC, IPAB)
#' @param level por defecto, general
#' @param data data frame con los montos a convertir
#' @param x variable de data con los montos
#' @param y variable de data con el anio
#' @param m variable de data con el mes
#'
#' @return data.frame
#' @export
#' @importFrom rlang .data
#'
#'@examples
#'#'
c2c <- function(to = "constant",
                base_month = NULL,
                base_year = NULL,
                index = "IPC",
                level = "G", 
                data = NULL,
                x = NA_character_,
                y = NA_character_,
                m = NA_character_) {
  
  if(index == "IPC" & level == "G"){
    df <- budgetuy::ipc_base2010
  }
  
  if(is.na(m)){
    data$m <- "01"
  }
  
  if(to == "constant") {
    
    if(is.na(m)){
      data <- data %>% 
        dplyr::mutate(
          fecha = paste(.data[[y]], m, "01", sep = "-"),
          fecha = as.Date(fecha, "%Y-%m-%d"))
    } else{
      data <- data %>% 
        dplyr::mutate(
          mes = ifelse(nchar(.data[[m]])==1, paste0("0", .data[[m]]), .data[[m]]),
          fecha = paste(.data[[y]], mes, "01", sep = "-"),
          fecha = as.Date(fecha, "%Y-%m-%d"))  
    }
    
    indice_base <- df %>%
       dplyr::filter(fecha == paste0(base_year, "-", base_month, "-01")) %>%
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
      dplyr::select(-mes, -fecha, - deflactor, -indice)
  }
  if(to == "current"){
    
  }
  
  return(data)
  
  
}


