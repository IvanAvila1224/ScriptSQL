
-- Crear la bd
CREATE DATABASE grandes_almacenes;


--Crear las tablas
CREATE TABLE CAJEROS (
    Codigo SERIAL PRIMARY KEY,  
    NomApels VARCHAR(255) NOT NULL  
);

CREATE TABLE PRODUCTOS (
    Codigo SERIAL PRIMARY KEY, 
    Nombre VARCHAR(100) NOT NULL,  
    Precio INT NOT NULL
);

CREATE TABLE MAQUINAS_REGISTRADORAS (
    Codigo SERIAL PRIMARY KEY,  l
    Piso INT NOT NULL 
);

CREATE TABLE VENTA (
    Cajero INT NOT NULL,  
    Maquina INT NOT NULL,  
    Producto INT NOT NULL,
    PRIMARY KEY (Cajero, Maquina, Producto), 
    FOREIGN KEY (Cajero) REFERENCES CAJEROS(Codigo) ON DELETE CASCADE, 
    FOREIGN KEY (Maquina) REFERENCES MAQUINAS_REGISTRADORAS(Codigo) ON DELETE CASCADE,  
    FOREIGN KEY (Producto) REFERENCES PRODUCTOS(Codigo) ON DELETE CASCADE 
);

-- Población de la tabla CAJEROS
INSERT INTO CAJEROS (NomApels) VALUES ('Ivan Avila');
INSERT INTO CAJEROS (NomApels) VALUES ('Ana Rodriguez');
INSERT INTO CAJEROS (NomApels) VALUES ('Itzel Avila');

-- Población de la tabla MAQUINAS_REGISTRADORAS
INSERT INTO MAQUINAS_REGISTRADORAS (Piso) VALUES (1);
INSERT INTO MAQUINAS_REGISTRADORAS (Piso) VALUES (2);
INSERT INTO MAQUINAS_REGISTRADORAS (Piso) VALUES (3);

-- Población de la tabla PRODUCTOS
INSERT INTO PRODUCTOS (Nombre, Precio) VALUES ('Iphone', 5000);
INSERT INTO PRODUCTOS (Nombre, Precio) VALUES ('Refrigerador', 9000);
INSERT INTO PRODUCTOS (Nombre, Precio) VALUES ('Lavadora', 8000);
INSERT INTO PRODUCTOS (Nombre, Precio) VALUES ('Cama', 4000);

-- Población de la tabla VENTA
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (1, 1, 1);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (2, 2, 2);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (3, 3, 3);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (1, 1, 2);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (2, 2, 3);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (3, 3, 1);
INSERT INTO VENTA (Cajero, Maquina, Producto) VALUES (3, 3, 4);

-- Mostrar el número de ventas de cada producto, ordenado de mas a menos ventas
SELECT P.Nombre, COUNT(V.Producto) AS Ventas
FROM VENTA V
JOIN PRODUCTOS P ON V.Producto = P.Codigo
GROUP BY P.Nombre
ORDER BY Ventas DESC;

-- Obtener un informe completo de ventas, indicando el nombre del cajero que realizó la venta, nombre y precio de los productos vendidos, y el piso en el que se encuentra la máquina registradora donde se realizó la venta.
SELECT C.NomApels AS Cajero, P.Nombre AS Producto, P.Precio, M.Piso
FROM VENTA V
JOIN CAJEROS C ON V.Cajero = C.Codigo
JOIN PRODUCTOS P ON V.Producto = P.Codigo
JOIN MAQUINAS_REGISTRADORAS M ON V.Maquina = M.Codigo;

-- Obtener las ventas totales realizadas en cada piso.
SELECT M.Piso, SUM(P.Precio) AS VentasTotales
FROM VENTA V
JOIN PRODUCTOS P ON V.Producto = P.Codigo
JOIN MAQUINAS_REGISTRADORAS M ON V.Maquina = M.Codigo
GROUP BY M.Piso;

--  Obtener el código y nombre de cada cajero junto con el importe total de sus ventas.
SELECT C.Codigo, C.NomApels, SUM(P.Precio) AS ImporteTotal
FROM VENTA V
JOIN CAJEROS C ON V.Cajero = C.Codigo
JOIN PRODUCTOS P ON V.Producto = P.Codigo
GROUP BY C.Codigo, C.NomApels;
