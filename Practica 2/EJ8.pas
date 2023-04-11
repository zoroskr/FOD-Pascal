program ej8;
const
val_alto = 9999;
//_______________________________________________________________________________________________

type
    cliente = record
        cod_cliente, año, mes, dia: integer;
        nombre: string;
        monto: real;
    end;

    arc_maestro= file of cliente;
    vec_meses= array [1..12] of integer;
//_______________________________________________________________________________________________

procedure crear_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset (arc_maestro);
end;

procedure leer_maestro(var arc_maestro: arc_maestro, var c:cliente);
begin
    if not EoF(arc_maestro) then begin
        read(arc_maestro, c);
    else
        c.cod:= val_alto;
end;

procedure inicializar_vector (var vec_meses: vec_meses);
begin
    for i:= 1 to 12 do begin
        vec_meses[i]:= 0;
    end;
    
end;

procedure informar_clientes(var arc_maestro: arc_maestro; var vec_meses: vec_meses);
var
c: cliente;
begin
    leer_maestro(arc_maestro, c);
    while (c.cod <> val_alto) do begin
        inicializar_vector(vec_meses);
        nombre_cliente := c.nombre;
        tot_monto:= 0;
        while (c.cod_cliente = cod_act) and (c.año = año_act) and (c.cod <> val_alto) do begin
            tot_monto := tot_monto + c.monto;
            vec_meses[c.mes]:= vec_meses[c.mes] + 1;
            leer_maestro(arc_maestro, c);
        end;
        // imprimir
        print(nombre_cliente);
        print(tot_monto);
        for i:= 1 to 12 do begin
            println(vec_meses[i]);
        end;
    end;
end;

//_______________________________________________________________________________________________
var
arc_maestro: arc_maestro;
vec_meses: vec_meses;
BEGIN
    crear_maestro(arc_maestro);
    informar_clientes (arc_maestro, vec_meses);
end.