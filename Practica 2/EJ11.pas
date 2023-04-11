program ej11;
const
val_alto = 'ZZZZ';
type
    provincia = record
        nombre: string;
        cant_alfa, cant_encue: integer;
    end;

    censo = record
        nombre: string;
        cod_loc, cant_alfa, cant_encue: integer;
    end;

    detalle = file of censo;

    arc_maestro = file of provincia;
    arc_detalle_1 = detalle;
    arc_detalle_2 = detalle;

procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure abrir_detalle_1 (var arc_detalle: detalle);
begin
    assign(arc_detalle, 'arc_detalle_1');
    reset(arc_detalle);
end;

procedure abrir_detalle_2 (var arc_detalle: detalle);
begin
    assign(arc_detalle, 'arc_detalle_2');
    reset(arc_detalle);
end;

procedure leer_detalle(var arc_detalle: detalle; var c: censo);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, c);
    else
        c.nombre:= val_alto;
end;

procedure minimo(var c1: censo; var c2: censo; var min: censo; var arc_detalle_1: detalle; var arc_detalle_2: detalle);
begin
    if (c1.nombre < c2.nombre) then
        min:= c1;
        leer_detalle(arc_detalle_1, c1);
    else
        min:= c2;
        leer_detalle(arc_detalle_2, c2);
end;

procedure actualizar_maestro(var arc_maestro: arc_maestro; var arc_detalle_1: detalle; var arc_detalle_2: detalle);
var
c1, c2, min, regm: censo;
tot_encue, tot_alfa: integer;
begin
    abrir_maestro(arc_maestro);
    abrir_detalle_1(arc_detalle_1);
    abrir_detalle_2(arc_detalle_2);

    leer_detalle(arc_detalle_1, c1);
    leer_detalle(arc_detalle_2, c2);
    minimo(c1, c2, min, arc_detalle_1, arc_detalle_2);
    
    while (min.nombre <> val_alto) do begin
        regm.nombre:= min.nombre;
        regm.cant_alfa:= 0;
        regm.cant_encue:= 0;
        while(regm.nombre = min.nombre) do begin
            regm.cant_alfa:= regm.cant_alfa + min.cant_alfa;
            regm.cant_encue:= regm.cant_encue + min.cant_encue;
            minimo(c1, c2, min);
        end;
        write(arc_maestro, regm);
end;

var
arc_maestro: arc_maestro;
arc_detalle_1: detalle;
arc_detalle_2: detalle;
BEGIN
    actualizar_maestro(arc_maestro, arc_detalle_1, arc_detalle_2);
end.