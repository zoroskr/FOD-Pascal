program ej3;
type
    producto = record
        codigo, stock_act, stock_min: integer;
        descripcion: string;
        precio: real;
    end;

    pedido = record
        codigo, cant: integer;
    end;

    maestro: file of producto;
    detalle: file of pedido;

    arc_maestro: maestro;
    arc_detalle_1: detalle;
    arc_detalle_2: detalle;
    arc_detalle_3: detalle;
    arc_detalle_4: detalle;

procedure actualizarMaestro (var arc_maestro: maestro; var arc_detalle_1: detalle; var arc_detalle_2: detalle; var arc_detalle_3: detalle; var arc_detalle_4: detalle);
var
p_primero: pedido;
producto: producto;
begin
    while not EoF (arc_maestro) do begin
        read (arc_maestro, producto);

    if not EoF(arc_detalle_1) then begin
        read (arc_detalle_1, p_primero_1);
    end;
    if not EoF(arc_detalle_2) then begin
        read (arc_detalle_2, p_primero_2);
    end;
    if not EoF(arc_detalle_3) then begin
        read (arc_detalle_3, p_primero_3);
    end;
    if not EoF(arc_detalle_4) then begin
        read (arc_detalle_4, p_primero_4);
    end;
    while not EoF (arc_maestro) do begin
        rea
    end;

end;