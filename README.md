
<!-- README.md is generated from README.Rmd. Please edit that file -->

# budgetuy

<!-- badges: start -->
<!-- badges: end -->

El objetivo de este paquete es facilitar el trabajo con el presupuesto
de Uruguay. Permite descargar datos abiertos de presupuesto de los
organismos del Estado desde … hasta el último dato disponible. También
encontrarás funciones para convertir de valores corrientes a constantes
y convertir entre monedas. Esto último puede serte útil incluso si no
trabajás con los datos del presupuesto.

## Instalación

Podés descargar la versión en desarrollo de budgetuy desde
[GitHub](https://github.com/R-Lab-Uy/budgetuy) con:

``` r
# install.packages("devtools")
devtools::install_github("R-Lab-Uy/budgetuy")
```

## Conjuntos de datos

**Divisas**

| codigo | moneda               |
|:-------|:---------------------|
| ARS    | Peso Argentino       |
| BRL    | Real Brasilero       |
| EUR    | Euro                 |
| USD    | Dólar Estadounidense |
| UYU    | Peso Uruguayo        |

**Cotizaciones**

El paquete permite acceder a las cotizaciones diarias de dichas divisas
mencionadas desde 1999 a la fecha. En el caso del dólar estadounidense,
además del valor de compra y venta, desde 2017 se cuenta con los valores
de compra y venta de eBROU.

**IPC**

Este paquete trabaja con los datos de IPC con base 2010 publicados por
el INE.

**Presupuesto**

Los datos de presupuesto del paquete provienen de las publicaciones de
OPP.

## ¿Cómo usar budgetuy?

Por ejemplo, podemos descargar el Presupuesto Nacional de los organismos
del Estado para el año 2021. Estos organismos son mayormente ministerios
o agencias del gobierno nacional (Entes Autónomos o Servicios
Descentralizados), así como al Poder Judicial y organismos de contralor
electoral, financiero y administrativo.

``` r
library(budgetuy)

# descargo los datos desde la web de OPP 
presupuesto_2021 <- get_budget(year = 2021, toR = FALSE)

# leo los datos del paquete, es lo mismo
p21 <- presupuesto_2021

# si no quiero tanto detalle, trabajo con un resumen de esa info, agrupada por organismo
p21_org <- summary_budget(data = p21, level = "org")

# si quiero comparar con el presupuesto de 2019, me conviene llevar los pesos corrientes de 2021 a pesos constantes de 2019
p21_org_const <- c2c(to ="constant", base_month = "01", base_year = "2019", data = p21_org, x = "ejecutado", y = "año")

# para expresar los valores en miles de pesos
p21_org_const <- format_values(data = p21_org_const, x = ejecutado, to = "thousand") 

# o podemos expresar los valores en dólares
p21_org_const_usd <- currency_converter(data = p21_org_const, x = ejecutado_const, base_date = "2019-01-01")
```

<!-- You could also use GitHub Actions to re-render `README.Rmd` every time you push. An example workflow can be found here: <https://github.com/r-lib/actions/tree/v1/examples>. -->

## ¿Quiénes somos?

[RLabUy](https://rlabuy.rbind.io/) somos Richard Detomasi y Gabriela
Mathieu. Junto con budgetuy hemos desarrollado otros paquetes en R que
se complementan y conforman **uyverse**.

En budgetuy colaboró Guzmán López con funciones para descargar y
estandarizar las cotizaciones de monedas desde la web del INE.

Además de desarrollar paquetes de R, damos cursos de R para que más
gente lo use y así crezca la comunidad de R. Si te interesa alguno de
nuestros cursos, no dudes en contactarnos.

## ¿Cómo colaborar?

Todo lo que hacemos es en pos de contribuir a la comunidad de usuarixs
de R en Uruguay. La parte más difícil es mantener estos paquetes
actualizados porque lleva tiempo. Pero todo el esfuerzo vale la pena si
más personas usan el paquete. Podés colaborar usándolo y detectando
errores o posibles mejoras. Podés hacernos llegar tus comentarios por
[mail](mailto:rlabuy@protonmail.com) o enviando issues. Si conocés a
alguien que podría serle útil este paquete comentáselo.
