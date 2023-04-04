program ej3;
uses SysUtils;
const
  val_alto = 99999;
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

var
  arc_maestro: maestro;
  arc_detalle: detalle;
  arc_texto: Text;
  vec_arc: array [1..5] of detalle;

procedure leerDetalle(var arc_detalle: detalle; var p: pedido);
begin
  if not EoF(arc_detalle) then
    read(arc_detalle, p)
  else
    p.codigo := val_alto;
end;

procedure actualizarMaestro(var vec: array of detalle; var arc_maestro: maestro; i: integer);
var
  p: pedido;
  prod: producto;
  codigo_act: integer;
  cant_total: integer;
begin
  Reset(arc_maestro); // abrimos el maestro, esto es importante porque situa el puntero al inicio cada vez que querramos actualizar
  Reset(vec[i]); //abrimos el detalle del vector en la posicion i
  leerDetalle(vec[i], p);
  while p.codigo <> val_alto do //mientras no se llegue al fin del arc_detalle
  begin
    codigo_act := p.codigo; // nos guardamos el codigo del detalle leido
    cant_total := 0; // inicializamos la variable cant
    while (p.codigo = codigo_act) and (p.codigo <> val_alto) do // mientras sea el mismo codigo de producto, entra siempre al menos una vez
    begin
      cant_total := cant_total + p.cant; // actualizamos la variable cant con la cantidad de producto vendido del detalle
      leerDetalle(vec[i], p); // leemos otro detalle
    end;
    while (prod.codigo <> codigo_act) do begin // buscamos en el maestro hasta encontrar el codigo del detalle para actualizar
      read(arc_maestro, prod); //leemos
    end;
      prod.stock_act := prod.stock_act - cant_total; // una vez que encontramos el prod en el maestro le restamos la cant vendida en el detalle
      seek(arc_maestro, filepos(arc_maestro) - 1); // ubicamos el puntero del maestro
      write(arc_maestro, prod); //escribimos sobre el maestro
  end;
  Close(vec[i]);
end;

procedure recibirDetalles(var vec: array of detalle; var arc_maestro: maestro);
var
  i: integer;
  nombre: string;
begin
  for i := 1 to 5 do
  begin
    nombre:= 'archivo' + IntToStr(i);
    Assign(vec[i], nombre);
    actualizarMaestro(vec, arc_maestro, i);
  end;
end;

procedure generarArcTexto(var arc_maestro: maestro; var arc_texto: Text);
var
  prod: producto;
begin
  Rewrite(arc_texto);
  Reset(arc_maestro);
  while not EoF(arc_maestro) do
  begin
    read(arc_maestro, prod);
    if prod.stock_act < prod.stock_min then
      writeln(arc_texto, prod.nombre, ' ', prod.descripcion, ' ', prod.stock_act, ' ', prod.precio);
  end;
  Close(arc_texto);
end;

begin
    Assign(arc_maestro, 'maestro.dat'); // asignamos el archivo maestro
    Assign(arc_texto, 'productos.txt'); // asignamos el archivo de texto
    recibirDetalles(vec_arc, arc_maestro); // actualizamos el stock del maestro con los detalles de venta
    generarArcTexto(arc_maestro, arc_texto); // generamos el archivo de texto con los productos con stock por debajo del minimo
    Close(arc_maestro); //cerramos el archivo maestro
end.