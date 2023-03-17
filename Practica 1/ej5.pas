program tienda_celulares;
type
    celulares= record
        codigo: integer;
        nombre: string;
        descripcion: string;
        marca: string;
        precio: real;
        stock_min: integer;
        stock_disp: integer;
    end;
    archivo = file of celulares;

procedure abrirArchivo(var arc_fisico: string; var arc_logico: archivo);
begin
    writeln ('Ingrese el nombre del archivo a procesar:');
    read (arc_fisico);
    assign (arc_logico, arc_fisico);
    reset(arc_logico);
end;

procedure presentarInfo (var opcion: integer);
begin
     writeln('Ingrese una opcion:');
     writeln('1. Crear un archivo');
     writeln('2 Listar Menores');
     writeln('3 Listar String');
     writeln('4 Exportar Archivo');
     writeln('5 Añadir celulares ');
     writeln('6 Modificar stock ');
     writeln('7 Exportar archivo de celulares sin stock ');
     readln(opcion);
end;
procedure cambiarStock(var arc_logico: archivo);
var
    c: celulares;
    arc_fisico: string;
    nombre: string;
    stock_nuevo: integer;
    encontre: boolean;
begin
    encontre:= false;
    writeln ('Ingrese el nombre del celular:');
    readln (nombre);
    abrirArchivo(arc_fisico, arc_logico);
    while not Eof(arc_logico) and (encontre = false) do begin
        read(arc_logico, c);
        if (c.nombre = nombre) then begin
            writeln('El celular fue encontrado su stock es de ', c.stock_disp, ', ingrese el cambio de stock:');
            readln(stock_nuevo);
            c.stock_disp:= stock_nuevo;
            seek(arc_logico, filepos(arc_logico)-1);
            write(arc_logico, c);
            encontre:= true;
        end;
    end;
    close(arc_logico);
end;

procedure anadirCelular(var arc_logico: archivo);
var
    c: celulares;
    arc_fisico: string;
begin
    abrirArchivo(arc_fisico, arc_logico);
    while not Eof(arc_logico) do begin
        read(arc_logico, c);
    end;
     writeln('Ingrese codigo');
     readln(c.codigo);
     writeln('Ingrese nombre');
     readln (c.nombre);
     writeln('Ingrese descripcion');
     readln(c.descripcion);
     writeln('Ingrese marca');
     readln(c.marca);
     writeln('Ingrese precio');
     readln (c.precio);
     writeln('Ingrese stock min');
     readln (c.stock_min);
     writeln('Ingrese stock disponible');
     readln (c.stock_disp);
     write( arc_logico, c);
     close(arc_logico);
end;


procedure cargarArchivo(var arc_logico: archivo; var arc_carga: archivo);
var
    c: celulares;
begin
    assign (arc_carga, 'celulares.txt');
    reset(arc_carga);
    if EOf(arc_carga) then
    begin
        write('El archivo esta vacio');
    end
    else
    while not Eof(arc_carga) do begin
        read(arc_carga, c);
        write(arc_logico, c);
    end;
    close(arc_carga);
    close(arc_logico);
end;

procedure crearArchivo(var arc_logico: archivo; var arc_carga: archivo; var arc_fisico: string);
begin
    writeln ('Ingrese el nombre del archivo:');
    readln (arc_fisico);
    assign (arc_logico, arc_fisico);
    rewrite (arc_logico);
    cargarArchivo(arc_logico, arc_carga)
end;

procedure listarMenor(var arc_logico: archivo);
var
    c: celulares;
    arc_fisico: string;
begin
    abrirArchivo(arc_fisico, arc_logico);
    while not Eof(arc_logico) do begin
        read(arc_logico, c);
        if (c.stock_disp < c.stock_min) then begin
            writeln(c.codigo, c.precio, c.marca, c.stock_disp, c.stock_min, c.descripcion, c.nombre);
        end;
    end;
    close(arc_logico);
end;


procedure listarString(var arc_logico: archivo);
var
    descripcion: string;
    c: celulares;
    arc_fisico: string;
begin
    writeln('Ingrese una descripcion:');
    readln(descripcion);
    abrirArchivo(arc_fisico, arc_logico);
    while not Eof(arc_logico) do begin
        read(arc_logico, c);
        if (c.descripcion = descripcion) then begin
            writeln(c.codigo, c.precio, c.marca, c.stock_disp, c.stock_min, c.descripcion, c.nombre);
        end;
    end;
    close(arc_logico); 
end;

procedure exportarArchivo (var arc_logico: archivo; var arc_logico3: archivo);
var
c: celulares;
arc_fisico: string;
begin
    abrirArchivo(arc_fisico, arc_logico);
    assign (arc_logico3, 'celulares.txt');
    reset (arc_logico3);
    while not Eof(arc_logico) do begin
         read (arc_logico, c);
         write (arc_logico3, c);
    end;
    close(arc_logico);
    close(arc_logico3);
end;

procedure exportarSinStock (var arc_logico: archivo; var arc_logico4: archivo);
var
c: celulares;
arc_fisico: string;
begin
    abrirArchivo(arc_fisico, arc_logico);
    assign (arc_logico4, 'SinStock.txt');
    rewrite (arc_logico4);
    while not Eof(arc_logico) do begin
         read (arc_logico, c);
         if (c.stock_disp = 0) then begin
            write (arc_logico4, c);
         end;
    end;
    close(arc_logico);
    close(arc_logico4);
end;



procedure menuInfo (var arc_logico: archivo; var arc_carga: archivo; var arc_logico3: archivo; var arc_fisico: string; var arc_logico4: archivo);
var
o: integer;
begin
     presentarInfo(o);
     case o of
        1: crearArchivo(arc_logico, arc_carga, arc_fisico);
        2: listarMenor(arc_logico);
        3: listarString(arc_logico);
        4: exportarArchivo(arc_logico, arc_logico3);
        5: anadirCelular(arc_logico);
        6: cambiarStock(arc_logico);
        7: exportarSinStock(arc_logico, arc_logico4);
     end;
end;
var
arc_logico: archivo;
arc_logico3: archivo;
arc_carga: archivo;
arc_fisico: string;
arc_logico4: archivo;
begin
    menuInfo(arc_logico, arc_carga, arc_logico3, arc_fisico, arc_logico4);
end.