#' A dataset containing the IPC base 2010
#' @family dataset
#' @format A data frame with 1024 rows and 8 variables:
#' \describe{
#'   \item{fecha}{date from 1937 to now}
#'   \item{indice}{IPC}
#'   \item{mensual}{mensual value of IPC}
#'   \item{trimestre}{three-month period value of IPC}
#'   \item{cuatrimestre}{four-month period value of IPC}
#'   \item{semestre}{six-month period value of IPC}
#'   \item{acum_ano}{acumulated IPC}
#'   \item{acum_12_meses}{acumulated IPC last 12 month}
#'  }
#' @source \url{http://www.ine.gub.uy/}
#' @details
#' Disclaimer: This script is not an official INE product.
#' Aviso: El script no es un producto oficial de INE.
"ipc_base2010"

#' A dataset containing the IPC base 2022
#' @family dataset
#' @format A data frame with 1024 rows and 8 variables:
#' \describe{
#'   \item{fecha}{date from 1937 to now}
#'   \item{indice}{IPC}
#'   \item{mensual}{mensual value of IPC}
#'   \item{trimestre}{three-month period value of IPC}
#'   \item{cuatrimestre}{four-month period value of IPC}
#'   \item{semestre}{six-month period value of IPC}
#'   \item{acum_ano}{acumulated IPC}
#'   \item{acum_12_meses}{acumulated IPC last 12 month}
#'  }
#' @source \url{http://www.ine.gub.uy/}
#' @details
#' Disclaimer: This script is not an official INE product.
#' Aviso: El script no es un producto oficial de INE.
"ipc_base2022"

#' A dataset containing the urls of INE datasets
#' @family dataset
#' @format A data frame with 12 rows and 3 variables:
#' \describe{
#'   \item{indice}{date from 2011 to 2022}
#'   \item{url}{level of the budget}
#'   \item{nota}{url for data download}
#'  }
#' @source \url{http://www.ine.gub.uy/}
#' @details
#' Disclaimer: This script is not an official INE product.
#' Aviso: El script no es un producto oficial de INE.
"urls_ine"


#' A dataset containing the urls of OPP datasets and metadata
#' @family dataset
#' @format A data frame with 12 rows and 3 variables:
#' \describe{
#'   \item{yy}{date from 2011 to 2022}
#'   \item{nivel}{level of the budget}
#'   \item{link}{url for data download}
#'   \item{dic}{url for metadata download}
#'  }
#' @source \url{http://www.transparenciapresupuestaria.opp.gub.uy/}
#' @details
#' Disclaimer: This script is not an official OPP product.
#' Aviso: El script no es un producto oficial de OPP.
"urls_opp"


#' A dataset containing the currency exchange between pesos uruguayos and various foreign currency 
#' @family dataset
#' @format A data frame with more than 8000 rows and 11 variables:
#' \describe{
#'   \item{fecha}{date from 1999 to today}
#'   \item{USD compra}{}
#'   \item{USD venta}{}
#'   \item{USD eBROU compra}{}
#'   \item{USD eBROU venta}{}
#'   \item{EUR compra}{}
#'   \item{EUR venta}{}
#'   \item{ARS compra}{}
#'   \item{ARS venta}{}
#'   \item{BRL compra}{}
#'   \item{BRL venta}{}
#'  }
#' @source \url{http://www.ine.gub.uy/}
#' @details
#' Disclaimer: This script is not an official INE product.
#' Aviso: El script no es un producto oficial de INE.
"cotizaciones"


#' A dataset containing the currency code and name
#' @family dataset
#' @format A data frame with more than 8000 rows and 11 variables:
#' \describe{
#'   \item{codigo}{ISO 4217 que define con 3 letras el codigo de cada divisa}
#'   \item{moneda}{nombre de la divisa}
#'  }
#' @source \url{https://es.wikipedia.org/}
"divisas"

#' A dataset containing the National Bugdet 
#' @family dataset
#' @format A data frame with more than 38000 rows and 29 variables:
#' \describe{
#'   \item{anio}{}
#'   \item{organismo_nombre}{}
#'   \item{ue_nombre}{}
#'   \item{grupo_ues_nombre}{}
#'   \item{ap_nombre}{}
#'   \item{programa_nombre}{}
#'   \item{proyecto_codigo}{}
#'   \item{proyecto_nombre}{}
#'   \item{financ_nombre}{}
#'   \item{fuente_financ_nombre}{}
#'   \item{tipo_gasto_nombre}{}
#'   \item{grupo_nombre}{}
#'   \item{subgrupo_nombre}{}
#'   \item{odgyaux_codigo}{}
#'   \item{odgyaux_nombre}{}
#'   \item{ods_nombre}{}
#'   \item{apertura}{}
#'   \item{credito}{}
#'   \item{ejecutado}{}
#'   \item{organismo_codigo}{}
#'   \item{ue_codigo}{}
#'   \item{grupo_ues_codigo}{}
#'   \item{ap_codigo}{}
#'   \item{programa_codigo}{}
#'   \item{financ_codigo}{}
#'   \item{fuente_financ_codigo}{}
#'   \item{grupo_codigo}{}
#'   \item{subgrupo_codigo}{}
#'   \item{ods_codigo}{}
#'  }
#' @source \url{http://www.transparenciapresupuestaria.opp.gub.uy/}
"presupuesto_2021"