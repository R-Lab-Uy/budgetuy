## code to prepare `divisas` dataset goes here

divisas <- data.frame(codigo = c('ARS', 'BRL', 'EUR', 'USD', 'UYU'),
                      moneda = c("Peso Argentino", "Real Brasilero", "Euro", "Dólar Estadounidense", "Peso Uruguayo"))
usethis::use_data(divisas, overwrite = TRUE)
