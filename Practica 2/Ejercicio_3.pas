program ej3;
const val_alto = '99999';
type
    producto = record
        codigo, stock_act, stock_min: integer;
        descripcion, nombre: string;
        precio: real;
    end;

    pedido = record
        codigo, cant: integer;
    end;

    maestro = file of producto;
    detalle = file of pedido;

    arc_maestro= maestro;
    arc_detalle= detalle;
    arc_texto= TextFile;
    vec_arc = array [1..5] of arc_detalle;

procedure leerDetalle (var arc_detalle: detalle; var pedido: pedido);
begin
    if not EoF(arc_detalle) then begin
        read(arc_detalle, pedido);
    else begin
        pedido.codigo = val_alto;
    end;
end;

procedure recibirDetalles(var vec: vec_arc; var arc_maestro: maestro);
var
i: integer;
begin
    for i:= 1 to 5 do begin
        assign(vec[i], 'archivo' + IntToStr(i));
        actualizarMaestro(vec, arc_maestro, i);
    end;
end;

procedure actualizarMaestro(var vec: vec_arc; var arc_maestro: maestro; i: integer);
var
p: pedido;
prod: producto;
begin
    reset(arc_maestro); // abrimos el maestro, esto es importante porque situa el puntero al inicio cada vez que querramos actualizar
    reset(vec[i]); //abrimos el detalle del vector en la posicion i
    while (pedido.codigo <> val_alto) do begin //mientras no se llegue al fin del arc_detalle
        leerDetalle(vec[i], p); //leemos un detalle
        codigo_act:= p.codigo; // nos guardamos el codigo del detalle leido
        cant_total:= 0; // inicializamos la variable cant
        while (p.codigo = codigo_act) do begin // mientras sea el mismo codigo de producto, entra siempre al menos una vez
            cant_total:= cant_total + vec[i].cant; // actualizamos la variable cant con la cantidad de producto vendido del detalle
            leerDetalle(vec[i], p); // leemos otro detalle
        end;
        while (arc_maestro <> p.codigo) do begin // buscamos en el maestro hasta encontrar el codigo del detalle para actualizar
            read (arc_maestro, prod); //leemos
        end;
        prod.stock_act:= prod.stock_act - cant_total; // una vez que encontramos el prod en el maestro le restamos la cant vendida en el detalle
        seek (arc_maestro, file (pos)-1 ); // ubicamos el puntero del maestro
        write (arc_maestro, prod); //escribimos sobre el maestro
    end;
end;

procedure generarArcTexto (var arc_maestro: maestro; var arc_texto: TextFile);
var
prod: producto;
begin
    while not EoF(arc_maestro) do begin
        read (arc_maestro, prod)
        if (prod.stock_act < prod.stock_min) then begin
            writeln(arc_texto, prod.nombre, prod.descripcion, prod.stock_act, prod.precio)
        end;
    end;
end;

var
arc_maestro: maestro;
arc_texto: TextFile;
arc_detalle: detalle;
vec: vec_arc;
begin
    recibirDetalles(vec, arc_maestro)
end.
