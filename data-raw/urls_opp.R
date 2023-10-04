## list urls from OPP website

urls_opp <- data.frame(yy = 2011:2023,
                       nivel = rep("national", 13),
                       link = fs::path("https://transparenciapresupuestaria.opp.gub.uy/sites/default/files/datos-abiertos/",
                                         c("credito_presupuestal_detalle_2011.csv", #2011
                                           "credito_presupuestal_detalle_2012.csv",
                                           "credito_presupuestal_detalle_2013.csv",
                                           "credito_presupuestal_detalle_2014.csv",
                                           "credito_presupuestal_detalle_2015.csv", #2015
                                           "credito_presupuestal_detalle_2016.csv",
                                           "credito_presupuestal_detalle_2017.csv",
                                           "credito_presupuestal_detalle_2018.csv",
                                           "credito_presupuestal_detalle_2019.csv",  #2019
                                           "credito_presupuestal_detalle_2020.csv",
                                           "credito_presupuestal_detalle_2021.csv",
                                           "credito_presupuestal_detalle_2022.csv",
                                           "credito_presupuestal_detalle_2023.csv"
                                         )),
                       dic = fs::path("https://transparenciapresupuestaria.opp.gub.uy/sites/default/files/datos-abiertos/",
                                      c("Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv",
                                        "Metadatos_CreditoPresupuestalDesde2011.csv"
                                        )),
                       stringsAsFactors = FALSE)

usethis::use_data(urls_opp, overwrite = TRUE)
