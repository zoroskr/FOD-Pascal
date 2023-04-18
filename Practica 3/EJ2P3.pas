program EJ2P3;
const
val_alto = 9999;
type
asistente = record;
    nro, telefono, dni: integer;
    apellido, nombre, email: string;
end;

arc_asistentes = file of asistente;

procedure abrir_archivo (var arc_asistentes: arc_asistentes);
begin
    assign(arc_asistentes, 'asistentes');
    rewrite(arc_asistentes); 
end;

procedure leer_asistente (var a: asistente);
begin
    writeln('Ingrese el numero del asistente (-1 para finalizar)');
    readln(a.nro);
    if (a.nro <> -1) then
    begin
        writeln('Ingrese el apellido');
        readln(a.apellido);
        writeln('Ingrese el nombre');
        readln(a.nombre);
        writeln('Ingrese el email');
        readln(a.email);
        writeln('Ingrese el telefono (solo numeros)');
        readln(a.telefono);
        writeln('Ingrese el DNI');
        readln(a.dni);
    end;
end;

procedure cargar_arc (var arc_asistentes: arc_asistentes; var a: asistente);
begin
    abrir_archivo;
    leer_asistente(a);
    while (a.nro <> -1 ) do begin
        write(arc_asistentes, a);
        leer_asistente(a);
    end;
    close(arc_asistentes);
end;

procedure leer_arc (var arc_asistentes: arc_asistentes; var a: asistente);
begin
    if not EoF(arc_asistentes) then
        read(arc_asistentes, a)
    else
        a.nro:= val_alto;
end;

procedure eliminar (var arc_asistentes: arc_asistentes);
var
a: asistente;
begin
    reset(arc_asistentes);
    leer_arc(arc_asistentes, a);
    while (a.nro <> val_alto) do begin
        if (a.nro < 1000) then begin
            Insert('*', a.nombre, 1);
            seek(arc_asistentes, filepos(arc_asistentes)-1);
            write(arc_asistentes, a);
        end;
        leer_arc(arc_asistentes, a);
    end;
    close(arc_asistentes);
end;

var
a: asistente;
arc_asistentes: arc_asistentes;
begin
    cargar_arc(arc_asistentes, a);
    eliminar(arc_asistentes, a);
end.