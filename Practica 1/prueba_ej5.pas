Program Generar_Archivo;
var 
  arc_logico: TextFile; {variable que define el nombre lógico del archivo}
  codigo, stock_min, stock_disp: integer;
  precio: real;
  nombre, descripcion, marca: string;
begin
  assign( arc_logico, 'celulares.txt');
  rewrite( arc_logico ); { se crea el archivo }
  codigo:= 12356;
  nombre:= 'Jorge';
  descripcion:= 'Cremades';
  marca:= 'Samsong';
  precio:= 3.21;
  stock_min:= 300;
  stock_disp:= 100;
  writeln( arc_logico, codigo, ' ' , precio, ' ', marca); { se escribe en el archivo cada número }
  writeln( arc_logico, stock_disp, ' ', stock_min, ' ', descripcion); 
  writeln( arc_logico, nombre); 
  close( arc_logico ); { se cierra el archivo abierto oportunamente con la instrucción rewrite }
end.