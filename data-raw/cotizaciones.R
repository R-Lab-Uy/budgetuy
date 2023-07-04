## code to dowload `cotizaciones` dataset from INE website and save to RData file

budgetuy::get_currency_exchange(path = tempdir())
cotizaciones <- format_currency_data(write = FALSE, path = tempdir())
usethis::use_data(cotizaciones, overwrite = TRUE)
