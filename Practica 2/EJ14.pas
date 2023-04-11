program ej14;
const
val_alto:= 'ZZZ';
type
    vuelo = record
        destino: string;
        fecha, hora, cant_disp: integer;
    end;

    det = record
        destino: string;
        fecha, hora, cant_comprados: integer;
    end;

    detalle: file of det;
    maestro: file of vuelo;

    arc_detalle_1: detalle;
    arc_detalle_2: detalle;
    arc_maestro: maestro;

procedure abrir_maestro(var arc_maestro: maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure abrir_detalle_1(var arc_detalle: detalle);
begin
    assign(arc_detalle, 'detalle_1');
    reset(arc_detalle);
end;

procedure abrir_detalle_2(var arc_detalle: detalle);
begin
    assign(arc_detalle, 'detalle_2');
    reset(arc_detalle);
end;

procedure leer_detalle(var arc_detalle: detalle; var d: det);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, d);
    else 
        det.destino:= val_alto;
end;

procedure minimo(var d1: det; var d2: det; var min: det);
begin
    if (d1.destino < d2.destino) then
        min:= d1;
        leer_detalle(arc_detalle_1, d1);
    else
        min:= d2;
        leer_detalle(arc_detalle_2, d2);
end;

procedure actualizar_maestro(var arc_maestro: maestro; var arc_detalle_1: detalle; var arc_detalle_2: detalle);
d1, d2, min: det;
v: vuelo;
dest_act: string;
dia_act, fecha_act, asient_min:integer;
begin
    writeln('Ingrese el minimo de asientos disponibles: ');
    readln(asient_min);

    abrir_detalle_1(arc_detalle_1);
    abrir_detalle_2(arc_detalle_2);
    abrir_maestro(arc_maestro);

    leer_detalle(arc_detalle_1, d1);
    leer_detalle(arc_detalle_2, d2);

    minimo(d1, d2, min);

    while (min.destino <> val_alto) do begin
        dest_act:= min.destino;
        while (dest_act = min.destino) do begin
            fecha_act:= min.fecha;
            while (dest_act = min.destino) and (fecha_act = min.fecha) do begin
                dia_act:= min.dia
                total_vendidos:= 0;
                while (dest_act = min.destino) and (fecha_act = min.fecha) and (dia_act = min.dia) do begin
                    total_vendidos:= total_vendidos + min.cant_comprados;
                    minimo(d1, d2, min);
                end;

                read(arc_maestro, v);
                while (v.destino <> dest_act) and (v.fecha <> v.fecha_act) and (v.dia <> dia_act) do begin
                    read(arc_maestro, v);
                end;
                v.cant_disp:= v.cant_disp - total_vendidos;
                if (v.cant_disp < asient_min) then begin
                    writeln(v.destino, v.fecha, v.hora);
                end;
                seek(arc_maestro, filepos(arc_maestro)-1);
                write(arc_maestro, v);
            end;
        end;
    end;
end;

var
arc_maestro: maestro;
arc_detalle_1: detalle;
arc_detalle_2: detalle;
BEGIN
    actualizar_maestro(arc_maestro, arc_detalle_1, arc_detalle_2);
end.
