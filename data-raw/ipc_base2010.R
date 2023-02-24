## code to prepare `ipc_base2010` dataset goes here

ipc_base2010 <- budgetuy::get_ipc()
usethis::use_data(ipc_base2010, overwrite = TRUE)
