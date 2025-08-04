unit Manejo_Infracciones;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils,archivos_infracciones,arboles;
procedure agregar_registro_infracciones(var arch_inf:ARCHIVO_INFRACCIONES; r: DATOS_INFRACCIONES);
procedure leer_registro_infracciones(var arch_inf: ARCHIVO_INFRACCIONES; pos: cardinal; var reg: DATOS_INFRACCIONES);
procedure busqueda_infracciones(var arch_inf:ARCHIVO_INFRACCIONES;var pos: integer; var buscado:string);
implementation
// Procedimientos leer registros
procedure leer_registro_infracciones(var arch_inf: ARCHIVO_INFRACCIONES; pos: cardinal; var reg: DATOS_INFRACCIONES);
begin
     reset(arch_inf);
     seek(arch_inf, pos);    // Posicionar indice
     read(arch_inf, reg);   // Leer registro
     close(arch_inf)
end;

//Devuelve la posición de una infracción en el archivo
procedure busqueda_infracciones(var arch_inf:ARCHIVO_INFRACCIONES;var pos: integer; var buscado:string);
var
r:datos_infracciones;
begin
while not(eof(arch_inf)) do
      seek(arch_inf,filepos(arch_inf));
      read(arch_inf,r);
      if buscado=r.dni then
      begin
       pos:=filepos(arch_inf);
      end;
end;
// Agregar registro a arbol
procedure agregar_registro_infracciones(var arch_inf:ARCHIVO_INFRACCIONES; r: DATOS_INFRACCIONES);
var
  p: integer;
begin
         abrir_archivo_infracciones(arch_inf);
         p:= Filesize(arch_inf);
         seek(arch_inf, p);
         write(arch_inf, r);
         close(arch_inf);
end;
end.

