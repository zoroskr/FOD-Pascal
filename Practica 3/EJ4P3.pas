program EJ4P3;
type
flor = record
    nombre: String[45];
    codigo:integer;
end;

arc_flor = file of reg_flor;

procedure agregar_flor (var arc_flor: arc_flor; nombre: string; codigo: integer);
var
flor_del, cabe: flor;
begin
    assign(arc_flor, 'flores');
    reset(arc_flor);
    
    read(arc_flor, cabe);

    if (cabe.codigo < 0) then begin
        indice:= (cabe.codigo * (-1)) - 1;
        seek(arc_flor, filepos(arc_flor) + indice);
        read(arc_flor, flor_del);
        indice_atras:= (cabe.codigo * (-1)) + 1;
        seek(arc_flor, filepos(arc_flor) - indice_atras);
        write(arc_flor, flor_del);
        seek(arc_flor, filepos(arc_flor) + indice);
        flor_del.codigo:= codigo;
        flor_del.nombre:= nombre;
        write(arc_flor, flor_del); //esccribo un registo con los datos pasados por parametro
    end;
    close(arc_flor);
end;

procedure listar (var arc_flor: arc_flor);
var
f: flor;
begin
    assign(arc_flor, 'flores');
    reset(arc_flor);

    read(arc_flor, f);
    while not EoF(arc_flor) do begin
        if (f.codigo > 0) then begin
            write(f.codigo);
            write(f.nombre);
        end;
        read(arc_flor, f);

    end;
    close(arc_flor);
end;

procedure eliminar_flor (var arc_flor: arc_flor; f: flor);
var
cabe, act: flor;
begin
    assign(arc_flor, 'flores');
    reset(arc_flor);

    read(arc_flor, act);
    cabe:= act;
    pos_actual:= 0;
    while not EoF(arc_flor) and (f.cod <> act.cod) do begin
        pos_actual:= pos_actual + 1;
        read(arc_flor, act);
    end;

    if (act.cod = f.cod) then begin
        indice_atras:=  pos_actual - 1;
        seek(arc_flor, filepos(arc_flor) - 1);
        write(arc_flor, cabe);
        seek(arc_flor, filepos(arc_flor) - indice_atras);
        act.cod:= pos_actual;
        write(arc_flor, act);
    end;
end;