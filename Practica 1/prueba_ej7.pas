program crearArchivo;
var
  archivo: TextFile;
  codigo, precio: integer;
  genero, nombre: string;

begin
  assign(archivo, 'novelas.txt');
  rewrite(archivo);

  // escribir la información de la novela en dos líneas
  codigo := 1;
  precio := 100;
  genero := 'Romance';
  nombre := 'El amor en los tiempos del cólera';
  writeln(archivo, codigo, ' ', precio, ' ', genero);
  writeln(archivo, nombre);

  codigo := 2;
  precio := 150;
  genero := 'Ficción';
  nombre := 'Rayuela';
  writeln(archivo, codigo, ' ', precio, ' ', genero);
  writeln(archivo, nombre);

  // ... agregar más novelas

  close(archivo);
end.
