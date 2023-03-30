program ejercicio_7;
type
    novelas = record
        codigo: integer;
        nombre: string;
        genero: string;
        precio: real;
    end;

    archivo = file of novelas;
    archivo_txt = TextFile;

procedure crearNovela (var n: novelas);
begin
    writeln ('Ingrese codigo de novela:');
    readln(n.codigo);
    writeln ('Ingrese nombre de novela:');
    readln(n.nombre);
    writeln ('Ingrese genero de novela:');
    readln(n.genero);
    writeln ('Ingrese precio de novela:');
    readln(n.precio);
end;

procedure cargarArchivo (var arc_logico: archivo; var arc_carga: archivo_txt);
var
n: novelas;
begin
    assign(arc_carga, 'novelas.txt');
    reset(arc_carga);
    if Eof(arc_carga) then begin
        write('El archivo no tiene contenido');
    end
    else begin
        while not Eof(arc_carga) do begin
            readln(arc_carga, n.codigo, n.precio, n.genero);
            readln(arc_carga, n.nombre);
            write(arc_logico, n);
        end;
    end;
    close(arc_logico);
    close(arc_carga);
end;

procedure crearArchivo(var arc_logico: archivo; var arc_carga: archivo_txt);
var
    arc_fisico: string;
begin
    writeln ('Ingrese el nombre del archivo a crear:');
    readln (arc_fisico);
    assign (arc_logico, arc_fisico);
    rewrite (arc_logico);
    cargarArchivo(arc_logico, arc_carga)
end;

procedure modificarNovela(var arc_logico: archivo);
var
codigo: integer;
encontre: boolean;
n: novelas;
codigoIng: integer;
nombreIng: string;
generoIng: string;
precioIng: real;
opcion: integer;
begin
    encontre:= false;
    writeln('Ingrese el codigo de novela a buscar:');
    readln(codigo);
    while not Eof(arc_logico) and (encontre <> true) do begin
        read(arc_logico, n);
        if (n.codigo = codigo) then begin
            writeln('¿Que desea modificar?');
            readln(opcion);
            writeln('Ingrese nuevo parametro:');
            case opcion of
                1: begin
                     readln(codigoIng);
                     n.codigo:= codigoIng;
                  end;

                2: begin
                   readln(nombreIng);
                   n.nombre:= nombreIng;
                   end;

                3: begin
                   readln(generoIng);
                   n.genero:= generoIng;
                   end;

                4: begin
                   readln(precioIng);
                   n.precio:= precioIng;
                  end;
            end;
            seek(arc_logico, filepos(arc_logico)-1);
            write(arc_logico, n);
            encontre:= true;
        end;
    end;
    close(arc_logico);
end;

procedure agregarNovela (var arc_logico: archivo);
var
n: novelas;
begin
    while not Eof(arc_logico) do begin
        read(arc_logico, n);
    end;
    crearNovela(n);
    write(arc_logico, n);
    close(arc_logico);
end;

procedure imprimirArchivo (var arc_logico: archivo);
var
arc_fisico: string;
n: novelas;
begin 
    writeln ('Ingrese el nombre del archivo a imprimir:'); //debemos preguntar siempre por el nombre a la hora de modificar?
    readln (arc_fisico);
    assign (arc_logico, arc_fisico);
    reset (arc_logico);
    if Eof(arc_logico) then begin
        writeln('El archivo esta vacio');
    end;
    while not Eof(arc_logico) do begin
        read(arc_logico, n);
        writeln(n.codigo, n.nombre, n.genero, n.precio);
    end;
    close(arc_logico);
end;

procedure abrirArchivo(var arc_logico: archivo);
var
arc_fisico: string;
opcion: integer;
begin
    writeln ('Ingrese el nombre del archivo a modificar:'); //debemos preguntar siempre por el nombre a la hora de modificar?
    readln (arc_fisico);
    assign (arc_logico, arc_fisico);
    reset (arc_logico);
    writeln('Ingrese 1 para agregar una novela o 2 para modificar una existente:');
    readln(opcion);
    case opcion of
        1: agregarNovela(arc_logico);
        2: modificarNovela(arc_logico);
    end;
end;


var
arc_logico: archivo;
arc_carga: archivo_txt;
opcion: integer;
begin
writeln('Ingrese 1 para crear el archivo, o 2 para para abrir el archivo ya creado o 3 para imprimir el archivo:');
readln(opcion);
case opcion of
    1: crearArchivo(arc_logico, arc_carga); 
    2: abrirArchivo(arc_logico);
    3: imprimirArchivo(arc_logico);
end;
end.