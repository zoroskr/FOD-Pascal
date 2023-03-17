Program Generar_Archivo2;
type 
  archivo = file of integer; {definición del tipo de dato para el archivo }
var 
  arc_logico: archivo; {variable que define el nombre lógico del archivo}
  nro: integer; {nro será utilizada para obtener la información de teclado}
  arc_fisico: string[12]; {utilizada para obtener el nombre físico del archivo desde teclado}

Procedure Recorrido(var arc_logico: archivo);
var 
  nro: integer; { para leer elemento del archivo}
  cant_menores: integer;
  cant_numeros: integer;
  total_numeros: integer;
  promedio: real;
begin
  cant_menores:= 0; 
  cant_numeros:= 0;
  total_numeros:= 0;
  reset(arc_logico); {archivo ya creado, para operar debe abrirse como de lect/escr}
  if EOf(arc_logico) then 
  begin
    writeln('El archivo está vacío');
  end
  else
  begin
    while not EOf(arc_logico) do 
    begin
        read(arc_logico, nro); {se obtiene elemento desde archivo }
        total_numeros:= total_numeros + nro;
        cant_numeros:= cant_numeros + 1;
        if(nro < 1500) then 
        begin
            cant_menores:= cant_menores + 1;
        end;
     end;
  end;
  promedio:= (total_numeros/cant_numeros);
  writeln(cant_menores);
  writeln(promedio);
  close(arc_logico);
  end;

begin
  write( 'Ingrese el nombre del archivo a procesar:' );
  read( arc_fisico ); { se obtiene el nombre del archivo}
  assign( arc_logico, arc_fisico );
  recorrido(arc_logico);
  close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end.