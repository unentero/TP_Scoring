unit Manejo_conductores;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, Archivos_conductores,arboles;
procedure leer_registros_conductores(var arch_cond: ARCHIVO_CONDUCTORES; pos: cardinal; var regs: DATOS_CONDUCTORES);
procedure agregar_registro_conductores(var arch_cond: ARCHIVO_CONDUCTORES; r: DATOS_CONDUCTORES);
procedure busqueda_cond(raiz: puntero; var pos: integer; var clave: string);
implementation
// Procedimientos leer registros
procedure leer_registros_conductores(var arch_cond: ARCHIVO_CONDUCTORES; pos: cardinal; var regs: DATOS_CONDUCTORES);
begin
     seek(arch_cond, pos);    // Posicionar indice
     read(arch_cond, regs);    // Leer registros
end;
// Agregar registro a arbol
procedure agregar_registro_conductores(var arch_cond: ARCHIVO_CONDUCTORES; r: DATOS_CONDUCTORES);
var
  p: integer;
begin
     reset(arch_cond);
     p := Filesize(arch_cond);
     seek(arch_cond, p);
     write(arch_cond, r);
     close(arch_cond);
end;
//busqueda de un conductor
procedure busqueda_cond(raiz: puntero; var pos: integer; var clave: string);
var
  nodo: puntero;
begin
     pos:= -1;
     nodo:= PREORDEN(raiz, clave);
     if nodo <> nil then
     begin
          pos:= nodo^.info.pos;
     end;
end;
end.

