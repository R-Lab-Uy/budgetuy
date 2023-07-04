## code to prepare `urls_ine` dataset goes here

urls_ine <- data.frame(
  indice = c("IPC", "IMS", "UP", "Cotizaciones"),
  url = c("https://www5.ine.gub.uy/documents/Estad%C3%ADsticasecon%C3%B3micas/SERIES%20Y%20OTROS/IPC/Base%20Octubre%202022=100/IPC%20gral%20y%20variaciones_base%202022.xls",
          "https://www5.ine.gub.uy/documents/Estad%C3%ADsticasecon%C3%B3micas/SERIES%20Y%20OTROS/IMS/Base%20Julio%202008=100/IMS%20C1%20Gral%20emp%20M%20B08.xls",
          "https://www5.ine.gub.uy/documents/Estad%C3%ADsticasecon%C3%B3micas/SERIES%20Y%20OTROS/UP/Unidad%20Previsional%20-%20UP.xls",
          "https://www5.ine.gub.uy/documents/Estad%C3%ADsticasecon%C3%B3micas/SERIES%20Y%20OTROS/Cotizaci%C3%B3n%20de%20monedas/Cotizaci%C3%B3n%20monedas.xlsx"),
  nota = c("IPC base octubre 2022", "", "", "Cotizaciones diarias monedas")
)

usethis::use_data(urls_ine, overwrite = TRUE)
