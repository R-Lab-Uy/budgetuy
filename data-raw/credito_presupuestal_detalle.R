## descarga el archivo del anio correspondiente desde la web de OPP

credito_presupuestal_detalle <- get_budget(year = 2021, folder = tempdir(), toR = TRUE)
usethis::use_data(credito_presupuestal_detalle, overwrite = TRUE)
