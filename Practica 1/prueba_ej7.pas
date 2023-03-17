Program Generar_Archivo;
type
    novelas = record
        codigo: integer;
        nombre: string;
        genero: string;
        precio: real;
    end;

    archivo = file of novelas;
var 
  arc_logico: archivo; {variable que define el nombre lógico del archivo}
  c: novelas; {nro será utilizada para obtener la información de teclado}
begin
  assign( arc_logico, 'novelas.txt');
  rewrite( arc_logico ); { se crea el archivo }
  c.codigo:= 12356;
  c.nombre:= 'Jorge';
  c.genero:= 'Cremades';
  c.precio:= 3.10;
  write( arc_logico, c); { se escribe en el archivo cada número }
  close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end.