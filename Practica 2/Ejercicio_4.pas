program topo;
uses SysUtils;
const
    val_alto = 9999
type
    log = record
        cod_usuario, fecha: integer;
        tiempo: real;
    end;

    detalle = file of log;
    maestro = file of log;

    arc_detalle = detalle;
    arc_maestro = maestro;

    vec_detalle = array[1..5] of arc_detalle;

var
    arc_maestro: maestro;
    arc_detalle: detalle;
    l: log;
end;

procedure leerDetalle(var arc_detalle: detalle; var l: log);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, l);
    else
        l.cod_usuario:= val_alto;
end;

procedure cargarDetalles(var vec_detalle: array of arc_detalle; var arc_maestro: maestro);
begin
    for i:= 1 to 5 do begin
        assign(vec_detalle[i], 'archivo' + IntToStr(i))
        recorrerMaestro(arc_maestro, vec_detalle[i]);
    end;
end;

procedure crearMaestro(var arc_maestro: maestro);
begin
    assign(arc_maestro, 'arc_maestro_ej4');
    rewrite (arc_maestro);
end;

procedure recorrerMaestro (var arc_maestro: maestro; var arc_detalle: detalle);
var
l: log;
l_maestro: log;
begin
    reset(arc_maestro);
    reset(arc_detalle);
    leerDetalle(arc_detalle, l);
    while (l.cod_usuario <> val_alto) do begin
        cod_act:= l.cod_usuario;
        while (l.cod_usuario = cod_act) do begin
             tiempo_total:= 0;
             fecha_act:= l.fecha;
             cod_act:= l.cod_usuario;
             while (l.fecha = fecha_act) and (l.cod_usuario = cod_act) do begin
                tiempo_total:= tiempo_total + l.tiempo;
                leerDetalle(arc_detalle, l);
             end;
             // recorremos el maestro
             read (arc_maestro, l_maestro);
             while codigo_act <> l_maestro.codigo do begin
                read (arc_maestro, l_maestro);
             end;
             l_maestro.tiempo:= tiempo_total;
             seek(arc_maestro, filepos(arc_maestro) - 1);
             write(arc_maestro, l_maestro);
        end;
end;