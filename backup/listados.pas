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
    tecla:=#0;
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
end;

  procedure pagina_inf(min, max: cardinal; datos: datos_infracciones; var arch_inf: ARCHIVO_INFRACCIONES; var contador: cardinal; var y: cardinal; n: cardinal;var pos:integer; condicion:boolean);
  var
  fecha: string;
  begin
    seek(arch_inf, pos);
    read(arch_inf, datos);
    if condicion then
    begin
      inc(contador);
      if (contador >= min) and (contador <= max) then
      begin
        fecha:=IntToStr(datos.fecha_infraccion.dia)+'-'+IntToStr(datos.fecha_infraccion.mes)+'-'+IntToStr(datos.fecha_infraccion.anio);
        gotoxy(n+1, y);
        write(fecha);
        gotoxy(n + 17, y);
        write(datos.dni);
        gotoxy(n + 33, y);
        case datos.infrac of
          1: write('No respetar indicaciones Autoridad dirige Tránsito');
          2: write('Conducir con Licencia Vencida o Caduca');
          3: write('Licencia o documentación habilitante vencida');
          4: write('Conducir sin anteojos o lentes contacto según Licencia');
          5: write('Conducir con licencia conductor No Correspondiente');
          6: write('Permitir Conducir con licencia conductor No Correspondiente');
          7: write('Permitir Conducir c/licencia conductor No Correspondiente');
          8: write('Sistemas o dispositivos de retención infantil');
          9: write('No uso cinturón de seguridad');
          10: write('Permitir Viajar personas impedidas en asiento delantero');
          11: write('Girar a izquierda o derecha en lugar prohibido');
          12: write('Marcha atrás en forma indebida');
          13: write('Obstruccion de via');
          14: write('Obstruir vía Transversal,Ciclovía,Vereda,Estac. reservado');
          15: write('Obstruir lugar reservado Vehíc. Persona discapac. RAMPA discapac.');
          16: write('No ceder Paso a Polic,Bombe,Ambula,Serv.Pub.o Urgen.');
          17: write('No respetar Senda Peatonal,Paso Peatonal');
          18: write('Conducir utilizando Celular,Auriculares,Reproductor de video');
          19: write('Conductor redactando,enviando mensaje de texto');
          20: write('Circulación en sentido contrario');
          21: write('Invasión parcial de vías');
          22: write('No respetar paso o cartel PARE en bocacalle');
          23: write('Interrumpir Filas Escolares');
          24: write('Prohibido circular según DÍA,HORA,CARAC.VEHIC y.u OCUPANTES');
          25: write('Infracción régimen motovehículos');
          26: write('Violar Luz Roja');
          27: write('Violacion de semáforos (taxis, escolares , pasajeros, remises. Prestando servicio)');
          28: write('Exceso de velocidad de 10% a 30% ms de la velocidad permitida');
          29: write('No Cumplir Normas sin requisitos Vehículos de Transporte con habilitación');
          30: write('Requisitos de los vehículos de transporte de carga sin habilitación');
          31: write('Violación de barreras ferroviarias');
          32: write('Violación de límites de velocidad mayor al 30% permitido');
          33: write('Requisitos de los vehículos de transporte de carga');
          34: write('Placas de dominio');
          35: write('Circular con antiradar o antifoto');
          36: write('Conducción peligrosa');
          37: write('Conducir bajo la influencia de alcohol');
          38: write('Negativa a someterse a control de alcoholemia, estupefacientes');
          39: write('Taxis, transporte de escolares, remises, vehículos de fantasía sin autorización');
          40: write('Conducir bajo los efectos de estupefacientes');
          41: write('Incumplir obligaciones legales');
          42: write('Participar u organizar picadas');
        end;
        y := y + 2;
      end;
    end;
  end;
  procedure pagina_inf_cond(min, max: cardinal; datos: datos_infracciones; var arch_inf: ARCHIVO_INFRACCIONES; var contador: cardinal; var y: cardinal; n: cardinal;var pos:integer; condicion:boolean);
    var
    fecha: string;
    Descuento: integer;
    begin
      seek(arch_inf, pos);
      read(arch_inf, datos);
      if condicion then
      begin
        inc(contador);
        if (contador >= min) and (contador <= max) then
        begin
          fecha:=IntToStr(datos.fecha_infraccion.dia)+'-'+IntToStr(datos.fecha_infraccion.mes)+'-'+IntToStr(datos.fecha_infraccion.anio);
          gotoxy(n+1, y);
          write(fecha);
          gotoxy(n + 17, y);
          case datos.infrac of
            1: Descuento:= 2;
            2..17: Descuento:= 4;
            18..28: Descuento := 5;
            29..41: Descuento := 10;
            42: Descuento := 20;
           end;
          end;
          write(-Descuento);
          gotoxy(n + 33, y);
          case datos.infrac of
            1: write('No respetar indicaciones Autoridad dirige Tránsito');
            2: write('Conducir con Licencia Vencida o Caduca');
            3: write('Licencia o documentación habilitante vencida');
            4: write('Conducir sin anteojos o lentes contacto según Licencia');
            5: write('Conducir con licencia conductor No Correspondiente');
            6: write('Permitir Conducir con licencia conductor No Correspondiente');
            7: write('Permitir Conducir c/licencia conductor No Correspondiente');
            8: write('Sistemas o dispositivos de retención infantil');
            9: write('No uso cinturón de seguridad');
            10: write('Permitir Viajar personas impedidas en asiento delantero');
            11: write('Girar a izquierda o derecha en lugar prohibido');
            12: write('Marcha atrás en forma indebida');
            13: write('Obstruccion de via');
            14: write('Obstruir vía Transversal,Ciclovía,Vereda,Estac. reservado');
            15: write('Obstruir lugar reservado Vehíc. Persona discapac. RAMPA discapac.');
            16: write('No ceder Paso a Polic,Bombe,Ambula,Serv.Pub.o Urgen.');
            17: write('No respetar Senda Peatonal,Paso Peatonal');
            18: write('Conducir utilizando Celular,Auriculares,Reproductor de video');
            19: write('Conductor redactando,enviando mensaje de texto');
            20: write('Circulación en sentido contrario');
            21: write('Invasión parcial de vías');
            22: write('No respetar paso o cartel PARE en bocacalle');
            23: write('Interrumpir Filas Escolares');
            24: write('Prohibido circular según DÍA,HORA,CARAC.VEHIC y.u OCUPANTES');
            25: write('Infracción régimen motovehículos');
            26: write('Violar Luz Roja');
            27: write('Violacion de semáforos (taxis, escolares , pasajeros, remises. Prestando servicio)');
            28: write('Exceso de velocidad de 10% a 30% ms de la velocidad permitida');
            29: write('No Cumplir Normas sin requisitos Vehículos de Transporte con habilitación');
            30: write('Requisitos de los vehículos de transporte de carga sin habilitación');
            31: write('Violación de barreras ferroviarias');
            32: write('Violación de límites de velocidad mayor al 30% permitido');
            33: write('Requisitos de los vehículos de transporte de carga');
            34: write('Placas de dominio');
            35: write('Circular con antiradar o antifoto');
            36: write('Conducción peligrosa');
            37: write('Conducir bajo la influencia de alcohol');
            38: write('Negativa a someterse a control de alcoholemia, estupefacientes');
            39: write('Taxis, transporte de escolares, remises, vehículos de fantasía sin autorización');
            40: write('Conducir bajo los efectos de estupefacientes');
            41: write('Incumplir obligaciones legales');
            42: write('Participar u organizar picadas');
          end;
          y := y + 2;
        end;
      end;
procedure ListarInfraccionesEntreFechas(var arch_inf: ARCHIVO_INFRACCIONES;var fechaInicio, fechaFin: FECHA);
var
  datos: datos_infracciones;
  pos: integer;
  numpag, cantpag: integer;
  tecla: char;
  contador, y, totalRegistros, registrosFiltrados: cardinal;
  minPage, maxPage: cardinal;
  condicion:boolean;
begin
  reset(arch_inf);
  totalRegistros := filesize(arch_inf);

  // Primero contar cuantos registros cumplen con el filtro de fecha
  registrosFiltrados := 0;
  for pos := 0 to totalRegistros - 1 do
  begin
    seek(arch_inf, pos);
    read(arch_inf, datos);
    if ver_fecha_entrefechas(datos.fecha_infraccion, fechaInicio, fechaFin) then
    inc(registrosFiltrados);
  end;

  cantpag := ceil(registrosFiltrados / 10);
  numpag := 1;
  tecla := #0;
  while tecla <> #27 do
  begin
    clrscr;
    interfaz_inf;
    contador := 0;
    y := 10;
    pos := 0;
    minPage := (numpag - 1) * 10 + 1;
    maxPage := numpag * 10;
    reset(arch_inf);
          while (pos < totalRegistros) and (contador < maxPage) do
          begin
            condicion:=ver_fecha_entrefechas(datos.fecha_infraccion, fechaInicio, fechaFin);
            pagina_inf_cond(minPage, maxPage, datos, arch_inf, contador, y, 10, pos,condicion);
            inc(pos);
          end;
          tecla := readkey;
          case tecla of
              #77: if (numpag < cantpag) then Inc(numpag); // Derecha
              #75: if (numpag > 1) then Dec(numpag);       // Izquierda
          end;
      end;
      close(arch_inf);
    end;

procedure Infracciones_cond(var arch_inf: ARCHIVO_INFRACCIONES; var dni_buscado: string);
var
  datos: datos_infracciones;
  pos: integer;
  numpag, cantpag: integer;
  tecla: char;
  contador, y, totalRegistros, registrosFiltrados: cardinal;
  minPage, maxPage: cardinal;
  condicion: boolean;
begin
  reset(arch_inf);
  totalRegistros := filesize(arch_inf);

  // Primero contar cuantos registros cumplen con la condicion
  registrosFiltrados := 0;
  for pos := 0 to (totalRegistros-1) do
  begin
    seek(arch_inf, pos);
    read(arch_inf, datos);
    if datos.DNI = dni_buscado then
      inc(registrosFiltrados);
  end;

  cantpag := ceil(registrosFiltrados / 10);
  numpag := 1;
  tecla := #0;

  while tecla <> #27 do
  begin
    clrscr;
    interfaz_inf_cond;
    contador := 0;
    y := 10;
    minPage := (numpag - 1) * 10 + 1;
    maxPage := numpag * 10;

    //reset(arch_inf);
    pos := 0;
    while (pos < totalRegistros) and (contador < maxPage) do
    begin
      seek(arch_inf, pos);
      read(arch_inf, datos);
      condicion := (datos.DNI = dni_buscado);

      if condicion then
      begin
        inc(contador);
        if (contador >= minPage) and (contador <= maxPage) then
        begin
          pagina_inf(minPage, maxPage, datos, arch_inf, contador, y, 10, pos,condicion);
          inc(y);
        end;
      end;
      inc(pos);
    end;

    tecla := readkey;
    case tecla of
      #77: if (numpag < cantpag) then Inc(numpag); // Derecha
      #75: if (numpag > 1) then Dec(numpag);       // Izquierda
    end;
  end;
  close(arch_inf);
end;

  procedure scoring_cero(var arch_cond:ARCHIVO_CONDUCTORES);
    var
      r: datos_conductores;
      registrosFiltrados,pos,contador,y: integer;
      tecla: char;

    begin
      reset(arch_cond);
      contador := 0;
      y := 13; // Posicion vertical inicial
      begin
        reset(arch_cond);
        clrscr;
        Colocar('Listado de Conductores Con Scoring 0',lightblue,10,10);
        colocar('-----------------------------------------------------',lightblue,10,y-1);
        colocar('Apellido y nombre: ',lightblue,10,y); colocar('DNI: ',lightblue,50,y);
        colocar('-----------------------------------------------------',lightblue,10,y+1);

        // Mostrar todos los registros de una vez
        while not(eof(arch_cond)) and (tecla<>#27) do
        begin
          read(arch_cond, r);
          if r.puntos = 0 then
          begin
            gotoxy(29, y);
            write(r.apynom);
            gotoxy(50, y);
            write(r.dni);
            y := y + 1;
            contador := contador + 1;

            // Pausa cada 20 registros
            if contador mod 20 = 0 then
            begin
              tecla := readkey;
              clrscr;
              Colocar('Presione cualquier tecla para continuar (ESC para salir)...',green,10,8);
              Colocar('Listado de Conductores Con Scoring 0',lightblue,10,10);
              colocar('-----------------------------------------------------',lightblue,10,y-1);
              colocar('Apellido y nombre: ',lightblue,10,y); colocar('DNI: ',lightblue,50,y);
              colocar('-----------------------------------------------------',lightblue,10,y+1);
        y := 3; // Reiniciar posicion vertical
            end;
          end;
        end;
      end;
      if (contador=0) then
      begin
        clrscr;
        colocar('No hay conductores con Scoring 0', red,10,10);
      end;
      close(arch_cond);
    end;

end.
