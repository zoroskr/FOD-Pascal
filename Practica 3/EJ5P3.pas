program EJ5P3;
const
val_alto:= 9999;
type
prenda = record
    cod, stock: integer;
    precio: real;
    colores, descripcion, tipo: string;
end;

arc_maestro = file of prenda;
arc_detalle = file of integer;

procedure leer_arc (var a: arc_detalle; var cod: integer);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, cod);
    else
        cod:= val_alto;
end;

procedure abrir_maestro (var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure arbrir_detalle (var arc_detalle: arc_detalle);
begin
    assign(arc_detalle, 'detalle');
    reset(arc_detalle);
end;

procedure actualizar_maestro (var arc_maestro: arc_maestro; var arc_detalle: arc_detalle);
var
cod: integer;
begin
    abrir_maestro(arc_maestro);
    arbrir_detalle(arc_detalle);

    leer_arc(arc_detalle, cod);
    while (cod <> val_alto) do begin
        leer_arc(arc_detalle, cod);
        read(arc_maestro, p);
        while (cod <> val_alto) and (cod <> p.cod) do begin
            read(arc_maestro, p);
        end;
        if (cod = p.cod) then begin
            seek(arc_maestro, filepos(arc_maestro)-1);
            p.cod:= p.cod * (-1);
            write(arc_maestro, p);
        end;
    end;
    close(arc_maestro);
    close(arc_detalle);
end;

procedure compactar_maestro (var arc_maestro: arc_maestro; var aux: arc_maestro);
var
p: prenda;
begin
    abrir_maestro(arc_maestro);
    assign(aux, 'aux');
    rewrite(aux);
    while not EoF(arc_maestro) do begin
        read(arc_maestro, p);
        if (p.cod > 0) then begin
            write(aux, p);
        end;
    end;
end;