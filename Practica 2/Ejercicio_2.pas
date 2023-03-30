 program ej2;
 type
    alumno = record
        codigo, cant_finales, cant_sin_finales: integer;
        apellido, nombre: string;
    end;

    alumno_detalle = record
        codigo: integer;
        final: boolean;
        cursada: boolean;
    end;
    
    maestro: file of alumno;
    detalle: file of alumno_detalle;

    arc_maestro: maestro;
    lst_maestro: maestro;
    arc_detalle: detalle;
    lst_detalle: detalle;
    lst_alumnos: maestro;

procedure crearArchivoMaestro (var arc_maestro: maestro);
begin
    assign (arc_maestro, 'alumnos.txt');
    rewrite (arc_maestro);
end;

procedure crearArchivoDetalle (var arc_detalle: detalle);
begin
    assign (arc_maestro, 'detalle.txt');
    rewrite (arc_maestro);
end;

procedure crearListaMaestro (var lst_maestro);
begin
    assign (lst_maestro, 'reporteAlumnos.txt');
    rewrite (lst_maestro);
end;

procedure crearListadetalle (var lst_detalle);
begin
    assign (lst_detalle, 'reporteDetalle.txt');
    rewrite (lst_detalle);
end;

procedure listarArchivoMaestro (var arc_maestro: maestro; var lst_maestro: maestro);
var
a: alumno;
begin
    while not EoF(arc_maestro) do begin
        read (arc_maestro, a);
        write (lst_maestro, a);
    end;
end;

procedure listarArchivoDetalle (var arc_detalle: detalle; var lst_detalle: detalle);
var
a: alumno_detalle;
begin
    while not EoF(arc_detalle) do begin
        read (arc_detalle, a);
        write (lst_detalle, a);
    end;
end;

procedure actualizarMaestro (var arc_detalle: detalle: var arc_maestro: maestro);
a_actual, a_primero: alumno_detalle;
a_maestro: alumno;
begin
    total_materias:= 0;
    total_cursadas:= 0;

    if not EoF (arc_detalle) do begin //preguntamos si el arc detalle esta vacio
        read (arc_detalle, a_primero); //leemos un registro del arc detalle
        if (a_primero.final = true) then begin // si tiene el final aprobado incrementamos en uno el total de materias
            total_materias:= total_materias + 1;
        end
        if (a_actual.cursada = true) then begin
            total_cursadas:= total_cursadas + 1;
        end;
        while not EoF(arc_detalle) do begin //mientras no se acabe el arc detalle
            read (arc_detalle, a_actual); //leemos otro registro
            if (a_primero.codigo = a_actual.codigo) then begin //si el primero leido y el segundo coinciden en codigo
                if (a_actual.final = true) then begin //si tiene el final aprobado
                    total_materias:= total_materias + 1; // incrementamos el total de materias del alumno
                end;
                if (a_actual.cursada = true) then begin
                    total_cursadas:= total_cursadas + 1;
                end;
            end
            else // si ya no estamos con el mmismo alumno
            begin
            while (a_primero.codigo <> a_maestro.codigo) do begin //buscamos en el arc maestro el codigo de alumno encontrado en el arc_detalle
                read(arc_maestro, a_maestro); //avanzamos en el archivo
            end;
            seek(arc_maestro, filepos(arc_maestro)-1) // una vez encontrado el alumno, que por pre condicion tiene que existir, nos situamos sobre la posicion del archivo
            a_maestro.cant_finales:= a_maestro.cant_finales + total_materias; // actualizamos el registro del primer alumno leido
            a_maestro.cant_sin_finales:= a_maestro.cant_finales + total_cursadas;
            write(arc_maestro, a_maestro); // actualizamos el maestro
            total_materias:= 0; //reiniciamos el contador
            total_cursadas:= 0;
            end;
        end;
    end;
end;

procedure crearListaAlumnos (var lst_alumnos: maestro)
begin
    assign(lst_alumnos, 'alumnos_maxs.txt');
    rewrite (lst_alumnos);
end;
procedure listarAlumnos (var arc_maestro: maestro);
var
a: alumno;
begin
    while not eof(arc_maestro) do begin
        read (arc_maestro, a);
        if (a.cant_sin_finales > 4) & (a.cant_finales = 0) then begin
            write (lst_alumnos, a);
        end;
    end;
end;


        





end;