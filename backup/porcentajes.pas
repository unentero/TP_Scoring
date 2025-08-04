unit Porcentajes;

interface

uses
  SysUtils, crt,DateUtils,archivos_conductores, archivos_infracciones,VALIDACIONES,Manejo_conductores,Manejo_Infracciones;

function CalcularEdad(fechaNacimiento: FECHA): Integer;
procedure ContarInfraccionesEntreFechas(var archivoInfracciones: ARCHIVO_INFRACCIONES; fechaInicio, fechaFin: FECHA; var count: Integer);
function PorcentajeReincidencia(var archivoConductores: ARCHIVO_CONDUCTORES): Real;
function PorcentajeScoring0(var archivoConductores: ARCHIVO_CONDUCTORES): Real;
procedure CalcularTotal(var archivoConductores: ARCHIVO_CONDUCTORES; var archivoInfracciones: ARCHIVO_INFRACCIONES);
function RangoEtarioConMasInfracciones(var archivoConductores: ARCHIVO_CONDUCTORES; var archivoInfracciones: ARCHIVO_INFRACCIONES): string;

implementation

function CalcularEdad(fechaNacimiento: FECHA): Integer;
var
  fechaActual: TDateTime;
begin
  fechaActual := Now;
  Result := YearOf(fechaActual) - fechaNacimiento.anio;

  if (MonthOf(fechaActual) < fechaNacimiento.mes) or ((MonthOf(fechaActual) = fechaNacimiento.mes) and (DayOf(fechaActual) < fechaNacimiento.dia))
  then Dec(Result);
end;

procedure ContarInfraccionesEntreFechas(var archivoInfracciones: ARCHIVO_INFRACCIONES;fechaInicio, fechaFin: FECHA; var count: Integer);
var
  datosInfraccion: datos_infracciones;
begin
  Reset(archivoInfracciones);
  count := 0;

  while not EOF(archivoInfracciones) do
  begin
    Read(archivoInfracciones, datosInfraccion);

    if (CompareDate(EncodeDate(datosInfraccion.fecha_infraccion.anio,datosInfraccion.fecha_infraccion.mes, datosInfraccion.fecha_infraccion.dia), EncodeDate(fechaInicio.anio,fechaInicio.mes, fechaInicio.dia)) >= 0) and
      (CompareDate(EncodeDate(datosInfraccion.fecha_infraccion.anio,
      datosInfraccion.fecha_infraccion.mes, datosInfraccion.fecha_infraccion.dia), EncodeDate(fechaFin.anio,
      fechaFin.mes, fechaFin.dia)) <= 0) then
    begin
      Inc(count);
    end;
  end;

  Close(archivoInfracciones);
end;

function PorcentajeReincidencia(var archivoConductores: ARCHIVO_CONDUCTORES): Real;
var
  datosConductor: datos_conductores;
  totalConductores, conductoresConReincidencia: Integer;
begin
  Reset(archivoConductores);
  totalConductores := 0;
  conductoresConReincidencia := 0;

  while not EOF(archivoConductores) do
  begin
    Read(archivoConductores, datosConductor);
    Inc(totalConductores);

    if datosConductor.reinc > 0 then
      Inc(conductoresConReincidencia);
  end;

  Close(archivoConductores);

  if totalConductores > 0 then
    Result := (conductoresConReincidencia / totalConductores) * 100
  else
    Result := 0;
end;

function PorcentajeScoring0(var archivoConductores: ARCHIVO_CONDUCTORES): Real;
var
  datosConductor: datos_conductores;
  totalConductores, conductoresScoring0: Integer;
begin
  Reset(archivoConductores);
  totalConductores := 0;
  conductoresScoring0 := 0;

  while not EOF(archivoConductores) do
  begin
    Read(archivoConductores, datosConductor);
    Inc(totalConductores);

    if datosConductor.puntos = 0 then
      Inc(conductoresScoring0);
  end;

  Close(archivoConductores);

  if totalConductores > 0 then
    Result := (conductoresScoring0 / totalConductores) * 100
  else
    Result := 0;
end;

procedure CalcularTotal(var archivoConductores: ARCHIVO_CONDUCTORES; var archivoInfracciones: ARCHIVO_INFRACCIONES);
begin
  // Implementar lógica basada en lo que se considere como una métrica relevante para la municipalidad.
  // Este es un marcador de posición; reemplazarlo con tu implementación real.
end;

function RangoEtarioConMasInfracciones(var archivoConductores: ARCHIVO_CONDUCTORES;
  var archivoInfracciones: ARCHIVO_INFRACCIONES): string;
var
  datosConductor: datos_conductores;
  datosInfraccion: datos_infracciones;
  age: Integer;
  ageRangeCount: array [1..3] of Integer; // 1: <30, 2: 31-50, 3: >50
  maxCount, maxIndex: Integer;
begin
  Reset(archivoConductores);
  Reset(archivoInfracciones);

  FillChar(ageRangeCount, SizeOf(ageRangeCount), 0);

  // Count infractions in each age range
  while not EOF(archivoConductores) do
  begin
    Read(archivoConductores, datosConductor);
    age := CalcularEdad(datosConductor.Nacimiento);

    if age < 30 then
      Inc(ageRangeCount[1])
    else if (age >= 31) and (age <= 50) then
      Inc(ageRangeCount[2])
    else
      Inc(ageRangeCount[3]);
  end;

  // Find the age range with the most infractions
  {maxCount := ageRangeCount[1];
  maxIndex := 1;

  while not EOF(archivoInfracciones) do
  begin
    Read(archivoInfracciones, datosInfraccion);
    age := Calcularedad(datosInfraccion.fecha_infraccion);

    if age < 30 then
      Inc(ageRangeCount[1])
    else if (age >= 31) and (age <= 50) then
      Inc(ageRangeCount[2])
    else
      Inc(ageRangeCount[3]);
  end;

  Close(archivoConductores);
  Close(archivoInfracciones);
  }
  // Find the age range with the most infractions
  maxCount := ageRangeCount[1];
  maxIndex := 1;

  for age := 2 to 3 do
  begin
    if ageRangeCount[age] > maxCount then
    begin
      maxCount := ageRangeCount[age];
      maxIndex := age;
    end;
  end;

  // Return the corresponding age range
  case maxIndex of
    1: Result := 'Menores de 30';
    2: Result := 'Entre 31 y 50';
    3: Result := 'Mayores de 50';
  end;
end;
end.
