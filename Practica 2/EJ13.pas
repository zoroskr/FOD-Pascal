program ej13;
const
val_alto= 9999;
type
    log = record
        nro_usuario, cant_mails: integer;
        nombre_usuario, nombre, apellido: string;
    end;

    det = record
        nro_usuario, cuenta_dest: integer;
        cuerpo_mensaje: string;
    end;

    arc_detalle = file of det;
    arc_maestro = file of log;
    arc_texto = TextFile;

procedure crear_texto(var arc_texto: arc_texto);
begin
    assign(arc_texto, 'text.txt');
    rewrite(arc_texto);
end;
procedure abrir_maestro(var arc_maestro: arc_maestro);
begin
    assign(arc_maestro, '/var/log/logmail.dat');
    reset(arc_maestro);
end;

procedure abrir_detalle (var arc_detalle, arc_detalle);
begin
    assign(arc_detalle, 'detalle');
    reset(arc_detalle);
end;

procedure leer_det(var arc_detalle: arc_detalle; var d: det);
begin
    if not EoF(arc_detalle) then
        read(arc_detalle, d);
    else
        d.nro_usuario:= val_alto;
end;

procedure actualizar_maestro(var arc_maestr: arc_maestro; var arc_detalle: arc_detalle; var arc_texto: arc_texto);
var
d: detalle;
user_act, tot_mensajes:=: integer;
log: log;
begin
    abrir_maestro(arc_maestro);
    abrir_detalle(arc_detalle);
    leer_det(arc_detalle, d);
    while (d.nro_usuario <> val_alto) do begin
        user_act:= d.nro_usuario;
        tot_mensajes:= 0;
        while (user_act = d.nro_usuario) do begin
            tot_mensajes:= tot_mensajes + 1;
            leer_det(arc_detalle, d);
        end;
        writeln(arc_texto, 'nro_usuario: ', user_act, 'cantidad mensajes enviados: ', tot_mensajes);
        read(arc_maestro, log);
        while (log.nro_usuario <> user_act) do begin
            read(arc_maestro, log);
        end;
        log.cant_mails:= log.cant_mails + tot_mensajes;
        seek(arc_maestro, filePos(arc_maestro)-1);
        write(arc_maestro, log);
    end;

    close(arc_maestro);
    close(arc_texto);
    close(arc_detalle);
end;

var
arc_detalle: arc_detalle;
arc_maestro: arc_maestro;
arc_texto: arc_texto;
BEGIN
    actualizar_maestro(arc_maestro, arc_detalle);
end.