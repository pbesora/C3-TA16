USE `actividades`;

#Ejercicio 1. 

select NOMBRE from articulos;

select NOMBRE, PRECIO from articulos;

select NOMBRE from articulos where PRECIO <= 200;

select * from articulos where PRECIO between 60 and 120;

select NOMBRE, PRECIO*166.386 AS PRECIO from articulos;

select AVG(PRECIO) AS MEDIA_PRECIO from articulos;

select AVG(PRECIO) AS MEDIA_PRECIO from articulos where FABRICANTE = 2;

select count(CODIGO) AS NUM_ARTICULOS from articulos where PRECIO >= 180;

select NOMBRE, PRECIO from articulos where PRECIO >= 180 order by PRECIO desc, nombre asc;

select a.NOMBRE AS ARTICULO, a.CODIGO AS COD_ARTICULO, a.PRECIO, f.CODIGO AS COD_FABRICANTE, f.NOMBRE AS FABRICANTE from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO;

select a.NOMBRE AS NOM_ARTICULO, a.PRECIO, f.NOMBRE AS NOM_FABRICANTE from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO;

select f.CODIGO AS COD_FABRICANTE, AVG(a.PRECIO) AS MEDIA_PRECIO from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO group by f.CODIGO;

select f.NOMBRE AS NOM_FABRICANTE, AVG(a.PRECIO) AS MEDIA_PRECIO from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO group by f.CODIGO;

select DISTINCT f.NOMBRE AS NOM_FABRICANTE from articulos AS a, fabricantes AS f where a.FABRICANTE = f.CODIGO AND (SELECT avg(a.PRECIO) >= 150 group by f.NOMBRE);

select NOMBRE, PRECIO FROM articulos where PRECIO = (select min(PRECIO) from articulos);

select a.NOMBRE, a.PRECIO, f.NOMBRE from articulos AS a, fabricantes as f where a.FABRICANTE = f.CODIGO AND a.PRECIO = (SELECT max(a2.PRECIO) from articulos AS a2 where a2.FABRICANTE = f.CODIGO);

insert into articulos (CODIGO, NOMBRE, PRECIO, FABRICANTE) values (11, 'Altavoces', 70, 2);

update articulos set NOMBRE = 'Impresora Láser' where CODIGO = 8;

update articulos set PRECIO = PRECIO*0.9;

update articulos set PRECIO = PRECIO-10 where PRECIO >= 120;

#Ejercicio 2.

select APELLIDOS from empleados;

select DISTINCT APELLIDOS from empleados;

select * from empleados where APELLIDOS = 'Smith';

select * from empleados where APELLIDOS = 'Smith' OR APELLIDOS = 'Rogers';

select * from empleados where DEPARTAMENTO = 14;

select * from empleados where DEPARTAMENTO = 37 OR DEPARTAMENTO = 77;

select * from empleados where APELLIDOS like 'P%';

select SUM(PRESUPUESTO) AS Presupuesto_Total from departamentos;

select count(DNI) AS Num_Empleados from empleados group by DEPARTAMENTO;

select e.DNI, e.NOMBRE, e.APELLIDOS, d.CODIGO AS Cod_Departamento, d.NOMBRE AS Nom_Departamento, d.PRESUPUESTO from empleados AS e, departamentos AS d;

select e.NOMBRE, e.APELLIDOS, d.NOMBRE AS Nom_Departamento, d.PRESUPUESTO from empleados AS e, departamentos AS d;

select e.NOMBRE, e.APELLIDOS from empleados AS e, departamentos AS d where e.DEPARTAMENTO = d.CODIGO AND d.PRESUPUESTO > 60000;

select * from departamentos where PRESUPUESTO > (select avg(PRESUPUESTO) from departamentos);

select d.NOMBRE from departamentos AS d, empleados AS e where (select count(CODIGO) from empleados where DEPARTAMENTO = d.CODIGO) > 2 group by d.NOMBRE;

insert into departamentos (NOMBRE, PRESUPUESTO, CODIGO) values ('Calidad',40000,11);
insert into empleados values ('89267109','Ester','Vazquez',11);

update departamentos set PRESUPUESTO = PRESUPUESTO * 0.9;

update empleados set DEPARTAMENTO = 14 where DEPARTAMENTO = 77;

delete from empleados where DEPARTAMENTO = 14;

delete from empleados where DEPARTAMENTO = (select CODIGO from departamentos where PRESUPUESTO > 60000);

delete from empleados;

#Ejercicio 3.

select * from almacenes;

select * from cajas where valor > 150;

select distinct contenido from cajas;

select avg(valor) as  Valor_Medio from cajas group by contenido;

select avg(valor) as  Valor_Medio from cajas group by almacen;

select almacen from cajas group by almacen having avg(valor)  > 150 ;

select c.NUMREFERENCIA, a.LUGAR from cajas as c, almacenes as a where c.almacen = a.CODIGO;

select almacen, count(NUMREFERENCIA) as Numero_Cajas from cajas group by almacen;

select CODIGO from almacenes where capacidad < (select count(NUMREFERENCIA) from cajas where almacen = CODIGO);

select c.NUMREFERENCIA from cajas as c where c.almacen = (select CODIGO from almacenes where LUGAR = 'Bilbao') ;

insert into almacenes values (11, 'Barcelona', 3);

insert into cajas values ('H5RT', 'Papel', 200, 2);

update cajas set valor=valor*0.85;

#update cajas set valor=valor*0.80 where valor > (select avg(valor) FROM cajas);

delete from cajas where valor<100;

#delete from  cajas where almacen = (select CODIGO from almacenes where capacidad < (select count(NUMREFERENCIA) from cajas where almacen = CODIGO));

#Ejercicio 4.

select nombre from peliculas;

select distinct calificacionedad from peliculas;

select * from peliculas where calificacionedad is null;

select * from salas where pelicula is null;

select * from salas left join peliculas on salas.pelicula = peliculas.codigo;

select * from salas right join peliculas on salas.pelicula = peliculas.codigo;

select peliculas.nombre from salas right join peliculas on salas.pelicula = peliculas.codigo where salas.pelicula is null;

insert into peliculas values (10, 'Uno, Dos, Tres', '+7');

update peliculas set calificacionedad = 'no recomendables para menores de 13 años' where calificacionedad is null;

delete from salas where pelicula in (select codigo from peliculas where calificacionedad = 'G');  
