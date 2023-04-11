program ej17;
const
val_alto = 9999;
type
    moto = record
        codigo, stock: integer;
        nombre, descripcion, modelo, marca: string;
    end;

    det = record
        codigo: integer;
        precio: real;
        fecha: string;
    end;

    arc_maestro = file of moto;
    arc_det = file of det;

    vec_det = array[1..10] of arc_det;
    vec_rec = array[1..10] of det;

procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro;
end;

procedure leer_det (var arc_det: arc_det; var d: det);
begin
    if not EoF (arc_det) then
        read (arc_det, d)
    else
        d.codigo:= val_alto
end;


procedure llenar_vec (var vec_det: vec_det; var vec_rec: vec_rec);
begin
    for i:= 1 to 10 do begin
        assign(vec_det[i], 'detalle' + InToStr(i));
        reset (vec_det[i]);
        leer_det(vec_det[i], vec_rec[i]);
    end;
end;

procedure minimo (var vec_rec: vec_rec; var vec_det: vec_det; var min: det);
begin
    min.codigo:= val_alto;
    for i:= 1 to 10 do begin
        if vec_rec[i].codigo < min.codigo then
            min:= vec_rec[i];
            pos_min:= i;
        end;
    end;
    if (min.codigo <> val_alto) then
        leer_det(vec_det[pos_min], vec_rec[pos_min])
end;

procedure actualizar_maestro (var arc_maestro: arc_maestro; var vec_det: vec_det; var vec_rec: vec_rec);
var
min: det;
v: moto;
cod_act, tot_ven, max, cod_max: integer;
begin
    max:= -1;
    abrir_maestro(arc_maestro);
    llenar_vec(vec_det, vec_rec);
    minimo(vec_rec, vec_det, min);

    while (min.codigo <> val_alto) do begin
        cod_act:= min.codigo;
        tot_ven:= 0;
        while (min.codigo = cod_act) do begin
            tot_ven:= tot_ven + 1;
            minimo(vec_rec, vec_det, min);
        end;
        
        if (tot_ven > max) then begin
            max:= tot_ven;
            cod_max:= cod_act;
        end;

        read (arc_maestro, v);
        while (v.codigo <> cod_act) do begin
            read(arc_maestro, v);
        end;
        v.stock:= v.stock - tot_ven;
        seek(arc_maestro, filepos(arc_maestro)-1);
        write(arc_maestro, v);

    end;
    writeln(cod_act);
end;

var
arc_maestro: arc_maestro;
vec_det: vec_det;
vec_rec: vec_rec;
BEGIN
    actualizar_maestro(arc_maestro, vec_det, vec_rec);
end.
