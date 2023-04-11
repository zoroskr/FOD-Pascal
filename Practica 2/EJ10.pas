program ej10;
const
val_alto= 9999;
//_______________________________________________________________________________________________
type
    empleado = record
        depto, division, num_emp, categoria, cant_extras: integer;
    end;

    arc_maestro = file of empleado;
    arc_texto = TextFile;

    vec_horas = array [1..15] of real;
//_______________________________________________________________________________________________
procedure leer_maestro(var arc_maestro: arc_maestro; var e: empleado);
begin
    if not EoF(arc_maestro) then
        read(arc_maestro, e);
    else
        e.depto:= val_alto;
end;

procedure cargar_arreglo(var arc_texto: arc_texto; var vec_horas: vec_horas);
var
cat: integer;
val: real;
begin
    assign(arc_texto, 'archivo.txt');
    rewrite(arc_texto,);
    for i:=1 to 15 do begin
        writeln('Ingrese num categoria', cat);
        writeln('Ingrse el valor de la hora', val);
        writeln(arc_texto, cat, val);
        vec_horas[cat]:= val;
    end;
end;

procedure recorrer_maestro(var arc_maestro: arc_maestro);
var
e: empleado;
begin
    leer_maestro(arc_maestro, e); // leemos un registro del maestro
    while (e.depto <>  val_alto) do begin // mientras no se termien el archivo
        depto_act:= e.depto; //nos quedamos con el depto actual
        tot_horas_dept:= 0;
        monto_total_dept:= 0;
        writeln('Departamento:', depto_act); // escribimos el depto
        while (depto_act = e.depto) do begin // mientras sea el mismo depto
            div_act:= e.division; // nos quedamos con la division actual
            writeln('Division', div_act); // imprimmimos la division
            while (depto_act = e.depto) and (div_act = e.division) do begin //mientras sea el mismo depto y division
                num_act:= e.num_emp; // nos quedamos con el empleado actual
                cat_actual:= e.cat; // nos quedamos con la categoria del empleado
                tot_horas_div:= 0;
                mont_total:= 0;
                writeln ('Empleado', num_act); // escribimos el empleado
                while (depto_act = e.depto) and (div_act = e.division) and (num_act:= e.num_emp) do begin //mientras estemos con el mismo depto, div y empl
                    tot_horas:= tot_horas + cant_extras; //sumamos la cantidad de horas del empleado
                    leer_maestro(arc_maestro, e);
                end;
                cant_cobrar:= ((vec_horas[cat_actual]) * tot_horas); 
                tot_horas_div:= tot_horas_div + tot_horas;
                mont_total:= mont_total + cant_cobrar;
                writeln('Total horas:', tot_horas);
                writeln('Importe: ', cant_cobrar);
            end;
            writeln('Total horas division:', tot_horas_div);
            writeln('Monto total por division:', mont_total);
            tot_horas_dept:= tot_horas_dept + tot_horas_div;
            monto_total_dept:= monto_total_dept + mont_total;
        end;
        writeln('Total horas departamento: ', tot_horas_dept);
        writeln('Monto total deepartamento: ', monto_total_dept);
    end;
    
end;
