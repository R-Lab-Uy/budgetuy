## code to prepare `ipc_base2022` dataset goes here

ipc_base2022 <- budgetuy::get_ipc()
usethis::use_data(ipc_base2022, overwrite = TRUE)
