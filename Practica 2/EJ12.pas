program ej12;
const
val_alto = 9999;
type
    acceso = record
        año, mes, dia, id_user: integer;
        tiempo: real;
    end;

    arc_maestro = file of acceso;

procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure leer_maestro(var arc_maestro: arc_maestro; var a: acceso);
begin
    if not EoF (arc_maestro) then 
        read(arc_maestro, a);
    else
        a.año:= val_alto;
end;

procedure imprimir_maestro(var arc_maestro: arc_maestro);
var
a: acceso;
año_act, mes_act, dia_act, id_act, año_ingresado: integer;
existe: boolean;
tot_tiempo: real;
begin
    existe:= True;
    writeln('Ingrese el año a buscar:');
    readln(año_ingresado);

    abrir_maestro(arc_maestro);
    leer_maestro(arc_maestro, a);
    
    while (a.año <> año_ingresado) and (existe = True) do begin
        if (a.año = val_alto) then
            existe:= false;
        else
            leer_maestro(arc_maestro, a);
    end;


    if (existe = True) then begin
        tot_tiempo_año:= 0;
        writeln('Año: ', a.año);
        while (a.año = año_ingresado) do begin
            tot_tiempo_mes:= 0;
            mes_act:= a.mes;
            writeln('Mes: ', a.mes);

            while (año_ingresado = a.año) and (mes_act = a.mes) do begin
                dia_act:= a.dia;
                writeln('Dia: : ', a.dia);

                while (año_act = a.año) and (mes_act = a.mes) and (dia_act = a.dia) do begin
                    id_act:= a.id_user;
                    tot_tiempo_exacto:= 0;

                    while (año_act = a.año) and (mes_act = a.mes) and (dia_act = a.dia) and (id_act = a.id_user) do begin
                        tot_tiempo_exacto:= tot_tiempo_exacto + a.tiempo;
                        leer_maestro(arc_maestro, a);
                    end;
                    tot_tiempo_mes:= tot_tiempo_mes + tot_tiempo_exacto;
                    writeln('idUsuario: ', id_act, 'Tiempo total: ', tot_tiempo_exacto, ' en el dia: ', dia_act, ' mes: ', mes_act);
                end;
            end;
            writeln('Tiempo total mes: ', tot_tiempo_mes,' mes: ', mes_act);
            tot_tiempo_año:= tot_tiempo_año + tot_tiempo_mes;
        end; 
        writeln('Tiempo total año: ', tot_tiempo_año,' año: ', año_ingresado);
    end;
end;
