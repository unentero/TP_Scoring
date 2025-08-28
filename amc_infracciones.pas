unit AMC_INFRACCIONES;
{$codepage utf8}
interface
uses
  ARBOLES, ABMC_GENERAL,crt,ARCHIVOS_INFRACCIONES,ARCHIVOS_CONDUCTORES,SysUtils,florituras,validaciones,Manejo_conductores,Manejo_Infracciones;

procedure AMBC_INFRACCIONES (var arch_cond: ARCHIVO_CONDUCTORES; var arch_inf:ARCHIVO_INFRACCIONES; var arbol_dni:PUNTERO;var arbol_apynom:PUNTERO;var arch_infr: ARCHIVO_INFRACCIONES);
implementation
Procedure Pag_infracciones(numpag: integer; index: longword);
var
  x, y: cardinal;
begin
  case numpag of
    0: begin
      colocar('1      No respetar indicaciones Autoridad dirige Transito (-2)                                            ', 15, 10, 10);
      colocar('2      Conducir con Licencia Vencida o Caduca (-4)                                                        ', 15, 10, 11);
      colocar('3      Licencia o documentacion habilitante vencida (transporte publico) (-4)                           ', 15, 10, 12);
      colocar('4      Conducir sin anteojos o lentes contacto segun Licencia (-4)                                        ', 15, 10, 13);
      colocar('5      Conducir con licencia conductor No Correspondiente (-4)                                            ', 15, 10, 14);
      colocar('6      Permitir Conducir con licencia conductor No Correspondiente(titular o transporte) (-4)             ', 15, 10, 15);
      colocar('7      Permitir Conducir c/licencia conductor No Correspondiente(titular o transporte) (-4)               ', 15, 10, 16);
      colocar('8      Sistemas o dispositivos de retencion infantil (-4)                                                ', 15, 10, 17);
      colocar('9      No uso cinturon de seguridad (-4)                                                                 ', 15, 10, 18);
      colocar('10     Permitir Viajar personas impedidas en asiento (-4)                                                ', 15, 10, 19);
      colocar('11     Girar a izquierda o derecha en lugar prohibido (-4)                                               ', 15, 10, 20);
      colocar('12     Marcha atras en forma indebida (-4)                                                               ', 15, 10, 21);
      colocar('13     Obstruccion de via (en carriles exclusivos y metrobus y premetro) (-4)                            ', 15, 10, 22);
      colocar('14     Obstruir via Transversal,Ciclovia,Vereda,Estac. reservado (-4)                                   ', 15, 10, 23);
      colocar('15     Obstruir lugar reservado Vehic. Persona discapac. RAMPA discapac. (-4)                            ', 15, 10, 24);

      case index of
        1:  colocar_res('1      No respetar indicaciones Autoridad dirige Transito (-2)', 1, 10, 10);
        2:  colocar_res('2      Conducir con Licencia Vencida o Caduca (-4)', 1, 10, 11);
        3:  colocar_res('3      Licencia o documentacion habilitante vencida (transporte publico) (-4)', 1, 10, 12);
        4:  colocar_res('4      Conducir sin anteojos o lentes contacto segun Licencia (-4)', 1, 10, 13);
        5:  colocar_res('5      Conducir con licencia conductor No Correspondiente (-4)', 1, 10, 14);
        6:  colocar_res('6      Permitir Conducir con licencia conductor No Correspondiente(titular o transporte) (-4)', 1, 10, 15);
        7:  colocar_res('7      Permitir Conducir c/licencia conductor No Correspondiente(titular o transporte) (-4)', 1, 10, 16);
        8:  colocar_res('8      Sistemas o dispositivos de retencion infantil (-4)', 1, 10, 17);
        9:  colocar_res('9      No uso cinturon de seguridad (-4)', 1, 10, 18);
        10: colocar_res('10     Permitir Viajar personas impedidas en asiento delantero (-4)', 1, 10, 19);
        11: colocar_res('11     Girar a izquierda o derecha en lugar prohibido (-4)', 1, 10, 20);
        12: colocar_res('12     Marcha atras en forma indebida (-4)', 1, 10, 21);
        13: colocar_res('13     Obstruccion de via (en carriles exclusivos y metrobus y premetro) (-4)', 1, 10, 22);
        14: colocar_res('14     Obstruir via Transversal,Ciclovia,Vereda,Estac. reservado (-4)', 1, 10, 23);
        15: colocar_res('15     Obstruir lugar reservado Vehic. Persona discapac. RAMPA discapac. (-4)', 1, 10, 24);
      end;
    end;

    1: begin
      colocar('16     No ceder Paso a Polic,Bombe,Ambula,Serv.Pub.o Urgen. (-4)                                         ', 15, 10, 10);
      colocar('17     No respetar Senda Peatonal,Paso Peatonal (-4)                                                     ', 15, 10, 11);
      colocar('18     Conducir utilizando Celular,Auriculares,Reproductor de video (-5)                                 ', 15, 10, 12);
      colocar('19     Conductor redactando,enviando mensaje de texto (-5)                                               ', 15, 10, 13);
      colocar('20     Circulacion en sentido contrario (-5)                                                             ', 15, 10, 14);
      colocar('21     Invasion parcial de vias (-5)                                                                     ', 15, 10, 15);
      colocar('22     No respetar paso o cartel PARE en bocacalle (-5)                                                  ', 15, 10, 16);
      colocar('23     Interrumpir Filas Escolares (-5)                                                                  ', 15, 10, 17);
      colocar('24     Prohibido circular segun DIA,HORA,CARAC.VEHIC y.u OCUPANTES (MOTO) (-5)                           ', 15, 10, 18);
      colocar('25     Infraccion regimen motovehiculos (-5)                                                             ', 15, 10, 19);
      colocar('26     Violar Luz Roja (-5)                                                                              ', 15, 10, 20);
      colocar('27     Violacion de semaforos (taxis, escolares , pasajeros, remises. Prestando servicio) (-5)           ', 15, 10, 21);
      colocar('28     Exceso de velocidad de 10% a 30% ms de la velocidad permitida (-5)                                ', 15, 10, 22);
      colocar('29     No Cumplir Normas sin requisitos Vehiculos de Transporte con habilitacion (-10)                   ', 15, 10, 23);
      colocar('30     Requisitos de los vehiculos de transporte de carga sin habilitacion (-10)                         ', 15, 10, 24);

      case index of
        1:  colocar_res('16     No ceder Paso a Polic,Bombe,Ambula,Serv.Pub.o Urgen. (-4)', 1, 10, 10);
        2:  colocar_res('17     No respetar Senda Peatonal,Paso Peatonal (-4)', 1, 10, 11);
        3:  colocar_res('18     Conducir utilizando Celular,Auriculares,Reproductor de video (-5)', 1, 10, 12);
        4:  colocar_res('19     Conductor redactando,enviando mensaje de texto (-5)', 1, 10, 13);
        5:  colocar_res('20     Circulacion en sentido contrario (-5)', 1, 10, 14);
        6:  colocar_res('21     Invasion parcial de vias (-5)', 1, 10, 15);
        7:  colocar_res('22     No respetar paso o cartel PARE en bocacalle (-5)', 1, 10, 16);
        8:  colocar_res('23     Interrumpir Filas Escolares (-5)', 1, 10, 17);
        9:  colocar_res('24     Prohibido circular segun DIA,HORA,CARAC.VEHIC y.u OCUPANTES (MOTO) (-5)', 1, 10, 18);
        10: colocar_res('25     Infraccion regimen motovehiculos (-5)', 1, 10, 19);
        11: colocar_res('26     Violar Luz Roja (-5)', 1, 10, 20);
        12: colocar_res('27     Violacion de semaforos (taxis, escolares , pasajeros, remises. Prestando servicio) (-5)', 1, 10, 21);
        13: colocar_res('28     Exceso de velocidad de 10% a 30% de la velocidad permitida (-5)', 1, 10, 22);
        14: colocar_res('29     No Cumplir Normas sin requisitos Vehiculos de Transporte con habilitacion (-10)', 1, 10, 23);
        15: colocar_res('30     Requisitos de los vehiculos de transporte de carga sin habilitacion (-10)', 1, 10, 24);
      end;
    end;

    2: begin
      colocar('31     Violacion de barreras ferroviarias (-10)                                                          ', 15, 10, 10);
      colocar('32     Violacion de limites de velocidad mayor al 30% permitido (-10)                                    ', 15, 10, 11);
      colocar('33     Requisitos de los vehiculos de transporte de carga (-10)                                          ', 15, 10, 12);
      colocar('34     Placas de dominio (-10)                                                                           ', 15, 10, 13);
      colocar('35     Circular con antiradar o antifoto (-10)                                                           ', 15, 10, 14);
      colocar('36     Conduccion peligrosa (-10)                                                                        ', 15, 10, 15);
      colocar('37     Conducir bajo la influencia de alcohol (-10)                                                      ', 15, 10, 16);
      colocar('38     Negativa a someterse a control de alcoholemia, estupefacientes (-10)                              ', 15, 10, 17);
      colocar('39     Taxis, transporte de escolares, remises, vehiculos de fantasia sin autorizacion (-10)             ', 15, 10, 18);
      colocar('40     Conducir bajo los efectos de estupefacientes (-10)                                                ', 15, 10, 19);
      colocar('41     Incumplir obligaciones legales (-10)                                                              ', 15, 10, 20);
      colocar('42     Participar u organizar picadas (-20)                                                              ', 15, 10, 21);
      colocar('                                                                                                        ', 15, 10, 22);
      colocar('                                                                                                        ', 15, 10, 23);
      colocar('                                                                                                        ', 15, 10, 24);

      case index of
        1:  colocar_res('31     Violacion de barreras ferroviarias (-10)', 1, 10, 10);
        2:  colocar_res('32     Violacion de limites de velocidad mayor al 30% permitido (-10)', 1, 10, 11);
        3:  colocar_res('33     Requisitos de los vehiculos de transporte de carga (-10)', 1, 10, 12);
        4:  colocar_res('34     Placas de dominio (-10)', 1, 10, 13);
        5:  colocar_res('35     Circular con antiradar o antifoto (-10)', 1, 10, 14);
        6:  colocar_res('36     Conduccion peligrosa (-10)', 1, 10, 15);
        7:  colocar_res('37     Conducir bajo la influencia de alcohol (-10)', 1, 10, 16);
        8:  colocar_res('38     Negativa a someterse a control de alcoholemia, estupefacientes (-10)', 1, 10, 17);
        9:  colocar_res('39     Taxis, transporte de escolares, remises, vehiculos de fantasia sin autorizacion (-10)', 1, 10, 18);
        10: colocar_res('40     Conducir bajo los efectos de estupefacientes (-10)', 1, 10, 19);
        11: colocar_res('41     Incumplir obligaciones legales (-10)', 1, 10, 20);
        12: colocar_res('42     Participar u organizar picadas (-20)', 1, 10, 21);
      end;
    end;
  end;
end;
Procedure Tabla_infracciones(var infraccion: integer);
var
  numpag, cantpag,x,y,index, max_index: integer;
  tecla: char;
begin
  cantpag := 2;
  numpag := 0;
  index := 1;
  x := 10;
  tecla := #0; // Inicializar tecla
  Colocar('| N° Infracción | Descripción                                  |', lightblue, 10, 8);
  Colocar('+---------------+----------------------------------------------+', lightblue, 10, 9);
  while tecla<>#13 do
    begin
    Pag_infracciones(numpag,index); // Muestra las infracciones de la página actual
    y := 10 + (index-1); // Posición vertical correcta
    tecla := ReadKey;
    gotoxy(x,y);
    case tecla of
      #77: // Flecha derecha
        if numpag < cantpag then
        begin
          Inc(numpag);
          // Ajustar índice si se excede en página 2
          if (numpag = 2) and (index > 12) then
            index := 12;
        end;

      #75: // Flecha izquierda
        if numpag > 0 then
          Dec(numpag);

      #72: // Flecha arriba
        if index > 1 then
        begin
          Dec(index);
        end;
      #80: // Flecha abajo
      begin
        // Determinar máximo índice según página
        case numpag of
          0, 1: max_index := 15;
          2: max_index := 12;
        end;
        if index < max_index then
        begin
          Inc(index);
        end;
      end;
    end;
  end;
  case numpag of
    0: infraccion:=index;
    1: infraccion:= index + 15;
    2: infraccion:= index + 30;
  end;
end;
Procedure cargar_infraccion(var r: datos_infracciones;var x:string);
var
 dia, mes, anio:word;
 infraccion: integer;
begin
     titulo (' Infraccion ');
           r.DNI:=x;
           colocar('|Fecha Infraccion: '+(FormatDateTime('(dd/mm/yyyy)'+'|',Date)),green,36,6);
           colocar('|DNI conductor: '+r.DNI, green,10,6);
           colocar('(Navegue las infracciones con las flechas)',15,10,30);
           DecodeDate(Date,anio,mes,dia);
           r.fecha_infraccion.dia := dia;
           r.fecha_infraccion.mes := mes;
           r.fecha_infraccion.anio := anio;
           Tabla_infracciones(infraccion);
           r.infrac:=infraccion;
       end;

Procedure alta_infracciones(var arch_inf: ARCHIVO_INFRACCIONES; x:string; var infraccion:integer);
var
  r: DATOS_INFRACCIONES;
  res:char;
  pos:integer;
begin
     cargar_infraccion(r,x);
         colocar('Esta seguro de Agregar? s/n',lightblue,80,25);
         colocar('- ',15,80,26);
         gotoxy(81,26);
         readln(res);
         if Upcase(res)='S' then
         begin
         pos:=  Filesize(arch_inf);
         seek(arch_inf,pos);
         write(arch_inf, r);
         infraccion:= r.infrac;
         colocar('Infraccion ingresada correctamente', 10, 40 ,26);
         end
         else
         colocar('No se Agregó',red,40,25);
         pulse_para_continuar;
     end;
procedure modificacion_scoring(var arch_cond: ARCHIVO_CONDUCTORES; pos: integer; infraccion:integer);
var
  x: DATOS_CONDUCTORES;
  Descuento: Integer;

begin
    leer_registros_conductores(arch_cond, pos, x);
    if (x.puntos>0) then
      begin
      case infraccion of
        1: Descuento:= 2;
        2..17: Descuento:= 4;
        18..28: Descuento := 5;
        29..41: Descuento := 10;
        42: Descuento := 20;
      end;

       x.puntos:= x.puntos-Descuento;
       if x.puntos<0 then x.puntos:=0;

    seek(arch_cond, pos);
    write(arch_cond, x);
    if (x.puntos=0) then
       begin
            x.reinc:=x.reinc + 1;
            colocar('De de baja manualmente a este conductor, ya que tiene Scoring 0',red,40,26);
       end
       else colocar('Deduccion de puntos realizada exitosamente',lightgreen,40,26);
    end
    else
    colocar('No se restó puntos',red,40,26);
    pulse_para_continuar;
end;

Procedure AMBC_INFRACCIONES (var arch_cond: ARCHIVO_CONDUCTORES;var arch_inf:archivo_infracciones; var arbol_dni:PUNTERO;var arbol_apynom:PUNTERO;var arch_infr: ARCHIVO_INFRACCIONES);
var
  x,a:string;
  pos,infraccion,i,descuento:Integer;
  reg,r:DATOs_CONDUCTORES;
  res:string[1];
  b,find:boolean;
begin
abrir_archivo_conductores(arch_cond);
abrir_archivo_infracciones(arch_inf);
 clrscr;
  colocar('Ingrese DNI del conductor',15,42,6);
  colocar('En caso de no tenerlo, escriba 0 para buscar por nombre',15,42,7);
  colocar('- ',15,42,8);
  verificar_dni(x,44,8);
      if x = '0' then
      begin
        colocar('Ingrese el Nombre Completo del conductor',15,42,10);
        colocar('- ',15,42,11);
        verificar_todo_letras(x,44,11);
        busqueda_cond(arbol_apynom,pos,x);
      end
      else
      busqueda_cond(arbol_dni,pos,x);
    if pos >= 0 then
    begin
    leer_registros_conductores(arch_cond,pos,reg);
    a:=reg.dni;
    b:= reg.habilitado;
    alta_infracciones(arch_inf,x,infraccion);
    modificacion_scoring(arch_cond,pos,infraccion);
    end
    else if pos=0 then colocar('El conductor buscado no se encuentra en el Sistema, este caso será enviado a Legales',red,42,13);
   close(arch_cond);
   close(arch_inf);
    end;
end.
