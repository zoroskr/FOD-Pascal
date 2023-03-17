Program Generar_Archivo;
type 
  empleado = record
    numero_empleado: integer;
    apellido: string;
    nombre: string;
    edad: integer;
    dni: integer;
 end;
  archivo = file of empleado; {definición del tipo de dato para el archivo }
procedure presentarInfo(var opcion: integer);
begin
   writeln('Ingrese una opcion:');
   writeln('1. Crear un archivo de registros no ordenados');
   writeln('Abrir archivo previamente generado:');
   writeln('21. Busqueda nombre');
   writeln('22. Listar Empleados');
   writeln('23. Empleados Mayores');
   readln(opcion);
end;
procedure leerEmpleado(var e: empleado);
begin
    write( 'Ingrese el numero_empleado:' );
    readln (e.numero_empleado);
    write( 'Ingrese el apellido:' );
    readln (e.apellido);
    write( 'Ingrese el nombre:' );
    readln (e.nombre);
    write( 'Ingrese la edad:' );
    readln (e.edad);
    write( 'Ingrese el dni:' );
    readln (e.dni);
end;
Procedure busquedaNombre(var arc_logico: archivo; nombre: string);
var
e: empleado;
begin
    while not EOf(arc_logico) do 
    begin
        read(arc_logico, e); {se obtiene elemento desde archivo }
        if (nombre = e.nombre) or (nombre = e.apellido) then 
        begin
            writeln(e.nombre);
            writeln(e.apellido);
            writeln(e.dni);
            writeln(e.edad);
            writeln(e.numero_empleado);
        end;
    end;
end;  
Procedure listarEmpleados(var arc_logico: archivo);
var
e: empleado;
begin
    while not EOf(arc_logico) do 
    begin
        read(arc_logico, e); {se obtiene elemento desde archivo }
         writeln(e.nombre);
         writeln(e.apellido);
         writeln(e.dni);
         writeln(e.edad);
         writeln(e.numero_empleado);
     end;
end;
Procedure mayoresEdad(var arc_logico: archivo);
var
e: empleado;
begin
    while not EOf(arc_logico) do 
    begin
        read(arc_logico, e); {se obtiene elemento desde archivo }
        if (e.edad > 70) then 
        begin
            writeln(e.nombre);
            writeln(e.apellido);
            writeln(e.dni);
            writeln(e.edad);
            writeln(e.numero_empleado);
        end;
    end;
end;

var 
  arc_logico: archivo; {variable que define el nombre lógico del archivo}
  arc_fisico: string[12]; {utilizada para obtener el nombre físico del archivo desde teclado}
  opcion: integer;
  e: empleado;
  nombre: string[12];
begin
  opcion:= 0;
  presentarInfo(opcion);
  if (opcion = 1) then
  begin
     write( 'Ingrese el nombre del archivo:' );
     readln( arc_fisico ); { se obtiene el nombre del archivo}
     assign( arc_logico, arc_fisico );
     rewrite( arc_logico ); { se crea el archivo }
     leerEmpleado(e);
     while (e.apellido <> 'fin') do
     begin
         write(arc_logico, e);
         leerEmpleado(e);
     end;
  end
  else begin
     write( 'Ingrese el nombre del archivo a procesar:' );
     read( arc_fisico ); { se obtiene el nombre del archivo}
     assign( arc_logico, arc_fisico );
     reset(arc_logico); {archivo ya creado, para operar debe abrirse como de lect/escr}
     if EOf(arc_logico) then 
     begin
       writeln('El archivo está vacío');
     end
     else if (opcion = 21) then
     begin
      readln (nombre);
      write('Ingrese el nombre o apellido del empleado:');
      readln (nombre);
      busquedaNombre(arc_logico, nombre);
     end
     else if (opcion = 22) then
     begin
        listarEmpleados(arc_logico);
     end
     else if (opcion = 23) then
     begin
       mayoresEdad(arc_logico);
     end
   end;
 close(arc_logico);
end.