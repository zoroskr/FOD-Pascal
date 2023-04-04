'''El encargado de ventas de un negocio de productos de limpieza desea administrar el
stock de los productos que vende. Para ello, genera un archivo maestro donde figuran todos
los productos que comercializa. De cada producto se maneja la siguiente información:
código de producto, nombre comercial, precio de venta, stock actual y stock mínimo.
Diariamente se genera un archivo detalle donde se registran todas las ventas de productos
realizadas. De cada venta se registran: código de producto y cantidad de unidades vendidas'''

program ejercicio_7;
const
val_alto:= 9999;
type
productos = record
    stock_act, stock_min, cod_prod: integer;
    nombre: string;
    precio: real;
end;

venta = record
    cant_ven, cod_prod: integer;
end;

texto: file of TextFile;
maestro: file of productos;
detalle: file of venta;

arc_maestro: maestro;
arc_detalle: detalle;
arc_texto: texto;

var
arc_maestro: maestro;
arc_detalle: detalle;
v: venta;
p: producto;
arc_texto: texto;

procedure asignar_maestro (var arc_maestro: maestro);
begin
    assign(arc_maestro, 'maestro');
    reset(arc_maestro);
end;

procedure asignar_detalle (var arc_detalle: detalle);
begin
    assign(arc_detalle, 'detalle');
    reset(arc_detalle);
end;

procedure leer_detalle (var arc_detalle: detalle; var v: venta);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, v);
    else
        cod_prod := val_alto;
    
end;

procedure actualizar_maestro (var arc_maestro: maestro; var arc_detalle: detalle; var arc_texto: texto);
var
v: venta;
p: producto;
cant_total: integer;
cod_act: integer;
begin
    reset (arc_texto);
    leer_detalle (arc_detalle, v);
    while (v.cod_prod <> val_alto) do begin
        cod_act:= v.cod_prod;
        cant_total:= 0;
        while (v.cod_prod = cod_act) do begin
            cant_total:= cant_total + v.cant_ven;
            leer_detalle  (arc_detalle, v);
        end;
        read (arc_maestro, p);
        while (p.cod_prod <> v.cod_act) do begin
            read (arc_maestro, p);
        end;
        p.stock_act:= p.stock_act - v.cant_total;
        if (p.stock_act < p.stock_minimo) then begin
            writeln (arc_texto, p.cod_prod, p.nombre, p.precio p.stock_act, p.stock_min);
        end;
        seek(arc_maestro, filepos(arc_maestro) - 1);
        write(arc_maestro, v);
    end;
end;
