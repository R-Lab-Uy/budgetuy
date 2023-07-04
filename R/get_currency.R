#' get_currency_exchange
#' 
#' @param path path to download files and processed data
#' @param write FALSE to not save data
#' @return data.frame
#' @export
#' 
#' @examples
#' \donttest{
#' get_currency_exchange()
#' }
get_currency_exchange <- function(path = tempdir(), write = FALSE) {
  
    assertthat::assert_that(is.character(path), msg = "Sorry... :( \n \t path parameter must be character")
    assertthat::assert_that(is.logical(write), msg = "Sorry... :( \n \t write parameter must be logical")
    assertthat::assert_that(.x = curl::has_internet(), msg = "No internet access was detected. Please check your connection.")

    u <- budgetuy::urls_ine %>% dplyr::filter(indice == "Cotizaciones") %>% dplyr::select(url) %>% dplyr::pull()
    f <- fs::path(path, "cotizaciones_raw.xlsx")
    
    if (identical(.Platform$OS.type, "unix")) {
      try(utils::download.file(u, f, mode = 'wb', method = 'wget'))
    } else {
      try(utils::download.file(u, f, mode = 'wb', method = 'libcurl'))
    }
}


#' format_currency_data
#' 
#' @author Guzman Lopez
#' @param write por defecto no guarda el objeto en un archivo
#' @param path por defecto, una carpeta temporal
#'
#' @return data.frame
#' @export
#'
#' @examples
#'#'
format_currency_data <- function(write = FALSE, path = tempdir()) {
  message("Procesando archivo descargado del INE...")
  data <- suppressWarnings(
    suppressMessages(
      readxl::read_excel(
        here::here(tempdir(), "cotizaciones_raw.xlsx"),
        col_names = FALSE,
        skip = 8,
        progress = TRUE
      ) %>%
        dplyr::select_if(~ !all(is.na(.))) %>%
        purrr::set_names("d",
                         "m",
                         "y",
                         "USD compra",
                         "USD venta",
                         "USD eBROU compra",
                         "USD eBROU venta",
                         "EUR compra",
                         "EUR venta",
                         "ARS compra",
                         "ARS venta",
                         "BRL compra",
                         "BRL venta"
        ) %>%
        tidyr::fill(m, y, .direction = "down") %>%
        dplyr::mutate(m = stringr::str_trim(stringr::str_sub(m, 1, 3))) %>%
        dplyr::mutate(
          m = dplyr::case_when(
            m == "Ene" ~ "Jan",
            m == "Abr" ~ "Apr",
            m == "Ago" ~ "Aug",
            m == "Set" ~ "Sep",
            m == "Dic" ~ "Dec",
            TRUE ~ m
          )
        ) %>%
        dplyr::mutate(fecha = lubridate::ymd(
          stringr::str_glue(
            "{y}-{m}-{d}",
            y = y,
            m = m,
            d = d
          ),
          locale = "es_UY.UTF-8"
        )) %>%
        dplyr::select(fecha, dplyr::everything(), -d, -m, -y) %>%
        dplyr::mutate_if(is.character, as.double) %>%
        dplyr::filter(!is.na(fecha))
    )
  )
  
  data_ts <-
    data %>%
    dplyr::distinct(.keep_all = TRUE) %>%
    tsibble::as_tsibble(index = fecha) %>%
    tsibble::fill_gaps() %>% # fill gaps in time series index
    tidyr::fill(names(.), .direction = "down") # fill data from previous available data
  
  date_from <- min(data_ts$fecha)
  date_to <- max(data_ts$fecha)
  message(stringr::str_glue("Observaciones desde {date_from} a {date_to}."))
  
  # Write to file
  if (write) {
    if (!dir.exists(path)) {
      dir.create(path)
    }
    file_name <- "cotizaciones_processed.csv"
    message(stringr::str_glue("Guardando datos en archivo '{file_name}'."))
    readr::write_csv(x = data_ts, file = fs::path(path, file_name))
  }
  
  return(data_ts)
  
}
