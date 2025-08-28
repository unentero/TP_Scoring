unit FLORITURAS;
{$codepage UTF8}

interface

uses
  crt,archivos_conductores,archivos_infracciones;

procedure pulse_para_continuar;
procedure volver_al_menu(var op:char);
procedure titulo (tit:string);
procedure colocar(palabra:string; color,x,y: byte);
Procedure colocar_res(palabra:string; color,x,y: byte);
procedure marco_horizontal(x,y,z:byte);
procedure marco_vertical(x,y,z:byte);
procedure inicio;
procedure interfaz_cond;
procedure interfaz_inf;
Procedure Resaltar(var x,y:longword);
implementation
procedure pulse_para_continuar;          // Presione una tecla.
    begin
        textcolor(11);
        GOTOXY(65,28);
        WRITE('Presione Enter para continuar...') ;
        readkey;
        textcolor(white);
    end;
procedure volver_al_menu(var op:char);
    begin
        textcolor(11);
        GOTOXY(65,40);
        WRITE('Escriba 0 para retroceder');
        GOTOXY(65,41);
        write('>');
        textcolor(white);
        repeat
        GOTOXY(67,41);
        readln(op);
        until (op='0');
    end;
procedure titulo (tit:string);         // Título.
    begin
        clrscr;
        textcolor(11);
        gotoxy (48,4);
        write (tit);
        textcolor(white);
    end;
procedure colocar(palabra:string; color,x,y: byte);   //Colocar frase donde se necesite
    begin                                                 //con color a eleccion
         gotoxy(x,y);
         textcolor(color);
         write (palabra);
         textcolor(white);
    end;
Procedure colocar_res(palabra:string; color,x,y: byte);
begin
         gotoxy(x,y);
         textbackground(color);
         write(palabra);
         textbackground(black);
end;

    procedure marco_vertical(x,y,z:byte);
    var
    a:byte;
    begin
    textcolor(15);
    for a:= 1 to z do
    begin
         gotoxy(x,y);write('║') ;
         y:=y+1;
        end;
    end;

    procedure marco_horizontal(x,y,z:byte);
    var
    a:byte;
    begin
    textcolor(15);
    for a:= 1 to z do
    begin
         gotoxy(x,y);write('=') ;
         x:=x+1;
        end;
    end;

    procedure inicio;                        //Muestra una pantalla de inicio
    begin
    marco_horizontal(27,6,64);
    marco_vertical(91,7,14);
    marco_horizontal(27,21,64);
    marco_vertical(26,7,14);
    colocar(' SISTEMA DE SCORING',4,47,10);
    colocar(' Trabajo Práctico Grupal de implementación y desarrollo ', 1,31,13);
    colocar(' Algoritmos y Estructura de Datos ',1,33,15);
    colocar (' Presione cualquier tecla para comenzar... ',15,35,18);
    readkey;
end;
    procedure interfaz_cond;
    begin
    textcolor(lightblue);
    gotoxy(9,9);
    write('|Apellido y Nombre        |DNI     |Puntos |Estado|');
    textcolor(lightblue);
    gotoxy(9,8);
    write('___________________________________________________');
    gotoxy(9,30);
    write('___________________________________________________');
    GOTOXY(9,32);
    WRITE('Navegue usando las flechas laterales y pulse Esc para salir.') ;
    textcolor(white);
    end;
    procedure interfaz_inf;
begin
    Colocar('+---------------┬--------------┬----------------------------------------------------------------+', lightblue, 10, 6);
    Colocar('| Fecha Infrac. | DNI          | Descripcion                                                    |', lightblue, 10, 7);
    Colocar('+---------------+--------------+----------------------------------------------------------------+', lightblue, 10, 8);
    Colocar('+---------------+--------------+----------------------------------------------------------------+', lightblue, 10, 30);
    Colocar('Navegue usando las flechas laterales y pulse Esc para salir.', lightblue, 10, 32);
end;
    procedure interfaz_inf_cond;
begin
    Colocar('+---------------┬--------------┬----------------------------------------------------------------+', lightblue, 10, 6);
    Colocar('| Fecha Infrac. | Puntos       | Descripcion                                                    |', lightblue, 10, 7);
    Colocar('+---------------+--------------+----------------------------------------------------------------+', lightblue, 10, 8);
    Colocar('+---------------+--------------+----------------------------------------------------------------+', lightblue, 10, 30);
    Colocar('Navegue usando las flechas laterales y pulse Esc para salir.', lightblue, 10, 32);
end;
Procedure Resaltar(var x,y:Longword);
begin
Textbackground(0);
gotoxy(x,y);
writeln('                                                                    ');
TextBackground(1);
gotoxy(x,y+1);
Textbackground(0);
end;

end.
