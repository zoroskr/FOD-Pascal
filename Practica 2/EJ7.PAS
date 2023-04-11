program EJ7;
const
    val_alto = 9999;
//_______________________________________________________________________________________________
type
    productos = record
        cod_produ, stock, stock_min: integer;
        precio: real;
        nombre: string;
    end;

    venta = record
        cod_produ, cant: integer;
    end;

    arc_maestro = file of productos;
    arc_venta = file of venta;
    arc_texto = TextFile;
//_______________________________________________________________________________________________

procedure crear_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure crear_detalle(var arc_detalle: arc_detalle);
begin
    assign(arc_detalle, 'detalle');
    reset(arc_detalle);
end;

procedure crear_texto(var arc_texto: arc_texto);
begin
    assign(arc_texto, 'stock_minimo.txt');
    reset(arc_texto);
end;

procedure leer_det(var arc_detalle: arc_detalle; var v: venta);
begin
    if not EoF(arc_detalle) then begin
        read(arc_detalle, v);
    else
        v.cod_produ:= val_alto;
end;

procedure actualizar_maestro(var arc_detalle: arc_detalle; var arc_maestro: arc_maestro; var arc_texto: arc_texto);
var
v: venta;
cod_act: integer;
cant_total: integer;
p: productos;
begin
    leer_det(arc_detalle, v);
    while (v.cod_produ <> val_alto) do begin
        cod_act:= v.cod_produ;
        cant_total:= 0;
        while(v.cod_produ = cod_act) do begin
            cant_total:= cant_total + v.cant;
            leer_det(arc_detalle, v);
        end;
        read(arc_maestro, v);
        while not EoF(arc_maestro) and (p.cod_produ <> cod_act) do begin
            read(arc_maestro, v);
        end;
        seek (arc_maestro, file(pos-1));
        p.stock:= p.stock - cant_total;
        if (p.stock < p.stock_min) then begin
            writeln(arc_texto, p.cod_act, p.stock, p.stock_min, p.precio, p.nombre);
        end;
        write (arc_maestro, p);
    end;
    close(arc_maestro);
    clos(arc_detalle);
end;

//_______________________________________________________________________________________________
var
arc_maestro: arc_maestro;
arc_detalle: arc_detalle;
arc_texto: arc_texto;
BEGIN
    crear_maestro(arc_maestro);
    crear_detalle(arc_detalle);
    actualizar_maestro(arc_detalle, arc_maestro, arc_texto);
end.