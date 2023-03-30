type
  Empleado = record
    codigo: integer;
    nombre: string;
    comision: real;
  end;

var
  archivo_comisiones, archivo_compactado: file of Empleado;
  empleado_actual, empleado_anterior: Empleado;
  total_comision: real;

procedure compactarArchivo();
begin
  reset(archivo_comisiones);
  rewrite(archivo_compactado);
  
  if not eof(archivo_comisiones) then // preguntamos si el archivo de comisiones no esta vacio
  begin
    read(archivo_comisiones, empleado_anterior); // leemos un empleado y lo guardamos
    total_comision := empleado_anterior.comision; //guardamos el total de comision del empleado leido
    
    while not eof(archivo_comisiones) do // mientras no se termine el archcivo de comisiones
    begin
      read(archivo_comisiones, empleado_actual); // leemos otro empleado y lo guardamos
      
      if empleado_actual.codigo = empleado_anterior.codigo then // preguntamos si se trata del mismo empleado
      begin
        total_comision := total_comision + empleado_actual.comision; // incrementamos el total de ese empleado en ese caso
      end
      else // en caso de que se trate de otro empleado 
      begin
        empleado_anterior.comision := total_comision; // le asignamos al primer empleado leido el total de su comision
        write(archivo_compactado, empleado_anterior); // escribimos en el archivo compactado
        
        empleado_anterior := empleado_actual; // sobreescribimos el record de empleado_anterior por el empleado_actual
        total_comision := empleado_anterior.comision; //guardamos el total de comision del empleado leido
      end;
    end;
    
    empleado_actual.comision := total_comision;
    write(archivo_compactado, empleado_actual);
  end;
  
  close(archivo_comisiones);
  close(archivo_compactado);
end;

begin
  assign(archivo_comisiones, 'comisiones.dat');
  assign(archivo_compactado, 'comisiones_compactado.dat');
  compactarArchivo();
end.
