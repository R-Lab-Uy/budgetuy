#' \code{budgetuy} package
#'
#' Presupuesto Uruguay
#'
#' @docType package
#' @name budgetuy
NULL

## quiets concerns of R CMD check re: the .'s that appear in pipelines
if(getRversion() >= "2.15.1") utils::globalVariables(c(".",
                                                       "anio",
                                                       "apertura",
                                                       "credito",
                                                       "d",
                                                       "deflactor",
                                                       "ejecutado",
                                                       "fecha",
                                                       "m",
                                                       "mes",
                                                       "nivel",
                                                       "organismo_nombre",
                                                       "y",
                                                       "indice",
                                                       "mes_y_ano",
                                                       "promedio"
                                                       ))