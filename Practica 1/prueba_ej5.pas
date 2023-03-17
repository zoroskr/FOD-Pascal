Program Generar_Archivo;
type 
    celulares= record
        codigo: integer;
        nombre: string;
        descripcion: string;
        marca: string;
        precio: real;
        stock_min: integer;
        stock_disp: integer;
    end;
    archivo = file of celulares;
var 
  arc_logico: archivo; {variable que define el nombre lógico del archivo}
  c: celulares; {nro será utilizada para obtener la información de teclado}
begin
  assign( arc_logico, 'celulares.txt');
  rewrite( arc_logico ); { se crea el archivo }
  c.codigo:= 12356;
  c.nombre:= 'Jorge';
  c.descripcion:= 'Cremades';
  c.marca:= 'Samsong';
  c.precio:= 3.21;
  c.stock_min:= 300;
  c.stock_disp:= 100;
  write( arc_logico, c); { se escribe en el archivo cada número }
  close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end.