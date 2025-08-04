//Unidad Base de ARBOL
unit ARBOLES;
INTERFACE
USES CRT;
type
//Definicion de la estructura
   DATO_ARBOL = record
     clave:string[70];
     pos:cardinal;
   end;
   PUNTERO = ^NODO;
   NODO = RECORD
     INFO:DATO_ARBOL;
     SAI,SAD: PUNTERO;
     end;
PROCEDURE CREAR_ARBOL (VAR RAIZ:puntero);
PROCEDURE AGREGAR_ARBOL(VAR RAIZ:puntero; X:DATO_ARBOL);
FUNCTION ARBOL_VACIO (RAIZ:puntero): BOOLEAN;
FUNCTION ARBOL_LLENO (RAIZ:puntero): BOOLEAN;
procedure suprime (var raiz:puntero;x:DATO_ARBOL);
PROCEDURE INORDEN(VAR RAIZ:puntero);
FUNCTION PREORDEN(RAIZ:puntero;BUSCADO:string):puntero;

implementation
PROCEDURE CREAR_ARBOL (VAR RAIZ:puntero);
BEGIN
RAIZ:= NIL;
END;
PROCEDURE AGREGAR_ARBOL(VAR RAIZ:puntero; X:dato_arbol);
BEGIN
IF RAIZ = NIL THEN
BEGIN
NEW (RAIZ);
RAIZ^.info.clave:= X.clave;
RAIZ^.INFO.pos:=X.pos;
RAIZ^.SAI:= NIL;
RAIZ^.SAD:= NIL;
END
ELSE IF RAIZ^.INFO.clave > X.clave THEN AGREGAR_ARBOL(RAIZ^.SAI,X)
ELSE AGREGAR_aRBOL(RAIZ^.SAD,X)
END;
FUNCTION ARBOL_VACIO (RAIZ:puntero): BOOLEAN;
BEGIN
ARBOL_VACIO:= RAIZ = NIL;
END;
FUNCTION ARBOL_LLENO (RAIZ:puntero): BOOLEAN;
BEGIN
ARBOL_LLENO:= GETHEAPSTATUS.TOTALFREE < SIZEOF (NODO);
END;
function suprime_min (var raiz:puntero):dato_arbol;
begin
if RAIZ^.SAI = nil then
 begin
 suprime_min:= raiz^.info;
 raiz:=raiz^.sad
 end
 else
 suprime_min:= suprime_min (raiz^.sai)
end;
 procedure suprime (var raiz:puntero; x:dato_arbol);
 begin
 if raiz <> nil then
 if x.clave < raiz^.info.clave then
 suprime (raiz^.sai,x)
 else
 if x.clave > raiz^.info.clave then
 suprime (raiz^.sad,x)
 else
 if (raiz^.sai = nil) and (raiz^.sad = nil) then
 raiz:= nil
 else
 if (raiz^.sai = nil) then
 raiz:= raiz^.sad
 else
 if (raiz^.sad = nil) then
 raiz:= raiz^.sai
 else
 raiz^.info:= suprime_min (raiz^.sad)
 end;
 FUNCTION PREORDEN(RAIZ:puntero;BUSCADO:string):puntero;
 BEGIN
 IF (RAIZ = NIL) THEN PREORDEN := NIL
 ELSE
 IF ( RAIZ^.INFO.clave = BUSCADO) THEN
 PREORDEN:= RAIZ
 ELSE IF RAIZ^.INFO.clave > BUSCADO THEN
 PREORDEN := PREORDEN(RAIZ^.SAI,BUSCADO)
 ELSE
 PREORDEN := PREORDEN(RAIZ^.SAD,BUSCADO)
 END;
  PROCEDURE INORDEN(VAR RAIZ:puntero);
  BEGIN
  IF RAIZ <> NIL THEN BEGIN
  INORDEN (RAIZ^.SAI);
  WRITELN (RAIZ^.INFO.clave);
  INORDEN (RAIZ^.SAD);
  end;
  END;


END.
