program EJ2P4;
const
val_alto:= 9999;
type
novela = record
    cod, duracion: integer;
    precio: real;
    genero, nombre, director: string;
end;

arc_novelas = file of novela;

procedure crear_arc(var arc_novelas: arc_novelas);
var
nombre: string;
begin
    read(nombre);
    assign(arc_novelas, nombre);
    rewrite(arc_novelas);
end;

procedure leer_novela (var n: novela);
begin
    writeln('Ingrese el numero de novela (-1 para finalizar)');
    readln(n.cod);
    if (n.cod <> -1) then
    begin
        writeln('Ingrese la duracion');
        readln(n.duracion);
        writeln('Ingrese el nombre');
        readln(n.nombre);
        writeln('Ingrese el director');
        readln(n.director);
        writeln('Ingrese el precio');
        readln(n.precio);
        writeln('Ingrese el genero');
        readln(n.genero);
    end;
end;

procedure cargar_cabe(var arc_novelas: arc_novelas);
var
n: novela;
begin
    n.cod:= 0;
    write(arc_novelas, n);
end;

procedure cargar_arc (var arc_novelas: arc_novelas);
var
n: novela;
begin
    crear_arc(arc_novelas);
    cargar_cabe(arc_novelas);
    leer_novela(n);
    while (n.cod <> -1) do begin
        write(arc_novelas, n);
        leer_novela(n);
    end;
    close(arc_novelas);
end;

procedure leer_arc (var arc_novelas: arc_novelas; var n: novela);
begin
    if not EoF(arc_novelas) then
        read(arc_novelas, n)
    else
        n.cod:= val_alto;
end;

procedure modificar_novela (var arc_novelas: arc_novelas);
var
n, n_nov: novela;
cod_nov: integer;
begin
    reset(arc_novelas);
    write('Ingrese codigo de novela a modificar:');
    read(cod_nov);
    leer_arc(arc_novelas, n);
    while (n.cod <> val_alto) and (n.cod <> cod_nov) do begin
        leer_arc(arc_novelas, n);
    end;
    if (n.cod = cod_nov) then begin
        leer_novela(n_nov);
        n_nov.cod:= n.cod;
        seek(arc_novelas, filepos(arc_asistentes)-1);
        write(arc_novelas, n_nov);
    end;
    close(arc_novelas);
end;

procedure eliminar_novela (var arc_novelas: arc_novelas);
var
cod_nov, n, cabecera: novela;
indice: integer;
begin
    reset(arc_novelas);
    write('Ingrese codigo de novela a eliminar:');
    read(cod_nov);
    leer_arc(arc_novelas, n);
    pos_actual:= 0;
    while (n.cod <> val_alto) and (n.cod <> cod_nov) do begin
        leer_arc(arc_novelas, n);
        pos_actual:= pos_actual + 1;
    end;
    if (n.cod = cod_nov) then begin
        seek(arc_novelas, filepos(arc_novelas) - pos_actual - 1);
        read(arc_novelas, cabecera); // leemos la cabecera
        n.cod := cabecera.cod;
        indice:= 0 - pos_actual;
        cabecera.cod := indice;
        write(arc_novelas, cabecera);
        seek(arc_novelas, filepos(arc_novelas) + pos_actual - 1);
        write(arc_novelas, n);
    end;
    close(arc_novelas);
end;

procedure agregar_novela (var arc_novelas: arc_novelas);
var
n, cabecera, nue_cabecera nue_n: novela;
indice: integer;
begin
    reset(arc_novelas); //abrimos el archivo de novelas
    leer_novela(nue_n); // leemos una nueva novela

    leer_arc(arc_novelas, cabecera); // leemos la ccabecera
    if (cabecera.cod < 0) then begin //nos fijamos si la cabecera tiene guardado una posicion vacia del archivo
        indice:= -(cabecera.cod) - 1; // si tiene una posicion la convertimos a positiva y le restamos uno ya que anteriormente habiamos avanzado
        seek(arc_novelas, filepos(arc_novelas) + indice); //nos posicionamos en la posicion
        read(arc_novelas, nue_cabecera); // leemos lo que tenia el registro eliminado
        seek(arc_novelas, filepos(arc_novelas) - indice - 1); // nos posicionamos de nuevo en la cabecera
        write(arc_novelas, nue_cabecera); // escribimmos el registro eliminado
        seek(arc_novelas, filepos(arc_novelas) + indice - 1); // nos posicionamos donde estaba el registro eliminado, que ahroa es cabecera
        write(arc_novelas, nue_n); //escribimos la novela
    end;
    else begin // si no hay posicion eliminada en el archivo
        while not EoF(arc_novelas) do begin // leemos hasta llegar al fin del archivo
            read(arc_novelas, n);
        end;
        write(arc_novelas, nue_n); //escribimos la nueva novela
    end;
    close(arc_novelas);
end;

