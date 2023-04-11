program ej16;
const
val_alto = 'ZZZ'
type
    semanario = record
        fecha, nombre, descripcion: string;
        precio: real;
        codigo, cant_ejem, cant_ven: integer;
    end;

    det: record
        fecha: string;
        codigo, cant_ven: integer;
    end;


    arc_detalle = file of det;
    arc_maestro = file of semanario;

    vec_det = array [1..100] of arc_detalle;
    vec_rec = array [1..100] of det;

procedure leer_det (var arc_det: arc_detalle; var d: det);
begin
    if not EoF (arc_det) then
        read(arc_det, d);
    else
        d.fecha:= val_alto;
end;

procedure abrir_maestro (var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure minimo (var vec_det: vec_det; var vec_rec: vec_rec);
var
i, pos_min: integer;
min: det;
begin
    min.fecha:= 'ZZZ';
    for i:= 1 to 100 do begin
        if (vec_rec[i].fecha) < min.fecha then
            min:= vec_rec[i];
            pos_min:= i;
        end;
    end;
    if (min.fecha <> val_alto) then 
        leer_det (vec_det[pos_min], vec_rec[pos_min])
end;

procedure abrir_detalles (var vec_det: vec_det; var vec_rec: vec_rec; var min: det);
var
i: integer;
begin
    for i:= 1 to 100 do begin
        assign(vec_det[i], 'detalle' + InToStr(i));
        reset(vec_det[i]);
        leer_det(vec_det[i], vec_rec[i]);
    end;
end;

procedure actualizar_maestro (var arc_maestro: arc_maestro; var vec_det: vec_det; var vec_rec: vec_rec);
var
fecha_act: string;
cod_act, tot_ven, min_fecha, max_fecha: integer;
min: det;
s, max_s, min_s: semanario;
begin
    max.cant_ven:= -1;
    min.cant_ven:= 9999;
    min_fecha:= 9999;
    max_fecha:= -1;
    minimo(vec_det, vec_rec, min);
    while (min.fecha <> val_alto) do begin
        fecha_act:= min.fecha;
        tot_fecha:= 0;
        while (fecha_act = min.fecha) do begin
            cod_act:= min.codigo;
            tot_ven:= 0;
            while (fecha_act = min.fecha) and (cod_act = min.codigo) do begin
                tot_ven:= tot_ven + min.cant_ven;
                minimo(vec_det, vec_rec, min);
            end;
            tot_fecha:= tot_fecha + tot_ven;
        end;
        if (tot_fecha > max_fecha) then
            max_fecha:= tot_fecha;
        end;
        else
            if(tot_fecha < min_fecha) then
                min_fecha:= tot_fecha;
            end;
        end;
        read(arc_maestro, s);
        while (s.fecha <> fecha_act) and (s.codigo <> cod_act) do begin
            read(arc_maestro, s);
        end;
        s.cant_ven:= s.cant_ven + tot_ven;
        if (s.cant_ven > max.cant_ven) then
            max_s:= s;
        else
            if (s.cant_ven < min.cant_ven) then
                min_s:= s;
            end;
        end;
        seek(arc_maestro, filepos(arc_maestro)-1);
        write(arc_maestro, s);
    end;
    writeln(max_fecha);
    writeln(max_s.fecha, max_s.codigo);
    writeln(min_fecha);
    writeln(min_s.fecha, min_s.codigo);
end;

var
    arc_maestro: arc_maestro;
    vec_det: vec_det;
    vec_rec: vec_rec;
    min: det;
BEGIN
abrir_maestro(arc_maestro);
abrir_detalles(vec_det, vec_rec, min);
actualizar_maestro(arc_maestro, vec_det, vec_rec);
end.