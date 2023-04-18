program E6P3;
const
val_alto:= 9999;
type
    especies = record
        cod: integer
        nombre, familia, descripcion, zona: string;
    end;

    arc_aves = file of especies;

    procedure leer_arc (var arc_aves: arc_aves; var e: especies);
    begin
        if not EoF(arc_aves) then begin
            read(arc_aves, e);
        else
            e.cod:= val_alto;
    end;

    procedure abrir_arc (var arc_aves: arc_aves);
    begin
        assign(arc_aves, 'aves');
        reset(arc_aves);
    end;

    procedure eliminar_especies (var arc_aves: arc_aves);
    var
    e: especies;
    begin
        abrir_arc(arc_aves);
        if not EoF(arc_aves) then begin
            read(arc_aves, e);
            while (cod_ing <> 50000) do begin
                write('Ingrese codigo de especie a eliminar');
                read(cod_ing);
                while (e.cod <> cod_ing) do begin
                    read(arc_aves, e);
                end;
                e.cod:= e.cod * (-1);
                seek(arc_aves, filepos(arc_aves) - 1);
                write(arc_aves, e);
                reset(arc_aves);
            end;
        end;
        close(arc_aves);
    end;

    procedure compactar_arc (var arc_aves: arc_aves);
    var
    e: especies;
    begin
        reset(arc_aves);
        while not EoF(arc_aves) do begin
            cantidadRegistros := FileSize(archivo) div SizeOf(Registro); //obtenemos la cantidad de posiciones actual del archivo
            seek(arc_aves, cantidadRegistros - 1); // nos paramos en el ultimo registro
            read(arc_aves, e);
            if (e.cod > 0) then begin //si no es un archivo marcado
                seek(arc_aves, cantidadRegistros - 1); //nos paramos en el ultimo record nuevamente
                Truncate(arc_aves); //eliminamos el ultimo registro
            end;
            else begin
                seek(arc_aves, 0); // nos paramos al inicio del archivo
                read(arc_aves, e);
                while not EoF (arc_aves) and (e.cod > 0) do begin
                    read(arc_aves, e);
                end;
                if (e.cod < 0) then begin
                    write(arc_aves, e);
                    seek(arc_aves, cantidadRegistros - 1)
                    e.cod:= e.cod * (-1);
                    write(arc_aves, e);
                end;
            end;

        end;

        
    end;