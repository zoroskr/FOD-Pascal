program ej15;
const
val_alto = 9999;
type
    ong = record
        cod_pcia, cod_loc, viv_sin_luz, viv_sin_gas, viv_de_chapa, viv_sin_agua, viv_sin_sani: integer;
        prov, nom_loc: string;
    end;
    
    det = record
        cod_pcia, cod_loc, viv_sin_luz, viv_const, viv_con_agua, viv_con_gas, entrega_sani: integer;
    end;

    arc_maestro: file of ong;
    arc_detalle: file of det;

    vec_det: array [1..10] of arc_detalle;
    vec_rec: array[1..10] of det;

procedure leer_detalle(var arc_detalle: arc_detalle; var d: det);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, d);
    else
        d.cod_prov:= val_alto;    
end;

procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure abrir_detalles(var vec: vec_det; var vec_rec: vec_rec);
begin
    for i:= 1 to 10 do begin
        assign(vec[i], 'detalle' + InToStr(i))
        reset(vec[i]);
        leer_detalle(vec[i], vec_rec[i]);
    end;
end;

procedure minimo(var vec_rec: vec_rec; var vec_det: vec_det);
var
i, pos_min: integer;
begin
    min.cod_prov:= 999999;
    for i:= 1 to 10 do begin
        if (vec_rec[i].cod_prov < min.cod_prov) then
            min:= vec_rec[i];
            pos_min:= i;
        end;
    end;
    if (vec_rec[pos_min].cod_prov <> val_alto) then
        leer_detalle(vec_det[pos_min], vec_rec[pos_min])
end;