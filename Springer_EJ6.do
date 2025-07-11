*seteamos el directorio
global main "C:\Users\Windows\Desktop\Facultad\Pronosticos\Ejs Pronosticos\EjPronosticos6"
cd "$main"
*---------------------------------Ejercicio 2-----------------------------------------*
clear
set obs 5000
set seed 1
gen a=rnormal(1,1)
gen b=rnormal(-1,1)

gen mix = 0.5*a + 0.5*b

twoway ///
(kdensity a, lcolor(blue)) ///
(kdensity b, lcolor(blue) ) ///
(kdensity mix, lcolor(red) ) ///
, legend(label(1 "a ~ N(1,1)") label(2 "b ~ N(-1,1)") label(3 "mix 0.5*a + 0.5*b")) ///
title("Densidad Kernel de a, b y mix")

gen c=rnormal(0,2)

twoway ///
(kdensity c, lcolor(green)) ///
(kdensity mix, lcolor(red) ) ///
, legend(label(1 "c ~ N(0,2)") label(2 "mix")) ///
title("Densidad Kernel de c y mix")


*---------------------------------Ejercicio 3-----------------------------------------*

*importamos solo la hoja con los valores fijos
import excel using P_Ejercitacion_6_Excel_Datos.xlsx, sheet(Ej3) firstrow clear

*eliminamos
drop Años
drop G
drop I

*renombramos
ren FECHA time
ren Meses r3m
ren Año r1y
ren E r3y
ren F r5y
ren H r10y

*seteamos la variable tiempo
tsset time

*testamos a significatividad del 1%
set level 99

*regresión
reg r3y r1y
outreg2 using "Reg_r1y_r3y.rtf", replace title("Regresion r1y sobre r3y")

*guardamos residuos
predict res, residual

*autocorrelograma
ac res
graph export "ac_res_reg1.png", replace

*autocorrelograma parcial
pac res
graph export "pac_res_reg1.png", replace

* ADF
dfuller r1y, lags(20) trend regress
dfuller r1y, lags(20)

dfuller r3y, lags(20)  trend regress
dfuller r3y, lags(20)

*ADF con diferencias
dfuller D.r1y, lags(20) trend regress
dfuller D.r1y, lags(20)

dfuller D.r3y, lags(20)  trend regress
dfuller D.r3y, lags(20)

*regresión con diferencias
reg D.r3y D.r1y
outreg2 using "Reg_diffs_r1y_r3y.rtf", replace title("Regresion diferencias r1y sobre r3y")
predict resdiff, residuals

dfuller resdiff, lags(20) trend regress
dfuller resdiff, lags(20)
ac resdiff
pac resdiff

*---------------------------------Ejercicio 5-----------------------------------------*
clear

set obs 250
set seed 1
gen u=rnormal()
gen v=rnormal()
gen y1 = sum(u)
gen y2 = sum(v)

gen time = _n
tsset time

*Gráfico
tsline y1 y2
graph export "y1_y2.png", replace

*regresión
reg y2 y1
*reportamos valores t
outreg2 using "Reg_y2_y1.rtf", replace title("Regresion y2 en y1") tstat

*test durwin-watson
estat dwatson
predict restime, residual

*suma de residuos
gen sumres = sum(restime)
tsline sumres /// visualizamos la suma

* autocorrelogramas
ac restime
pac restime

* elegimos cantidad optima de lags y hacemos el test de raíz unitaria
dfgls dlws
dfuller restime, lags(1)


