unit LISTADOS;

interface
uses
  Arboles, SysUtils,archivos_conductores, archivos_infracciones,validaciones,Manejo_conductores,Manejo_Infracciones,florituras,crt,math;
procedure ListarConductores(var arbol_apynom: PUNTERO;var arch_cond: ARCHIVO_CONDUCTORES);
procedure ListarInfraccionesEntreFechas(var arch_inf: ARCHIVO_INFRACCIONES;var fechaInicio, fechaFin: FECHA);
procedure Infracciones_cond(var arch_inf:ARCHIVO_INFRACCIONES; var dni_buscado:string);
procedure scoring_cero(var arch_cond:ARCHIVO_CONDUCTORES);



implementation
  procedure pagina_cond(arbol_apynom: PUNTERO; min, max: cardinal; var datos: datos_conductores; var arch_cond: ARCHIVO_CONDUCTORES; var contador: cardinal; var y: cardinal; n: cardinal);
  begin
    if arbol_apynom <> nil then
    begin
      pagina_cond(arbol_apynom^.SAI, min, max, datos, arch_cond, contador, y, n);

      Inc(contador);
      if (contador >= min) and (contador <= max) then
      begin
        seek(arch_cond, arbol_apynom^.INFO.pos);
        read(arch_cond, datos);
        gotoxy(n, y);
        write(datos.apynom);
        gotoxy(n + 27, y);
        write(datos.dni);
        gotoxy(n + 36, y);
        write(datos.puntos);
        gotoxy(n + 43, y);
        if datos.estado=true then
          write('alta')
        else if datos.estado=false then
          write('baja');
        y := y + 2;
      end;

      if contador < max then
        pagina_cond(arbol_apynom^.SAD, min, max, datos, arch_cond, contador, y, n);
    end;
  end;

  procedure ListarConductores(var arbol_apynom: PUNTERO; var arch_cond: ARCHIVO_CONDUCTORES);
var
    datos: datos_conductores;
    numpag, cantpag: integer;
    tecla: char;
    contador, y, totalRegistros: cardinal;
    minPage, maxPage: cardinal;
begin
    reset(arch_cond);
    totalRegistros := filesize(arch_cond); // Obtener total de registros
    cantpag := ceil(totalRegistros / 10);  // Fórmula correcta para páginas
    numpag := 1;
    interfaz_cond;

    while tecla <> #27 do
    begin
        clrscr;
        interfaz_cond;
        contador := 0;
        y := 10;

        // Calcular límites de la página actual
        minPage := (numpag - 1) * 10 + 1;
        maxPage := numpag * 10;
        if maxPage > totalRegistros then
            maxPage := totalRegistros; // Ajustar última página

        pagina_cond(arbol_apynom, minPage, maxPage, datos, arch_cond, contador, y, 10);

        tecla := readkey;
        case tecla of
            #77: if (numpag < cantpag) then Inc(numpag); // Derecha
            #75: if (numpag > 1) then Dec(numpag);       // Izquierda
        end;
    end;

    close(arch_cond);
    readkey;
end;


  procedure ListarInfraccionesEntreFechas(var arch_inf: ARCHIVO_INFRACCIONES;var fechaInicio, fechaFin: FECHA);
var
  registro: datos_infracciones;
begin
  reset(arch_inf);

  while not eof(arch_inf) do
  begin
    read(arch_inf, registro);

    if (registro.fecha_infraccion.anio > fechaInicio.anio) or
       ((registro.fecha_infraccion.anio = fechaInicio.anio) and (registro.fecha_infraccion.mes > fechaInicio.mes)) or
       ((registro.fecha_infraccion.anio = fechaInicio.anio) and (registro.fecha_infraccion.mes = fechaInicio.mes) and (registro.fecha_infraccion.dia >= fechaInicio.dia)) then
    begin
      if (registro.fecha_infraccion.anio < fechaFin.anio) or
         ((registro.fecha_infraccion.anio = fechaFin.anio) and (registro.fecha_infraccion.mes < fechaFin.mes)) or
         ((registro.fecha_infraccion.anio = fechaFin.anio) and (registro.fecha_infraccion.mes = fechaFin.mes) and (registro.fecha_infraccion.dia <= fechaFin.dia)) then
      begin
        writeln('DNI: ', registro.DNI);
        writeln('Fecha Infraccion: ', registro.fecha_infraccion.dia, '/', registro.fecha_infraccion.mes, '/', registro.fecha_infraccion.anio);
        writeln('Infraccion: ', registro.infrac);
        case registro.infrac of
        1: writeln('Descripcion: No respetar indicaciones Autoridad dirige Tránsito');
        2: writeln('Descripcion: Conducir con Licencia Vencida o Caduca');
        3: writeln('Descripcion: Licencia o documentación habilitante vencida (transporte público)');
        4: writeln('Descripcion: Conducir sin anteojos o lentes contacto según Licencia');
        5: writeln('Descripcion: Conducir con licencia conductor No Correspondiente');
        6: writeln('Descripcion: Permitir Conducir con licencia conductor No Correspondiente(titular o transporte)');
        7: writeln('Descripcion: Permitir Conducir c/licencia conductor No Correspondiente(titular o transporte)');
        8: writeln('Descripcion: Sistemas o dispositivos de retención infantil');
        9: writeln('Descripcion: No uso cinturón de seguridad');
        10: writeln('Descripcion: Permitir Viajar personas impedidas en asiento delantero');
        11: writeln('Descripcion: Girar a izquierda o derecha en lugar prohibido');
        12: writeln('Descripcion: Marcha atrás en forma indebida');
        13: writeln('Descripcion: Obstruccion de via (en carriles exclusivos y metrobus y premetro)');
        14: writeln('Descripcion: Obstruir vía Transversal,Ciclovía,Vereda,Estac. reservado');
        15: writeln('Descripcion: Obstruir lugar reservado Vehíc. Persona discapac. RAMPA discapac.');
        16: writeln('Descripcion: No ceder Paso a Polic,Bombe,Ambula,Serv.Pub.o Urgen.');
        17: writeln('Descripcion: No respetar Senda Peatonal,Paso Peatonal');
        18: writeln('Descripcion: Conducir utilizando Celular,Auriculares,Reproductor de video');
        19: writeln('Descripcion: Conductor redactando,enviando mensaje de texto');
        20: writeln('Descripcion: Circulación en sentido contrario');
        21: writeln('Descripcion: Invasión parcial de vías');
        22: writeln('Descripcion: No respetar paso o cartel PARE en bocacalle');
        23: writeln('Descripcion: Interrumpir Filas Escolares');
        24: writeln('Descripcion: Prohibido circular según DÍA,HORA,CARAC.VEHIC y.u OCUPANTES (MOTO)');
        25: writeln('Descripcion: Infracción régimen motovehículos');
        26: writeln('Descripcion: Violar Luz Roja');
        27: writeln('Descripcion: Violacion de semáforos (taxis, escolares , pasajeros, remises. Prestando servicio)');
        28: writeln('Descripcion: Exceso de velocidad de 10% a 30% ms de la velocidad permitida');
        29: writeln('Descripcion: No Cumplir Normas sin requisitos Vehículos de Transporte con habilitación');
        30: writeln('Descripcion: Requisitos de los vehículos de transporte de carga sin habilitación');
        31: writeln('Descripcion: Violación de barreras ferroviarias');
        32: writeln('Descripcion: Violación de límites de velocidad mayor al 30% permitido');
        33: writeln('Descripcion: Requisitos de los vehículos de transporte de carga');
        34: writeln('Descripcion: Placas de dominio');
        35: writeln('Descripcion: Circular con antiradar o antifoto');
        36: writeln('Descripcion: Conducción peligrosa');
        37: writeln('Descripcion: Conducir bajo la influencia de alcohol');
        38: writeln('Descripcion: Negativa a someterse a control de alcoholemia, estupefacientes');
        39: writeln('Descripcion: Taxis, transporte de escolares, remises, vehículos de fantasía sin autorización');
        40: writeln('Descripcion: Conducir con mayor cantidad de alcohol en sangre del permitido o bajo los efectos de estupefacientes');
        41: writeln('Descripcion: Incumplir obligaciones legales');
        42: writeln('Descripcion: Participar u organizar picadas');
        end;
        writeln;
      end;
    end;
  end;

  close(arch_inf);
end;
  procedure Infracciones_cond(var arch_inf:ARCHIVO_INFRACCIONES; var dni_buscado:string);
  var
  registro: datos_infracciones;
  begin
  while not(eof(arch_inf)) do
        begin
        read(arch_inf,registro);
        if registro.dni=dni_buscado then
        begin
          writeln;
          writeln('Fecha Infracción: ', registro.fecha_infraccion.dia, '/', registro.fecha_infraccion.mes, '/', registro.fecha_infraccion.anio);
          writeln('Infracción: ', registro.infrac);
          writeln;
        end;
  end;
  end;
  procedure scoring_cero(var arch_cond:ARCHIVO_CONDUCTORES);
  var
  r: datos_conductores;
  begin
  while not(eof(arch_cond)) do
  begin
       read(arch_cond,r);
       if r.puntos=0 then
          writeln(r.apynom);
  end;
end;

end.
