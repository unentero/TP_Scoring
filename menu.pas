unit MENU;
{$codepage utf8}
interface
uses
  crt,FLORITURAS,ARBOLES,ARCHIVOS_INFRACCIONES,ARCHIVOS_CONDUCTORES,ABMC_GENERAL,LISTADOS,Porcentajes,VALIDACIONES,AMC_INFRACCIONES,Manejo_conductores,Manejo_Infracciones;
procedure iniciar;
implementation
//menu de Listados
procedure menu_listados (var arbol_apynom: PUNTERO;var arch_cond: ARCHIVO_CONDUCTORES; var arch_inf: ARCHIVO_INFRACCIONES);
var
  op:char;
  fechaInicio, fechaFin: FECHA;
  fecha1,fecha2:string;
  dni_buscado:string;
begin
  repeat
  clrscr;
  colocar ('MENÚ LISTADOS',15,45,6);
  colocar ('1. Listado ordenado por Apellido y Nombres de Conductores',15,37,8);
  colocar ('2. Listado ordenado por fecha de todas las infracciones entre dos fechas',15,37,10);
  colocar ('3. Listado ordenado por fecha de todas las infracciones de un conductor entre dos fechas',15,37,12);
  colocar ('4. Listado de los infractores a los cuales su scoring llegó a 0',15,37,14);
  colocar ('0. Salir',15,37,16);
  colocar ('> ',15,37,18);
  gotoxy (39,18);
  readln(op);
     case op of
     '1':begin
       ListarConductores(arbol_apynom,arch_cond);
       end;
     '2':begin
       clrscr;
       colocar('Ingrese fecha de inicio (DD/MM/AAAA):',15,10,10);
       verificar_fecha(fecha1,47,10);
       ConvertirFechaStringADate(fechainicio,fecha1);
       colocar('Ingrese fecha de final (DD/MM/AAAA):',15,10,12);
       verificar_fecha(fecha2,46,12);
       ConvertirFechaStringADate(fechafin,fecha2);
       ListarInfraccionesEntreFechas(arch_inf,fechaInicio,fechaFin);
       end;
     '3':begin
       Infracciones_cond(arch_inf,dni_buscado);
       end;
     '4':begin
       scoring_cero(arch_cond);
        end;
     end;
       if op<>'0' then
       begin
       colocar('Opción inválida. Vuelva a intentarlo',12,40,22);
       pulse_para_continuar;
       end;
     until op='0' ;
end;
//menu de estadisticas
procedure menu_estadisticas(var arch_cond: ARCHIVO_CONDUCTORES; var arch_inf: ARCHIVO_INFRACCIONES);
var
  op:string[1];
  fechaInicio, fechaFin: FECHA;
  fecha1,fecha2:string;
  count: Integer;
begin
  repeat
  clrscr;
  colocar(' MENÚ ESTADÍSTICAS ',15,45,6);
  colocar('1. Cantidad de infracciones entre dos fechas',15,37,8);
  colocar('2. Porcentaje de conductores con reincidencia',15,37,10);
  colocar('3. Porcentaje de conductores con scoring 0',15,37,12);
  colocar('4. Cantidad de conductores menores de edad',15,37,14);
  colocar('5. Rango etario con más infracciones',15,37,16);
  colocar('0. Salir',15,37,18);
  colocar('> ',15,37,20);
  gotoxy (39,20);
  readln(op);
     case op of
     '1':begin
       writeln('Ingrese fecha de inicio (DD/MM/AAAA)');
       readln(fecha1);
       ConvertirFechaStringADate(fechainicio,fecha1);
       writeln('Ingrese fecha de final (DD/MM/AAAA)');
       readln(fecha2);
       ConvertirFechaStringADate(fechafin,fecha2);
       ContarInfraccionesEntreFechas(arch_inf,fechaInicio,fechaFin,count);
       end;
     '2':PorcentajeReincidencia(arch_cond);
     '3':PorcentajeScoring0(arch_cond);
     '4':ContarMenores(arch_cond);
     '5':RangoEtarioConMasInfracciones(arch_cond,arch_inf);
     else
       if op<>'0' then
       begin
       writeln('Opción inválida. Vuelva a intentarlo',12,40,22);
       pulse_para_continuar
       end;
     end;
     until op='0' ;
end;
//menu principal
procedure menu_principal(var arch_cond: ARCHIVO_CONDUCTORES; var arch_inf:ARCHIVO_INFRACCIONES;var arbol_apynom:PUNTERO; var arbol_dni: puntero);
var
  op:string[1];
begin
  repeat
  clrscr;
   colocar(' MENÚ PRINCIPAL ',11,45,6);
   colocar('1. Gestión de conductores',15,30,8);
   colocar('2. Gestión de infracciones',15,30,10);
   colocar('3. Listados',15,30,12);
   colocar('4. Estadisticas',15,30,14);
   colocar('0. Salir de la aplicación',15,30,16);
   colocar('> ',15,30,18);
   gotoxy (32,18);
   readln(op);
   case op of
   '1':ABMC_CONDUCTORES (arch_cond, arch_inf, arbol_dni, arbol_apynom);
   '2':AMBC_INFRACCIONES (arch_cond,arch_inf,arbol_dni,arbol_apynom,arch_inf);
   '3':menu_listados(arbol_apynom,arch_cond,arch_inf);
   '4':menu_estadisticas(arch_cond,arch_inf);
   else
   if op<>'0' then
   begin
       colocar('Opción inválida. Vuelva a intentarlo',12,40,22);
       pulse_para_continuar
   end;
   end;
     until op='0' ;
end;
// Existen arhivos
function existe_arch_cond (var arch_cond: ARCHIVO_CONDUCTORES): boolean;
var respuesta: char;
  begin
       clrscr;
       assign(arch_cond, ruta1);
       {$I-}
       reset(arch_cond);
       {$I+}
       if IOResult <> 0 then
       begin
           write('No existe el archivo de conductores, ¿desea crear uno?(S/N): ');
           readln(respuesta);
           case UpCase(respuesta) of
           'N': begin
             colocar('Cerrando el programa.',12,17,55);
             existe_arch_cond:= false;
             pulse_para_continuar
           end;
           'S': begin
             crear_archivo_conductores(arch_cond);
             close(arch_cond);
             existe_arch_cond:= true;
             colocar('Archivo creado exitosamente!',10,17,55);
             pulse_para_continuar
           end;
           else
           begin
           colocar(' Opción inválida. Vuelva a intentarlo. ',12,17,40);
           pulse_para_continuar
           end;
           end;
       end
       else
       begin
         existe_arch_cond:= true;
         close(arch_cond);
       end;
  end;
function existe_arch_infracciones (var arch_inf: ARCHIVO_INFRACCIONES): boolean;
var respuesta: char;
  begin
       clrscr;
       assign(arch_inf, ruta2);
       {$I-}
       reset(arch_inf);
       {$I+}
       if IOResult <> 0 then
       begin
           gotoxy(15,40);
           write('No existe el archivo de infracciones, ¿desea crear uno?(S/N): ');
           readln(respuesta);
           case UpCase(respuesta) of
           'N': begin
             colocar('Cerrando el programa.',12,17,55);
             existe_arch_infracciones:= false;
             pulse_para_continuar
           end;
           'S': begin
             crear_archivo_infracciones(arch_inf);
             close(arch_inf);
             existe_arch_infracciones:= true;
             colocar('Archivo creado exitosamente!',10,17,55);
             pulse_para_continuar
           end;
           end;
       end
       else
       begin
         existe_arch_infracciones:= true;
         close(arch_inf);
       end;
  end;
// Arboles
procedure ARBOL_COND(var raiz_apynom, raiz_dni:PUNTERO; var arch_cond: ARCHIVO_CONDUCTORES);
var
  x:DATOS_CONDUCTORES;
  i:byte;
  x_ar: DATO_ARBOL;
begin
  crear_arbol(raiz_apynom);
  crear_arbol(raiz_dni);
  abrir_archivo_conductores(arch_cond);
  i:=0;
  while (not(EOF(arch_cond)) and not(arbol_lleno(raiz_apynom)))do
  begin
    seek(arch_cond,i);
    read(arch_cond,x);
    x_ar.clave:= x.apynom;
    x_ar.pos:= i;
    AGREGAR_ARBOL(raiz_apynom,x_ar);
    x_ar.clave:= x.DNI;
    AGREGAR_ARBOL(raiz_dni,x_ar);
    inc(i);
  end;
  close(arch_cond);
end;

// Programa
procedure iniciar;
var
  arch_cond: ARCHIVO_CONDUCTORES;
  arch_inf: ARCHIVO_INFRACCIONES;
  arbol_apynom: PUNTERO;
  arbol_dni: PUNTERO;
begin
inicio;
 if (existe_arch_cond(arch_cond)) and (existe_arch_infracciones(arch_inf)) then
 begin
      ARBOL_COND (arbol_apynom,arbol_dni,arch_cond);
      menu_principal(arch_cond, arch_inf, arbol_apynom, arbol_dni);
 end;
end;
end.
