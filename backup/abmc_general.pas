unit ABMC_GENERAL;
{$codepage utf8}
interface
uses
  ARBOLES,ARCHIVOS_CONDUCTORES,ARCHIVOS_INFRACCIONES,TYPES,FLORITURAS,VALIDACIONES,crt,sysutils,Manejo_conductores,Manejo_Infracciones;

procedure ABMC_CONDUCTORES (var arch_cond: ARCHIVO_CONDUCTORES;var arch_inf: ARCHIVO_INFRACCIONES;var arbol_dni: PUNTERO; var arbol_apynom: PUNTERO);
procedure alta_conductores(var arch_cond: ARCHIVO_CONDUCTORES; var arbol_dni: PUNTERO; var arbol_apynom: PUNTERO;var a:string);
implementation
//Conductor
// Procedimientos Utiles Conductores
procedure muestra_conductores(reg:DATOS_CONDUCTORES);
var arch_cond: ARCHIVO_CONDUCTORES; pos: integer;
begin
    clrscr;
    gotoxy (30,3);
    textcolor(11);
    writeln ('******************** Datos del Conductor ********************');
    textcolor(15);
    gotoxy (42,6);
    write('DNI: ',reg.DNI);
    gotoxy (42,8);
    write('APELLIDO(S) Y NOMBRE(S): ', reg.apynom);
    gotoxy (42,10);
    write('TELEFONO: ', reg.TELEFONO);
    gotoxy (42,12);
    write('E-MAIL: ', reg.MAIL);
    gotoxy (42,14);
    write('PUNTOS: ', reg.PUNTOS);
    gotoxy (42,16);
    write('¿ESTÁ HABILITADO?: ', reg.HABILITADO);
    gotoxy (42,18);
   writeln('FECHA DE HABILITACION: ');
    gotoxy (64,18);
    write(reg.FECHA_HAB.dia);
    gotoxy (66,18);
    write(' / ');
    gotoxy (70,18);
    write(reg.FECHA_HAB.mes);
    gotoxy (72,18);
    write(' / ');
    gotoxy (75,18);
    write(reg.FECHA_HAB.anio);
    gotoxy (42,20);
    write('CANTIDAD DE REINCIDENCIAS: ', reg.REINC);
end;

// Procedimientos para modificar Conductores
procedure modificacion(var arch_cond: ARCHIVO_CONDUCTORES; pos: cardinal; i:byte);
var
  x: DATOS_CONDUCTORES;
  modificado:string;
  res:string[1];
begin
    clrscr;
    reset(arch_cond);
    leer_registros_conductores(arch_cond, pos, x);
    close(arch_cond);
    muestra_conductores(x);
    case i of
    1: begin
       colocar('Telefono Nuevo: ',9,80,10);
       gotoxy(80,11);
       readln(modificado);
       x.telefono:= modificado;
      end;
    2:begin
       colocar('Nuevo e-mail: ',9,80,10);
       gotoxy(80,11);
       readln(modificado);
       x.mail:=modificado;
       end;
    end;
    colocar('Esta seguro de modificar? s/n',15,80,15);
    colocar('- ',15,80,16);
    readln(res);
    if (res='s')or(res='S') then
    begin
    reset(arch_cond);
    seek(arch_cond, pos);
    write(arch_cond, x);
    close(arch_cond);
    colocar('Modificación realizada exitosamente',lightgreen,40,25);
    end
    else
    colocar('No se modificó',red,40,25);
    pulse_para_continuar;
end;
procedure menu_modificacion(var arch_cond: ARCHIVO_CONDUCTORES; pos: cardinal; nombre:string );
var
  op: string[1];
begin
    repeat
     gotoxy (40,28);
     textcolor(11);
     writeln('- Modificacion:');
     textcolor(15);
     gotoxy (40,32);
     writeln('Que quiere modificar de ', nombre, '?');
     gotoxy (40,34);
     write('1. Telefono ');
     gotoxy (40,36);
     writeln('2. Mail ');
     gotoxy (40,38);
     gotoxy (40,44);
     writeln('0. Salir');
     gotoxy (40,46);
     writeln('- ');
     gotoxy (42,46);
     readln(op);
     case op of
     '1': modificacion(arch_cond, pos, 1);
     '2': modificacion(arch_cond, pos, 2);
     else
     if (op<>'')and(op<>'0') then
     begin
         colocar('Opción inválida. Vuelva a intentarlo',12,50,46);
         pulse_para_continuar;
     end;
     end;
     until (op='0');
end;
procedure modificacion_conductores (var arch_cond: ARCHIVO_CONDUCTORES; arbol_cond: PUNTERO; buscado: string);
var
  pos: integer;
begin
    busqueda_cond(arbol_cond,pos,buscado);
    if pos >= 0 then
    begin
        menu_modificacion(arch_cond,pos,buscado);
    end;
end;

// Procedimientos par alta Conductores
procedure cargar_conductores(var arch_cond: ARCHIVO_CONDUCTORES; var r: DATOS_CONDUCTORES; var x:string);
var
 dia, mes, anio:word;
 ans:char;
 apynom,telefono,email:string;
begin
     titulo (' Alta de la Persona ');
     begin
           r.habilitado:= true;
           r.DNI:=x;
           colocar('DNI: ' + x,15,40,7);
           colocar('APELLIDO(S) Y NOMBRE(S): ',15,40,9);
           verificar_todo_letras(apynom,66,9);
           r.apynom:=apynom;
           colocar('TELEFONO: ',15,40,11);
           verificar_telefono(telefono,51,11);
           r.telefono:=telefono;
           colocar('E-MAIL: ',15,40,13);
           verificar_email(email,49,13);
           r.Mail :=email;
           r.puntos:=20;
           r.habilitado:=true;
           colocar('FECHA DE HABILITACIÓN: ',15,40,19);
           colocar(FormatDateTime('(dd/mm/yyyy)',Date),15,63,19);
           DecodeDate(Date,anio,mes,dia);
           r.fecha_hab.dia := dia;
           r.fecha_hab.mes := mes;
           r.fecha_hab.anio := anio;
           r.REINC:=0;
       end;
end;

procedure alta_conductores(var arch_cond: ARCHIVO_CONDUCTORES; var arbol_dni: PUNTERO; var arbol_apynom: PUNTERO;var a:string);
var
  r: DATOS_CONDUCTORES;
  x: DATO_ARBOL;
  flag: boolean;
  res:string[1];
begin
     cargar_conductores(arch_cond,r,a);
     begin
         colocar('Esta seguro de Agregar? s/n',15,80,15);
         colocar('- ',15,80,16);
         readln(res);
         if (res='s')or(res='S') then
         begin
         agregar_registro_conductores(arch_cond, r);
         x.clave:= r.DNI;
         reset(arch_cond);
         x.pos:= (filesize(arch_cond)-1);
         close(arch_cond);
         AGREGAR_ARBOL(arbol_dni, x);
         x.clave:= r.apynom;
         AGREGAR_ARBOL(arbol_apynom, x);
         colocar('Conductor ingresado correctamente', 10, 40 ,26);
         end
         else
         colocar('No se Agregó',red,40,25);
         pulse_para_continuar;
     end;
end;

// Procedimientos para baja Conductores
procedure dar_baja(var arch_cond:ARCHIVO_CONDUCTORES;pos: cardinal );
var
  x:DATOS_CONDUCTORES;
  rta:char;
  dia,mes,anio:word;
begin
    gotoxy(30,24);
    write('¿Está seguro que desea dar de baja a esta persona? S/N: ');
    readln(rta);
    if UpCase(rta)='S' then
    begin
         abrir_archivo_conductores(arch_cond);
         leer_registros_conductores(arch_cond,pos,x);
         x.habilitado:=false;
         FormatDateTime('(dd/mm/yyyy)'+'|',Date)
         DecodeDate(Date,anio,mes,dia);
         x.fecha_deshab.dia:=dia;
         x.fecha_deshab.mes:= mes + (x.reinc mod 12);
         x.fecha_deshab.anio:=anio + (x.reinc div 12);
         seek(arch_cond, pos);
         write(arch_cond, x);
         close(arch_cond);
         colocar('Baja realizada exitosamente',lightgreen,30,25);
    end
    else
    begin
         textcolor(lightgreen);
         gotoxy(30,26);
         writeln('No se ha dado de baja al Conductor');
         textcolor(15);
    end;
    pulse_para_continuar;
end;
procedure baja_conductores(var arch_cond: ARCHIVO_CONDUCTORES; arbol_cond: PUNTERO; buscado: string; var reg: DATOS_CONDUCTORES);
var
  pos: integer;
begin
    busqueda_cond(arbol_cond,pos,buscado);
    if pos >= 0 then
    begin
        reset(arch_cond);
        leer_registros_conductores(arch_cond, pos, reg);
        close(arch_cond);
        if reg.habilitado = true then
        begin
            clrscr;
            muestra_conductores(reg);
            dar_baja(arch_cond, pos);
        end;
        end;
    end;

// Procedimientos para consulta conductores
procedure consulta_conductores(var arch_cond: ARCHIVO_CONDUCTORES; var buscado: string; var pos:integer);
var
  reg: DATOS_CONDUCTORES;
begin
         reset(arch_cond);
         leer_registros_conductores(arch_cond, pos, reg);
         close(arch_cond);
         if reg.habilitado = true then
         muestra_conductores(reg)
         else
         begin
        colocar ('El conductor fue dado de baja',15,40,15);
         end;

end;
procedure ABMC_CONDUCTORES (var arch_cond: ARCHIVO_CONDUCTORES;var arch_inf: ARCHIVO_INFRACCIONES;var arbol_dni: PUNTERO; var arbol_apynom: PUNTERO);
var
  pos:integer;
  op, x,y:string;
  reg: DATOS_CONDUCTORES;
begin
  clrscr;
  colocar('Ingrese DNI de conductor',15,42,6);
  colocar('En caso de no tenerlo, escriba 0 para buscar por Nombre',15,42,7);
  colocar('- ',15,42,8);
  verificar_dni(x,44,8);
      if x = '0' then
      begin
        colocar('Ingrese el Apellido y Nombre del Conductor',15,42,10);
        colocar('- ',15,42,11);
        verificar_todo_letras(y,44,11);
        busqueda_cond(arbol_apynom,pos,y);
        if pos = -1 then
           begin
           colocar ('El Conductor buscado no se encuentra en el Sistema',4,42,13);
           colocar ('Si quiere darlo de alta, presione 1 y escriba el DNI',15,42,14) ;
           colocar ('sino presione 0 para salir',15,42,15);
           colocar ('1 - Alta / 0 - Salir',10,42,16);
           colocar ('- ',15,42,17);
           repeat
           gotoxy(44,17);
           readln(op);
           until (op = '0') or (op = '1');
            if op = '1' then
              begin
               colocar('Ingrese DNI de Conductor',15,42,18);
               colocar('- ',15,42,19);
               verificar_dni(x,44,19);
               alta_conductores(arch_cond,arbol_dni,arbol_apynom,x);
              end;
           end;
      end
      else
      busqueda_cond(arbol_dni,pos,x);
     if (pos >= 0) then
        begin
        // muestra/ consulta
        consulta_conductores(arch_cond,x,pos);
        // modificacion/ baja
        colocar ('¿Qué desea realizar?',3,36,25);
        colocar ('1 - Baja / 2 - Modificación / otra tecla - Salir',10,46,26);
        colocar ('- ',15,46,27);
        gotoxy(48,27);
        readln(op);
        case op of
        '1':begin
            baja_conductores(arch_cond,arbol_dni,x,reg);
            end;
        '2':modificacion_conductores(arch_cond,arbol_dni,x);
        else
        pulse_para_continuar;
        clrscr;
        end;
        end
     else
        //alta
        begin
        if (op = '0') or (op = '1') then
        begin
        end
        else
        begin
        colocar ('El conductor buscado no se encuentra en el Sistema',4,42,13);
        colocar ('Quiere darlo de alta?',15,42,14);
        colocar ('1 - Si / otra tecla - No',10,42,15);
        colocar ('- ',15,42,16);
        gotoxy(44,16);
        readln(op);
        case op of
        '1':alta_conductores(arch_cond,arbol_dni,arbol_apynom,x);
        end;
        end;
        end;
end;
end.
