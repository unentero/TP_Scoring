unit ARCHIVOS_CONDUCTORES;

{$mode objfpc}{$H+}

interface
uses
  crt,validaciones;
const
  ruta1='/home/admin/Documentos/Facultad/TP_Scoring/ARCHIVOS TPFINAL/conductores.dat';
  //ruta1='C:\Scoring\conductores.dat';
  n=100;
    type
    datos_conductores = record
      DNI:string[8];
      apynom:string[70];
      Nacimiento:FECHA;                                         //definicion del archivo de conductores
      Telefono:string[15];
      Mail:String[100];
      puntos: integer;
      habilitado: boolean;
      estado:boolean;
      fecha_hab:FECHA;
      fecha_deshab:FECHA;
      reinc:0..n;
    end;
   ARCHIVO_CONDUCTORES = file of datos_conductores;
procedure crear_archivo_conductores(var arch_cond: ARCHIVO_CONDUCTORES);
procedure abrir_archivo_conductores(var arch_cond: ARCHIVO_CONDUCTORES);
implementation

// Procedimientos crear archivos
procedure crear_archivo_conductores(var arch_cond: ARCHIVO_CONDUCTORES);
begin
    assign(arch_cond, ruta1);    // Asigna
    rewrite(arch_cond);           // Crea
end;

// Procedimientos abrir archivos
procedure abrir_archivo_conductores(var arch_cond: ARCHIVO_CONDUCTORES);
begin
     assign(arch_cond, ruta1);    // Asigna
     reset(arch_cond);             // Abre
end;
end.
