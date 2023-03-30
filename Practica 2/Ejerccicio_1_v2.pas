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
    
    while not eof(archivo_comisiones) do
    begin
      read(archivo_comisiones, empleado_actual);
      empleado_anterior:= empleado_actual;
      while not eof(archivo_comisiones) & (empleado_actual.codigo = empleado_anterior.codigo) do
      begin
        total_comision := total_comision + empleado_actual.comision; 
        read(archivo_comisiones, empleado_actual);
      end;
      empleado_anterior.comision:= total_comision;
      write (archivo_compactado, empleado_anterior);
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