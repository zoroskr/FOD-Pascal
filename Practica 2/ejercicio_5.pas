program siniestro;
const
val_alto:= 9999;
type
    nacimientos = record
        nro_partida, dni_madre, dni_padre: integer;
        nacimiento, nombre, apellido, direccion, matricula, nombre_madre, apellido_madre, nombre_padre, apellido_padre: string;
    end;

    fallecimientos = record
        nro_partida, dni: integer;
        nombre, apellido, matricula, fecha, lugar: string;
        hora: real;
    end;

    personas = record
        nacimiento: nacimientos;
        fallecio: fallecimientos;
    end;
    

    fall: file of fallecimientos;
    naci: file of nacimientos;
    maestro: file of personas;

    arc_fall: fall;
    arc_naci: naci;
    arc_maestro: maestro;

    vec_fall: array [1..50] of arc_fall;
    vec_naci: array [1..50] of arc_naci;


procedure leer_fall (var arc_fall: fall; var f: fallecimientos);
begin
    if not EoF(arc_fall) then
        read (arc_fall, f);
    else
        f.nro_partida:= val_alto;
end;

procedure leer_naci (var arc_naci: naci; var n: nacimientos);
begin
    if not EoF(arc_naci) then
        read (arc_naci, n);
    else
        n.nro_partida:= val_alto;
end;

procedure recibir_nacimientos (var vec_naci: arc_naci);
var
i: integer;
begin
    for i:= 1 to 50 do begin
        assign (vec_naci[i], 'archivo' + IntToStr(i));
        crear_maestro(vec_naci[i]);
    end;
end;

procedure recibir_fallecimientos (var vec_fall: arc_fall);
var
i: integer;
begin
    for i:= 1 to 50 do begin
        assign (vec_fall[i], 'archivo' + IntToStr(i));
    end;
end;

procedure armar_maestro_nacimiento(var p: personas; var n: nacimientos);
begin
    p.nacimiento:= n;
end;

procedure crear_maestro (var arc_maestro: maestro; var arc_naci: naci);
var
n: nacimientos;
p: personas;
begin
    reset (arc_maestro);
    reset (arc_naci);
    leer_naci(arc_naci, n);
    while (n.nro_partida <> val_alto) do begin
         armar_maestro(p, n);
         write(arc_maestro, p);
         leer_naci(arc_naci, n);
    end;
end;

