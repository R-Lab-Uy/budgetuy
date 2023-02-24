## code to prepare `presupuesto_2021` dataset goes here

presupuesto_2021 <- get_budget(year = 2021, toR = FALSE)
usethis::use_data(presupuesto_2021, overwrite = TRUE)
