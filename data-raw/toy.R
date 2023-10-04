## code to prepare `toy` dataset goes here

toy <- data.frame(pesos = c(1, 10, 100, 39.15, 39146.60), 
                  dolares = c(0.026, 0.26, 2.55, 1, 1000),
                  fecha = c("2023-01-01", "2023-01-01", "2023-01-01", "2023-01-01", "2023-01-01"))


usethis::use_data(toy, overwrite = TRUE)
