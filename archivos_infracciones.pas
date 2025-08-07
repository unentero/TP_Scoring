unit ARCHIVOS_INFRACCIONES;

{$mode objfpc}{$H+}

interface
uses
  crt,validaciones;
const
ruta2='/home/admin/Documentos/Facultad/TP_Scoring/ARCHIVOS TPFINAL/infracciones.dat' ;
//ruta2='C:\Scoring\infracciones.dat';
n=100;
type
datos_infracciones= record
     DNI:string[8];                                             //definicion del archivo infracciones
     fecha_infraccion:FECHA;
     infrac:integer;
   end;
   ARCHIVO_INFRACCIONES = file of datos_infracciones;

procedure crear_archivo_infracciones(var arch_inf: ARCHIVO_INFRACCIONES);
procedure abrir_archivo_infracciones(var arch_inf: ARCHIVO_INFRACCIONES);
implementation
// Procedimiento crear archivos
procedure crear_archivo_infracciones(var arch_inf: ARCHIVO_INFRACCIONES);
begin
    assign(arch_inf, ruta2);    // Asigna
    rewrite(arch_inf);        // Crea
end;
// Procedimiento abrir archivos
procedure abrir_archivo_infracciones(var arch_inf: ARCHIVO_INFRACCIONES);
begin
     assign(arch_inf, ruta2);    // Asigna
     reset(arch_inf);          // Abre
end;
// Procedimiento cerrar archivos
procedure cerrar_archivo_infracciones(var arch_inf: ARCHIVO_INFRACCIONES);
begin
     close(arch_inf);    // Cierra
end;
end.
