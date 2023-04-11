program EJ9;
const
val_alto= 9999;
type
    mesa = record
        cod_prov, cod_loc, num_mesa, cant_votos: integer;
    end:

    arc_maestro = file of mesa;

procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure leer_maestro (var arc_maestro: arc_maestro; var m: mesa);
begin
    if not EoF(arc_maestro) then
        read(arc_maestro, m);
    else
        m.cod_prov;= val_alto;
end;

procedure recorrer_maestro(var arc_maestro: arc_maestro);
var
m: mesa;
cod_act_prov, cod_act_loc, tot_prov, tot_general, tot_loc: integer;
begin
    tot_geneal:= 0;
    leer_maestro(arc_maestro, m);
    while (m.cod_prov <> val_alto) do begin
        writeln('Cod prov:', m.cod_prov);
        cod_act_prov:= m.cod_prov;
        tot_prov:= 0;
        while (cod_act_prov = m.cod_prov) do begin
            writeln('Cod loc:', m.cod_loc);
            cod_act_loc:= m.cod_loc;
            tot_prov:= tot_prov + tot_loc;
            tot_loc:= 0;
            while (cod_act_loc = m.cod_loc) and (cod_act_prov = m.cod_prov) do begin
                tot_loc:= tot_loc + m.cant_votos;
                leer_maestro(arc_maestro, m);
            end;
            writeln ('Tot votos localidad', tot_loc);
        end;
        writeln ('Tot votos provincia:', tot_prov);
        tot_general:= tot_general + tot_prov;
    end;
    writeln('Tot votos general', tot_general);
end;

var
arc_maestro: arc_maestro;
m: mesa;
BEGIN
    abrir_maestro(arc_maestro, m);
    recorrer_maestro(arc_maestro);
end.