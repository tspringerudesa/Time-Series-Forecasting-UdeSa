cd "G:\Other computers\Mi portátil\Facultad\Pronosticos\Ejs Pronosticos\EjPronosticos10"

log using "Ej10_log.log", replace

clear
import excel "Ejer_9_.xlsx", firstrow clear

* variable tiempo
tsset obs

*Lags optimos = 1
dfgls y1
* tendencia determinística significativa y rechazo no estacionariedad -> es I(0)
dfuller y1, trend lags(1) regress

*Lags optimos = 1
dfgls y2
* tendencia determinística significativa y rechazo no estacionariedad -> es I(0)
dfuller y2, trend lags(1) regress

tsline y1 y2

* Lags optimos del var = 1
varsoc y1 y2

*Debido a que ya son I(0) no hace falta hacer un VEC.
*Estimación:
var y1 y2, lags(1)

*Test de autocorrelación de errores. No puedo rechazar no autocorrelación
varlmar

* Ambas raíces dentro del círculo unitario
varstable



*** SEGUNDA SIMULACION ***
import excel "Ejer_9_.xlsx", sheet("Ejercicio 2") firstrow clear

* variable tiempo
tsset obs

*Lags optimos = 1
dfgls y1
* tendencia determinística significativa y rechazo no estacionariedad -> es I(0)
dfuller y1, trend lags(1) regress

*Lags optimos = 1
dfgls y2
* tendencia determinística significativa y no rechazo no estacionariedad -> es al menos I(1)
dfuller y2, trend lags(1) regress

* No se puede correr el vec si son de distinto orden de integración
tsline y1 y2 y3



*** TERCERA SIMULACION ***
* 1)
import excel "Ejer_9_.xlsx", sheet("Ejercicio 3") firstrow clear

* 2)
* variable tiempo
tsset obs

* 3)
*Lags optimos = 1
dfgls y1
* tendencia determinística no significativa
dfuller y1, trend lags(1) regress

* dfgls sin tendencia. lags optimos = 1
dfgls y1, notrend

*No puedo que es I(0) al 1%
dfuller y1, lags(1) regress

* Diferencias, lags optimos = 1
dfgls D.y1
* tendencia determinística no significativa
dfuller D.y1, trend lags(1) regress

*lags optimos = 4
dfgls D.y1, notrend
* Serie es I(1) sin tendencia determinística
dfuller D.y1, lags(4) regress


*Lags optimos = 1
dfgls y2
* tendencia determinística no significativa
dfuller y2, trend lags(1) regress

* dfgls sin tendencia. lags optimos = 1
dfgls y2, notrend

*No puedo que es I(0) al 1%
dfuller y2, lags(1) regress

* Diferencias, lags optimos = 1
dfgls D.y2
* tendencia determinística no significativa
dfuller D.y2, trend lags(1) regress

*lags optimos = 1
dfgls D.y2, notrend
* Serie es I(1) sin tendencia determinística
dfuller D.y1, lags(1) regress



*Lags optimos = 1
dfgls y3
* tendencia determinística no significativa
dfuller y3, trend lags(1) regress

* dfgls sin tendencia. lags optimos = 1
dfgls y3, notrend

*No puedo que es I(0) al 1%
dfuller y3, lags(1) regress

* Diferencias, lags optimos = 1
dfgls D.y3
* tendencia determinística no significativa
dfuller D.y3, trend lags(1) regress

*lags optimos = 1
dfgls D.y3, notrend
* Serie es I(1) sin tendencia determinística
dfuller D.y3, lags(1) regress

* 4)
tsline y1 y2 y3

* 5) Usaremos 1 lag según criterio de Schwartz
varsoc y1 y2 y3

* 6) No rechazo r=2 (traza) ni r<=2 (max) en los tests. Hay 2 relaciones de cointegración
vecrank y1 y2 y3, trend(none) lags(1) max levela

* 7)
vec y1 y2 y3, trend(none) rank(2) lags(1)

* 8)
* Pi es 3x3 y capta el efecto total a largo plazo. Es de rango reducido (2)
matrix list e(pi)

* alpha es 3x2. 3 variables y 2 relaciones de cointegración. Corrección de desvios en el corto plazo
matrix list e(alpha)

* Beta son los vectores de cointegración 2x3 que capta la relación a largo plazo
matrix list e(beta)

* 9) Test de autocorrelación de errores. No puedo rechazar no autocorrelación
veclmar

* 10) Dos raíces dentro del círculo unitario.
* La otra es exactamente unitaria producto de la integración de primer orden. Es estable
vecstable, graph

log close