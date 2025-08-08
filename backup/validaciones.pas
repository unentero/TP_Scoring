unit VALIDACIONES;

{$mode objfpc}{$H+}

interface

uses
   SysUtils, crt;
Type
    FECHA = RECORD
      dia:byte;
      mes:byte;
      anio:integer;
    end;
    FECHA_2 = record
      dia:string[4];
      mes:string[4];
      anio:string[4];
    end;
Procedure verificar_telefono(var clave:string;x,y:cardinal);
Procedure verificar_dni(var clave:string;x,y:cardinal);
Procedure verificar_email(var clave:string;x,y:cardinal);
Procedure verificar_todo_letras(var clave:string;x,y:cardinal);
Procedure verificar_fecha(var clave:string;x,y:cardinal);
procedure ConvertirFechaStringADate(var fechaRecord: FECHA; fechaString: string);
implementation

function numero(car: string): boolean;
begin
     case car of
     '0' .. '9': numero:= true;
     else
     numero:=false;
end;
end;

function letra(car: string): boolean;
begin
     car:= UpCase(car);
     case car of
     ' ': letra:= true;
     'A' .. 'Z': letra:= true;
     else
     letra:=false;
end;
end;

function todo_numeros(clave: string): boolean;
var
  i: byte;
  car: string;
begin
     todo_numeros:= true;
     for i:= 1 to (length(clave)) do
     begin
          car:= copy(clave, i, 1);
          if not(numero(car)) then
          begin
          todo_numeros:= false;
          end;
     end;
end;
Procedure verificar_todo_numeros(var clave:string;x,y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until todo_numeros(clave);
end;

function todo_letras(clave: string): boolean;
var
  i: byte;
  car: string;
begin
     todo_letras:= true;
     for i:= 1 to (length(clave)) do
     begin
          car:= copy(clave, i, 1);
          if not(letra(car)) then
          begin
          todo_letras:= false;
          end;
     end;
end;
Procedure verificar_todo_letras(var clave:string;x:cardinal;y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until todo_letras(clave);
end;
function es_dia(dia:string):boolean;
var
  clave:integer;
begin
     if (todo_numeros(dia)) then
     begin
         clave:=strtoint(dia);
         if (clave<=31) and (clave>0) then
         es_dia:=true;
     end
     else
         es_dia:=false;
end;
function es_mes(mes:string):boolean;
var
  clave:integer;
begin
     if (todo_numeros(mes)) then
     begin
         clave:=strtoint(mes);
         if (clave<=12) and (clave>0) then
         es_mes:=true;
     end
     else
         es_mes:=false;
end;
function es_anio(anio:string):boolean;
var
  clave:integer;
begin
     if (todo_numeros(anio)) then
     begin
         clave:=strtoint(anio);
         if (clave<2030) and (clave>1850) then
         es_anio:=true;
     end
     else
         es_anio:=false;
end;
procedure ConvertirFechaStringADate(var fechaRecord: FECHA; fechaString: string);
var
  diaStr, mesStr, anioStr: string;
begin
  diaStr := Copy(fechaString, 1, 2);
  mesStr := Copy(fechaString, 4, 2);
  anioStr := Copy(fechaString, 7, 4);

  Val(diaStr, fechaRecord.dia);
  Val(mesStr, fechaRecord.mes);
  Val(anioStr, fechaRecord.anio);
end;
function EsFechaValida(fecha: string): Boolean;
var
  dia, mes, anio: Integer;
begin
  // Verificar la longitud del string
  if Length(fecha) <> 10 then
  begin
    EsFechaValida := False;
    Exit;
  end;

  // Verificar que los separadores sean '/'
  if (fecha[3] <> '/') or (fecha[6] <> '/') then
  begin
    EsFechaValida := False;
    Exit;
  end;

  // Extraer día, mes y año
  try
    dia := StrToInt(Copy(fecha, 1, 2));
    mes := StrToInt(Copy(fecha, 4, 2));
    anio := StrToInt(Copy(fecha, 7, 4));
  except
    // Si ocurre una excepción al convertir, la fecha no es válida
    EsFechaValida := False;
    Exit;
  end;

  // Validar el año
  if (anio < 1) or (anio > 9999) then
  begin
    EsFechaValida := False;
    Exit;
  end;

  // Validar el mes
  if (mes < 1) or (mes > 12) then
  begin
    EsFechaValida := False;
    Exit;
  end;

  // Validar el día
  case mes of
    1, 3, 5, 7, 8, 10, 12:
      if (dia < 1) or (dia > 31) then
      begin
        EsFechaValida := False;
        Exit;
      end;
    4, 6, 9, 11:
      if (dia < 1) or (dia > 30) then
      begin
        EsFechaValida := False;
        Exit;
      end;
    2:
      // Validar febrero y años bisiestos
      if (anio mod 4 = 0) and ((anio mod 100 <> 0) or (anio mod 400 = 0)) then
      begin
        if (dia < 1) or (dia > 29) then
        begin
          EsFechaValida := False;
          Exit;
        end;
      end
      else
      begin
        if (dia < 1) or (dia > 28) then
        begin
          EsFechaValida := False;
          Exit;
        end;
      end;
  end;

  // Si todas las validaciones pasan, la fecha es válida
  EsFechaValida := True;
end;
Procedure verificar_fecha(var clave:string;x:cardinal;y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until EsFechaValida(clave);
end;
Procedure verificar_email(var clave:string; x,y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until (pos('@',clave)<>0) and (pos('@',clave)<pos('.',clave));
end;
Procedure verificar_telefono(var clave:string; x,y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until (todo_numeros(clave)) and (length(clave)<9) and (length(clave)>6);
end;

Procedure verificar_dni(var clave:string; x,y:cardinal);
begin
repeat
  gotoxy(x,y);
  readln(clave)
until (todo_numeros(clave)) and (length(clave)=8); //no digo que el dni puede ser mayor a 8 unicamente porque para cuando los dni empiecen por 100 millones no creo que usen este sistema.
end;
end.
