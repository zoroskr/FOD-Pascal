program E6P2;
const
val_alto = 9999;

type
info_muni = record
    cod_local, cod_cepa, cant_act, cant_nue, cant_recu, cant_fall: integer;
end;

info_mini = record
    cod_local, cod_cepa, cant_acti, cant_nue, cant_recu, cant_fall: integer;
    nombre_local, nombre_cepa: string;
end;

arc_detalle = file of info_muni;
arc_maestro = file of info_mini;

vec_det = array [1..10] of arc_detalle;
vec_rec = array [1..10] of info_muni;

//_______________________________________________________________________________________________

procedure leer_det(var arc_detalle: arc_detalle; var muni: info_muni);
begin
    if not EoF(arc_detalle) then
        read (arc_detalle, muni);
    else
        muni.cod_local:= val_alto;
end;

procedure cargar_vec (var vec: vec_det; var vec_rec: vec_rec);
var
i: integer;
begin
    for i:= 1 to 10 do begin
        assign(vec[i], 'archivo' + InToStr(i));
        reset(vec[i]);
        leer_det(vec[i], vec_rec[i]);
    end;
end;
procedure minimo (var vec_rec: vec_rec; var min: info_muni; var pos_min: integer);
begin
    min.cod_local:= val_alto;
    for i:= 1 to 10 do begin
        if (vec_rec[i].cod_local < min.cod_local) then begin
            min:= vec_rec[i];
            pos_min:= i;
        end;
    end;
    if min.cod_local <> val_alto then begin
        leer_det(vec_det[posmin], vec_rec[posMin])
end;

procedure armar_maestro (params);
begin
    cargar_vec (vec, vec_rec);
    minimo(var_rec, min);
    actualizar_maestro(vec_det[pos_min], arc_maestro);
end;

procedure actualizar_maestro(var arc_detalle: arc_detalle; var arc_maestro: arc_maestro; var min: info_muni);
var
muni: info_muni;
mini: info_mini;
cod_local_act, cod_cepa_act, tot_fall, tot_recu, tot_nue, tot_act: integer;
begin
    muni:= min;
    while (muni.cod_local <> val_alto) do begin
        cod_local_act:= muni.cod_local;
        cod_cepa_act := muni.cod_cepa;
        tot_fall:= 0;
        tot_recu:= 0;
        tot_nue:= 0;
        tot_act:= 0;
        while (cod_local_act = muni.cod_local) and (cod_cepa_act = muni.cod_cepa) do begin
            cod_local_act:= muni.cod_local;
            cod_cepa_act := muni.cod_cepa;
            tot_fall:= tot_fall + muni.cant_fall;
            tot_recu:= tot_recu + muni.cant_recu;
            tot_act:= tot_act + muni.cant_acti;
            tot_nue:= tot_nue + muni.cant_nue;
            leer_det(arc_detalle, muni);
        end;
        read (arc_maestro, mini);
        mini.cant_fall:= mini.cant_fall + tot_fall;
        mini.cant_recu:= mini.cant_recu + tot_recu;
        mini.cant_act:= tot_act;
        mini.cant_nue:= mini.tot_nue;
        seek(arc_maestro, file(pos-1));
        write(arc_maestro, mini);
        minimo(var_rec, min);
    end;
end;