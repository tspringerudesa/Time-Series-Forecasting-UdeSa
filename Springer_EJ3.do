*limpiamos
clear all

*seteamos el directorio
global main "C:\Users\Windows\Desktop\Facultad\Pronosticos\Ejs Pronosticos\EjPronosticos3"
cd "$main"

*importamos solo la hoja con los valores fijos
import excel using Springer_Urbieta_EJ3.xlsx, sheet(Hoja2) firstrow clear

*generamos la variable tiempo
gen tiempo =_n
tsset tiempo

*renombramos variables
ren AR105 y1
ren AR109 y2
ren WN et


*regresamos yt con el periodo anterior y unimos las regresiones en una sola tabla
reg y1 L.y1, nocons
outreg2 using "Reg_rho_05_09.rtf", replace title("Regresion sobre AR(1)") ///
	append ctitle("Rho 0.5") label

reg y2 L.y2, nocons
outreg2 using "Reg_rho_05_09.rtf", append ctitle("Rho 0.9") label


ac y1
graph export "correlograma_05.png", replace
pac y1
graph export "autocorrelograma_05.png", replace

ac y2
graph export "correlograma_09.png", replace
pac y2
graph export "autocorrelograma_09.png", replace
