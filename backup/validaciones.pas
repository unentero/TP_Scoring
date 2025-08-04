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
function todo_letras(clave: string): boolean;
function todo_numeros(clave: string): boolean;
function es_dia(dia:string):boolean;
function es_mes(mes:string):boolean;
function es_anio(anio:string):boolean;
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


end.
