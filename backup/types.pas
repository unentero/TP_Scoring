unit TYPES;
{$codepage utf8}
interface
const
  ruta1='D:\Desktop\ARCHIVOS TPFINAL\conductores.dat';
  ruta2='D:\Desktop\ARCHIVOS TPFINAL\infracciones.dat' ;
  n=100;
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

    // CONDUCTORES
    datos_conductores = record
      DNI:string[8];
      apynom:string[70];
      Nacimiento:FECHA;
      Telefono:string[15];
      Mail:String[100];
      puntos: 0..20;
      habilitado: boolean;
      fecha_hab:FECHA;
      reinc:0..n;
		end;
   ARCHIVO_CONDUCTORES = file of datos_conductores;

   datos_infracciones= record
     DNI:string[8];
     fecha_infraccion:FECHA;
     infrac:1..85;
     desc:0..20;
   end;
   ARCHIVO_INFRACCIONES = file of datos_infracciones;
   //ARBOL
   DATO_ARBOL = record
     clave:string[70];
     pos:cardinal;
   end;
   PUNTERO = ^NODO;
   NODO = RECORD
     INFO:DATO_ARBOL;
     SAI,SAD: PUNTERO;
     end;
   implementation
   end.

