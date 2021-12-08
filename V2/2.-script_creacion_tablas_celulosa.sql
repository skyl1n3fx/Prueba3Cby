CREATE TABLE SUCURSAL(
id_sucursal NUMBER(5) NOT NULL CONSTRAINT PK_SUCURSAL PRIMARY KEY,
nombre_sucursal VARCHAR2(100) NOT NULL, 
pais VARCHAR2(100) NOT NULL
);

CREATE TABLE TIPO_EMPLEADO 
(tipo_empleado      NUMBER(2)NOT NULL , 
 desc_tipo_empleado VARCHAR2(25) NOT NULL);
 
ALTER TABLE TIPO_EMPLEADO 
ADD CONSTRAINT PK_TIPO_EMPLEADO PRIMARY KEY ( tipo_empleado ) ;


CREATE TABLE EMPLEADO(
 rut_empleado NUMBER(8) NOT NULL CONSTRAINT PK_EMPLEADO  PRIMARY KEY,
 dv_rut_empleado VARCHAR2(1) NOT NULL,
 id_sucursal NUMBER(5) NOT NULL,
 apellido    VARCHAR2(30) NOT NULL,
 nombre   VARCHAR2(30) NOT NULL,
 fecha_contratacion   date NOT NULL,
 sueldo       NUMBER(8,2) NOT NULL,
 tipo_empleado NUMBER(2)NOT NULL,
 estado_civil VARCHAR2(15),
 fono_fijo number(8),
 celular number(9),
 direccion_empleado VARCHAR2(50),
 
 CONSTRAINT FK_TIPO_EMPLEADO FOREIGN KEY (tipo_empleado) REFERENCES TIPO_EMPLEADO(tipo_empleado),
 CONSTRAINT FK_SUCURSAL FOREIGN KEY (ID_SUCURSAL)REFERENCES SUCURSAL(ID_SUCURSAL) 
);    


CREATE TABLE TIPO_CLIENTE 
(tipo_cliente      NUMBER(2)NOT NULL , 
 desc_tipo_cliente VARCHAR2(25) NOT NULL);
 
ALTER TABLE TIPO_CLIENTE  
ADD CONSTRAINT PK_TIPO_CLIENTE PRIMARY KEY ( tipo_cliente) ;
 
CREATE TABLE CLIENTE 
(id_cliente NUMBER(10) CONSTRAINT PK_CLIENTE PRIMARY KEY, 
 nombre_cliente VARCHAR2(50)  NOT NULL, 
 apellido_cliente VARCHAR2(50)  NOT NULL, 
 direccion_cliente VARCHAR2(50), 
 fecha_incorporacion DATE  NOT NULL,
 celular number(9),
 tipo_cliente NUMBER(2)NOT NULL,

 CONSTRAINT FK_TIPO_CLIENTE FOREIGN KEY (tipo_cliente) REFERENCES TIPO_CLIENTE(tipo_cliente));

CREATE TABLE FACTURA 
(nro_factura NUMBER(10) CONSTRAINT PK_FACTURA PRIMARY KEY , 
 fecha DATE , 
 monto_total NUMBER(15)  , 
 cantidad_cuotas NUMBER(2)   , 
 id_cliente NUMBER(10) NOT NULL,
 rut_empleado NUMBER(10) NOT NULL,
 
 CONSTRAINT FK_FACTURA_CLIENTE FOREIGN KEY(id_cliente) REFERENCES CLIENTE(id_cliente),
 CONSTRAINT FK_FACTURA_EMPLEADO FOREIGN KEY(rut_empleado) REFERENCES EMPLEADO(rut_empleado));  
 
 CREATE TABLE HISTORICO_FACTURA 
(nro_factura NUMBER(10) CONSTRAINT PK_HIS_FACTURA PRIMARY KEY , 
 fecha DATE , 
 monto_total NUMBER(15)  , 
 cantidad_cuotas NUMBER(2)   , 
 id_cliente NUMBER(10) NOT NULL,
 rut_empleado NUMBER(10) NOT NULL);  
 
CREATE TABLE CUOTA 
(nro_factura NUMBER(10) NOT NULL, 
 nro_cuota NUMBER(2)  NOT NULL , 
 valor_cuota NUMBER(10)  NOT NULL , 
 fecha_vencimiento DATE  NOT NULL,
 CONSTRAINT PK_CUOTA PRIMARY KEY(nro_factura,nro_cuota),
 CONSTRAINT FK_CUOTA_FACTURA FOREIGN KEY (nro_factura) REFERENCES FACTURA(nro_factura));

CREATE TABLE COMISION_VENTAS 
(nro_factura     NUMBER (8)  NOT NULL,
 monto_comision NUMBER (8)  NOT NULL,
 CONSTRAINT PK_COMISION_VENTAS PRIMARY KEY(nro_factura),
 CONSTRAINT FK_COMISION_VENTAS FOREIGN KEY (nro_factura) REFERENCES FACTURA(nro_factura));
 

--inserción de datos
INSERT INTO sucursal VALUES(1, 'BARADERO_PERU', 'PERU');
INSERT INTO sucursal VALUES(2, 'BARADERO_CHILE', 'CHILE');
INSERT INTO sucursal VALUES(3, 'BARADERO_ARGENTINA', 'ARGENTINA');
INSERT INTO sucursal VALUES(4, 'BARADERO_BRASIL', 'BRASIL');

INSERT INTO tipo_empleado VALUES(1,'Vendedor Categoria 1');
INSERT INTO tipo_empleado VALUES(2,'Vendedor Categoria 1');
INSERT INTO tipo_empleado VALUES(3,'Vendedor Categoria 2');
INSERT INTO tipo_empleado VALUES(4,'Vendedor Categoria 4');

INSERT INTO tipo_cliente VALUES(1,'Standard');
INSERT INTO tipo_cliente VALUES(2,'Platino');
INSERT INTO tipo_cliente VALUES(3,'Premium');
INSERT INTO tipo_cliente VALUES(4,'Gold');

INSERT INTO cliente VALUES(1,'Andres','lopez','av los toros #1340', to_date('03/07/2000', 'dd/mm/yyyy'),989876543, 1);
INSERT INTO cliente VALUES(2,'Pedro','riveros','av los coipos #2212', to_date('01/01/2001', 'dd/mm/yyyy'),888776548, 1);
INSERT INTO cliente VALUES(3,'Juan','madariaga','pasaje los lirios #340', to_date('02/01/2012', 'dd/mm/yyyy'),987654321, 2);
INSERT INTO cliente VALUES(4,'Ana', 'martinez','av nonato coo #1010',to_date('03/01/2012', 'dd/mm/yyyy'),989876999, 2);
INSERT INTO cliente VALUES(5,'Maria','toro','av libertador #6565', to_date('21/02/2014', 'dd/mm/yyyy'),989876222, 2);
INSERT INTO cliente VALUES(6,'Claudio','pino','av san hugo #1215', to_date('19/02/2014', 'dd/mm/yyyy'),989876111, 2);
INSERT INTO cliente VALUES(7,'Sara', 'concha','av san francisco #0112',to_date('12/08/2017', 'dd/mm/yyyy'),989876998, 2);
INSERT INTO cliente VALUES(8,'Gabriel', 'arriagada','pasaje claro #123',to_date('30/10/2017', 'dd/mm/yyyy'),989876323, 3);
INSERT INTO cliente VALUES(9,'Cesar', 'maripil','pasaje celeste #211',to_date('22/10/2017', 'dd/mm/yyyy'),989876754, 3);
INSERT INTO cliente VALUES(10,'Maria', 'march','pasaje los montes #9191',to_date('23/12/2016', 'dd/mm/yyyy'),null, 4);

INSERT INTO cliente VALUES(11,'Alberto', 'gomez','av peru #345',to_date('03/02/2000', 'dd/mm/yyyy'), null,1);
INSERT INTO cliente VALUES(12,'Antonio','millar','av lira #9887', to_date('01/03/2001', 'dd/mm/yyyy'), null,1);
INSERT INTO cliente VALUES(13,'Amos', 'mora','av los leones #5534',to_date('08/04/2012', 'dd/mm/yyyy'), null,2);
INSERT INTO cliente VALUES(14,'Francisco','vega','calle el zarzal #1111', to_date('07/04/2012', 'dd/mm/yyyy'),null, 2);
INSERT INTO cliente VALUES(15,'Camila','valez','calle maitencillo #1260', to_date('21/02/2014', 'dd/mm/yyyy'), null,2);
INSERT INTO cliente VALUES(16,'Vannesa','galvez','calle cerro alegre #998', to_date('29/02/2014', 'dd/mm/yyyy'),989765543, 2);
INSERT INTO cliente VALUES(17,'Paula','soto','av feligreses #0087', to_date('22/08/2017', 'dd/mm/yyyy'), 989899843,2);
INSERT INTO cliente VALUES(18,'Pedro','cortez','av la florida #1920', to_date('30/11/2017', 'dd/mm/yyyy'), 981116543,3);
INSERT INTO cliente VALUES(19,'Paul', 'soto','calle nueva vida #3040',to_date('20/11/2017', 'dd/mm/yyyy'), 981234543,3);
INSERT INTO cliente VALUES(20,'Amelia','silva','pasaje moral #4430', to_date('27/12/2016', 'dd/mm/yyyy'), 912345678,4);


INSERT INTO empleado VALUES('17924636','1', 1 , 'lopez','juan', to_date('01/01/2016', 'dd/mm/yyyy'), 300000, 1, 'soltero', null, 87654321,'av los toros #1340, Puente Alto');
INSERT INTO empleado VALUES('18999922','2', 1 , 'bell','ellen', to_date('12/02/2016', 'dd/mm/yyyy'), 400000, 1, 'soltero', null, 87654333,'av los coipos #2212, La Florida');
INSERT INTO empleado VALUES('18767676','3', 1 , 'bear','sundar', to_date('14/02/2015', 'dd/mm/yyyy'), 500000, 1, 'soltero', null, null,'pasaje los lirios #340, La Florida');
INSERT INTO empleado VALUES('15987654','4', 1 , 'blom','moche', to_date('17/03/2015', 'dd/mm/yyyy'), 500000, 1, 'casado', null, null,'av nonato coo #1010, La Florida');
INSERT INTO empleado VALUES('17987654','5', 2 , 'chen','herman', to_date('18/04/2015', 'dd/mm/yyyy'), 450000, 1, 'casado', null, 87654666,'av libertador #6565, Puente Alto');
INSERT INTO empleado VALUES('16545444','6', 2 , 'chung','david', to_date('19/04/2015', 'dd/mm/yyyy'), 340000, 1, 'casado', null, null,'av san hugo #1215, Puente Alto');
INSERT INTO empleado VALUES('12976578','7', 2 , 'davies','shelli', to_date('19/05/2014', 'dd/mm/yyyy'), 330000, 1, 'casado', null, 87654888,'av san francisco #0112, La Florida');
INSERT INTO empleado VALUES('18987653','8', 2 , 'dilly','eli', to_date('25/05/2000', 'dd/mm/yyyy'), 460000, 2, 'casado', null, null,'pasaje claro #123, Puente Alto');
INSERT INTO empleado VALUES('16111222','9', 2 , 'doran','amit', to_date('28/05/2000', 'dd/mm/yyyy'), 800000, 2, 'casado', null, 98654321,'pasaje celeste #211, Puente Alto');
INSERT INTO empleado VALUES('14232321','k', 2 , 'cabrio','sara', to_date('29/06/1990', 'dd/mm/yyyy'), 700000, 2, 'soltero', null, 96654321,'pasaje los montes #9191, La Florida');
INSERT INTO empleado VALUES('17999966','k', 3 , 'rolex','laura', to_date('01/06/1995', 'dd/mm/yyyy'), 600000, 2, 'soltero', null, 95654321,'av peru #345, Las Condes');
INSERT INTO empleado VALUES('17434343','k', 3 , 'tobias','alexis', to_date('01/10/1992', 'dd/mm/yyyy'), 570000, 2, 'soltero', null, 94654327,'av lira #9887, Puente Alto');
INSERT INTO empleado VALUES('18009878','2', 4 , 'tucker','antonhy', to_date('07/10/1990', 'dd/mm/yyyy'), 670000, 2, 'soltero', null, 93654325,'av los leones #5534, Puente Alto');
INSERT INTO empleado VALUES('16112233','3', 4 , 'vargas','gerald', to_date('11/10/1990', 'dd/mm/yyyy'), 480000, 2, 'soltero', null, 91654321,'calle el zarzal #1111, Las Condes');
INSERT INTO empleado VALUES('16332244','4', 4 , 'taylor','alberto', to_date('12/11/1991', 'dd/mm/yyyy'), 900000, 2, 'soltero', null, 97654322,'calle maitencillo #1260, Puente Alto');
INSERT INTO empleado VALUES('16998877','4', 4 , 'smith','bruce', to_date('17/01/1999', 'dd/mm/yyyy'), 390000, 3, 'soltero', null, 97654341,'calle cerro alegre #998, Puente Alto');
INSERT INTO empleado VALUES('15767544','5', 2 , 'urmal','curtis', to_date('22/01/1998', 'dd/mm/yyyy'), 550000, 3, 'divorciado', null, null,'av feligreses #0087, Providencia');
INSERT INTO empleado VALUES('16876542','6', 2 , 'walsh','karen', to_date('22/01/1990', 'dd/mm/yyyy'), 530000, 4, 'divorciado', null, 97623421,'av la florida #1920, Providencia');
INSERT INTO empleado VALUES('18123577','7', 2 , 'zeller','britany', to_date('02/08/2000', 'dd/mm/yyyy'), 280000, 4, 'soltero', null, null,'calle nueva vida #3040, Providencia');
INSERT INTO empleado VALUES('15754456','8', 2 , 'whalen','lex', to_date('05/09/2005', 'dd/mm/yyyy'), 310000, 4, 'soltero', null, 91222321,'pasaje moral #4430, Huechuraba');
INSERT INTO empleado VALUES('13988766','9', 2 , 'gates','john', to_date('03/09/2003', 'dd/mm/yyyy'), 700000, 4, 'soltero', null, 97654321,'pasaje merida #0007, Huechuraba');

INSERT INTO empleado VALUES('88888765','1', 2 , 'cartes','curt', to_date('01/07/2003', 'dd/mm/yyyy'), 350000, 1, 'soltero', null, 97654323,'pasaje athenas #0012, Vitacura');
INSERT INTO empleado VALUES('55454444','2', 2 , 'calahan','ana', to_date('01/02/2004', 'dd/mm/yyyy'), 650000, 1, 'soltero', null, 97654554,'calle primavera #1332, Pirq');


INSERT INTO factura VALUES(100,to_date('03/09/2017', 'dd/mm/yyyy'), 100000, 1, 1 , 17924636);
INSERT INTO factura VALUES(101,to_date('03/09/2017', 'dd/mm/yyyy'), 200000, 2, 1 , 14232321);
INSERT INTO factura VALUES(102,to_date('03/09/2017', 'dd/mm/yyyy'), 1500000, 3, 1 , 18009878);
INSERT INTO factura VALUES(103,to_date('03/09/2017', 'dd/mm/yyyy'), 425000, 1, 1 , 18009878);
INSERT INTO factura VALUES(104,to_date('07/04/2017', 'dd/mm/yyyy'), 94000, 1, 2 , 18009878);
INSERT INTO factura VALUES(105,to_date('07/04/2017', 'dd/mm/yyyy'), 230000, 1, 2 , 18123577);
INSERT INTO factura VALUES(106,to_date('07/04/2017', 'dd/mm/yyyy'), 186500, 1, 2 , 16876542);
INSERT INTO factura VALUES(107,to_date('12/12/2017', 'dd/mm/yyyy'), 300000, 1, 2 , 13988766);
INSERT INTO factura VALUES(108,to_date('12/12/2017', 'dd/mm/yyyy'), 700000, 1, 3 , 16111222);
INSERT INTO factura VALUES(109,to_date('20/01/2004', 'dd/mm/yyyy'), 850000, 2, 3 , 17999966);
INSERT INTO factura VALUES(110,to_date('20/01/2004', 'dd/mm/yyyy'), 830000, 2, 3 , 12976578);
INSERT INTO factura VALUES(111,to_date('22/03/2005', 'dd/mm/yyyy'), 1200000, 1, 4 , 17924636);
INSERT INTO factura VALUES(112,to_date('18/04/2006', 'dd/mm/yyyy'), 1700000, 1, 4 , 18767676);
INSERT INTO factura VALUES(113,to_date('19/04/2007', 'dd/mm/yyyy'), 440000, 2, 6 , 18009878);
INSERT INTO factura VALUES(114,to_date('19/05/2008', 'dd/mm/yyyy'), 520000, 1, 7 , 18987653);
INSERT INTO factura VALUES(115,to_date('29/05/2009', 'dd/mm/yyyy'), 680000, 1, 8 , 17924636);

INSERT INTO factura VALUES(119,to_date('25/06/2017', 'dd/mm/yyyy'), 350000, null, 5 , 17924636);
INSERT INTO factura VALUES(120,to_date('24/06/2017', 'dd/mm/yyyy'), 420000, null, 5 , 18987653);

INSERT INTO factura VALUES(121,to_date('20/07/2017', 'dd/mm/yyyy'), 434000, null, 6 , 18987653);
INSERT INTO factura VALUES(122,to_date('21/07/2017', 'dd/mm/yyyy'), 387000, null, 6 , 17924636);
INSERT INTO factura VALUES(123,to_date('22/07/2017', 'dd/mm/yyyy'), 399000, null, 6 , 18767676);

INSERT INTO factura VALUES(124,to_date('12/09/2017', 'dd/mm/yyyy'), 123000, 4, 11 , 16112233);
INSERT INTO factura VALUES(125,to_date('23/09/2017', 'dd/mm/yyyy'), 230000, 2, 12 , 16332244);
INSERT INTO factura VALUES(126,to_date('30/09/2017', 'dd/mm/yyyy'), 175000, 3, 13 , 15754456);
INSERT INTO factura VALUES(127,to_date('03/08/2017', 'dd/mm/yyyy'), 725000, 2, 14 , 15767544);
INSERT INTO factura VALUES(128,to_date('01/07/2017', 'dd/mm/yyyy'), 94500, 1, 15 , 17434343);
INSERT INTO factura VALUES(129,to_date('24/07/2017', 'dd/mm/yyyy'), 33500, 1, 15 , 18123577);
INSERT INTO factura VALUES(130,to_date('29/10/2017', 'dd/mm/yyyy'), 387500, 2, 15 , 16876542);


INSERT INTO cuota VALUES(124, 1, 30750 , to_date('03/11/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(124, 2, 30750 , to_date('03/12/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(124, 3, 30750 , to_date('03/01/2018', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(124, 4, 30750 , to_date('03/02/2018', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(125, 1, 115000 , to_date('01/11/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(125, 2, 115000 , to_date('01/12/2017', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(126, 1, 58333 , to_date('01/11/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(126, 2, 58333 , to_date('01/12/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(126, 3, 58333 , to_date('01/01/2018', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(127, 1, 362500 , to_date('30/09/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(127, 2, 362500 , to_date('30/10/2017', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(128, 1, 94500 , to_date('01/08/2017', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(129, 1, 33500 , to_date('24/08/2017', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(130, 1, 193750 , to_date('29/11/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(130, 2, 193750 , to_date('29/12/2017', 'dd/mm/yyyy'));








--pago cuotas
INSERT INTO cuota VALUES(100, 1, 100000 , to_date('01/11/2017', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(101, 1, 100000 , to_date('01/12/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(101, 2, 100000 , to_date('01/01/2018', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(102, 1, 500000 , to_date('12/11/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(102, 2, 500000 , to_date('12/12/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(102, 3, 500000 , to_date('12/01/2018', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(103, 1, 425000 , to_date('01/10/2017', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(104, 1, 100000 , to_date('07/05/2016', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(105, 1, 230000 , to_date('07/05/2016', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(106, 1, 186500 , to_date('07/05/2010', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(107, 1, 300000 , to_date('12/01/2013', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(108, 1, 100000 , to_date('12/01/2013', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(109, 1, 425000 , to_date('20/02/2004', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(109, 2, 425000 , to_date('20/03/2004', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(110, 1, 415000 , to_date('20/02/2004', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(110, 2, 415000 , to_date('20/03/2004', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(111, 1, 1200000 , to_date('22/04/2005', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(112, 1, 1700000 , to_date('18/05/2006', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(113, 1, 220000 , to_date('19/05/2007', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(113, 2, 220000, to_date('19/06/2007', 'dd/mm/yyyy'));

INSERT INTO cuota VALUES(114, 1, 520000, to_date('19/06/2008', 'dd/mm/yyyy'));
INSERT INTO cuota VALUES(115, 1, 680000, to_date('29/06/2009', 'dd/mm/yyyy'));



INSERT INTO comision_ventas VALUES (100,9750);
INSERT INTO comision_ventas VALUES (101,13000);
INSERT INTO comision_ventas VALUES (102,9750);
INSERT INTO comision_ventas VALUES (103,5876);
INSERT INTO comision_ventas VALUES (104,9750);
INSERT INTO comision_ventas VALUES (105,13500);
INSERT INTO comision_ventas VALUES (106,9250);
INSERT INTO comision_ventas VALUES (107,5174);

INSERT INTO comision_ventas VALUES (111,5678);
INSERT INTO comision_ventas VALUES (112,9988);
INSERT INTO comision_ventas VALUES (113,10000);
INSERT INTO comision_ventas VALUES (114,13000);


INSERT INTO HISTORICO_FACTURA VALUES(100,to_date('03/09/2017', 'dd/mm/yyyy'), 100000, 1, 1 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(101,to_date('03/09/2017', 'dd/mm/yyyy'), 200000, 2, 1 , 14232321);
INSERT INTO HISTORICO_FACTURA VALUES(102,to_date('03/09/2017', 'dd/mm/yyyy'), 1500000, 3, 1 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(103,to_date('03/09/2017', 'dd/mm/yyyy'), 425000, 1, 1 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(104,to_date('07/04/2017', 'dd/mm/yyyy'), 94000, 1, 2 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(105,to_date('07/04/2017', 'dd/mm/yyyy'), 230000, 1, 2 , 18123577);
INSERT INTO HISTORICO_FACTURA VALUES(106,to_date('07/04/2017', 'dd/mm/yyyy'), 186500, 1, 2 , 16876542);
INSERT INTO HISTORICO_FACTURA VALUES(107,to_date('12/12/2017', 'dd/mm/yyyy'), 300000, 1, 2 , 13988766);
INSERT INTO HISTORICO_FACTURA VALUES(108,to_date('12/12/2017', 'dd/mm/yyyy'), 700000, 1, 3 , 16111222);
INSERT INTO HISTORICO_FACTURA VALUES(109,to_date('20/01/2004', 'dd/mm/yyyy'), 850000, 2, 3 , 17999966);
INSERT INTO HISTORICO_FACTURA VALUES(110,to_date('20/01/2004', 'dd/mm/yyyy'), 830000, 2, 3 , 12976578);
INSERT INTO HISTORICO_FACTURA VALUES(111,to_date('22/03/2005', 'dd/mm/yyyy'), 1200000, 1, 4 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(112,to_date('18/04/2006', 'dd/mm/yyyy'), 1700000, 1, 4 , 18767676);
INSERT INTO HISTORICO_FACTURA VALUES(113,to_date('19/04/2007', 'dd/mm/yyyy'), 440000, 2, 6 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(114,to_date('19/05/2008', 'dd/mm/yyyy'), 520000, 1, 7 , 18987653);
INSERT INTO HISTORICO_FACTURA VALUES(115,to_date('29/05/2009', 'dd/mm/yyyy'), 680000, 1, 8 , 17924636);

INSERT INTO HISTORICO_FACTURA VALUES(119,to_date('25/06/2017', 'dd/mm/yyyy'), 350000, null, 5 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(120,to_date('24/06/2017', 'dd/mm/yyyy'), 420000, null, 5 , 18987653);

INSERT INTO HISTORICO_FACTURA VALUES(121,to_date('20/07/2017', 'dd/mm/yyyy'), 434000, null, 6 , 18987653);
INSERT INTO HISTORICO_FACTURA VALUES(122,to_date('21/07/2017', 'dd/mm/yyyy'), 387000, null, 6 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(123,to_date('22/07/2017', 'dd/mm/yyyy'), 399000, null, 6 , 18767676);

INSERT INTO HISTORICO_FACTURA VALUES(124,to_date('12/09/2017', 'dd/mm/yyyy'), 123000, 4, 11 , 16112233);
INSERT INTO HISTORICO_FACTURA VALUES(125,to_date('23/09/2017', 'dd/mm/yyyy'), 230000, 2, 12 , 16332244);
INSERT INTO HISTORICO_FACTURA VALUES(126,to_date('30/09/2017', 'dd/mm/yyyy'), 175000, 3, 13 , 15754456);
INSERT INTO HISTORICO_FACTURA VALUES(127,to_date('03/08/2017', 'dd/mm/yyyy'), 725000, 2, 14 , 15767544);
INSERT INTO HISTORICO_FACTURA VALUES(128,to_date('01/07/2017', 'dd/mm/yyyy'), 94500, 1, 15 , 17434343);
INSERT INTO HISTORICO_FACTURA VALUES(129,to_date('24/07/2017', 'dd/mm/yyyy'), 33500, 1, 15 , 18123577);
INSERT INTO HISTORICO_FACTURA VALUES(130,to_date('29/10/2017', 'dd/mm/yyyy'), 387500, 2, 15 , 16876542);

INSERT INTO HISTORICO_FACTURA VALUES(131,to_date('13/09/2017', 'dd/mm/yyyy'), 130000, 1, 5 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(132,to_date('23/09/2017', 'dd/mm/yyyy'), 212000, 2, 6 , 14232321);
INSERT INTO HISTORICO_FACTURA VALUES(133,to_date('30/09/2017', 'dd/mm/yyyy'), 355000, 3, 7 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(134,to_date('28/09/2017', 'dd/mm/yyyy'), 428000, 1, 2 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(135,to_date('12/04/2017', 'dd/mm/yyyy'), 92000, 1, 8 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(136,to_date('15/04/2017', 'dd/mm/yyyy'), 135000, 1, 9 , 18123577);
INSERT INTO HISTORICO_FACTURA VALUES(137,to_date('02/04/2017', 'dd/mm/yyyy'), 126500, 1, 9 , 16876542);
INSERT INTO HISTORICO_FACTURA VALUES(138,to_date('09/12/2017', 'dd/mm/yyyy'), 124000, 1, 3 , 13988766);
INSERT INTO HISTORICO_FACTURA VALUES(139,to_date('19/12/2017', 'dd/mm/yyyy'), 740000, 1, 2 , 16111222);
INSERT INTO HISTORICO_FACTURA VALUES(140,to_date('17/01/2004', 'dd/mm/yyyy'), 890000, 2, 1 , 17999966);
INSERT INTO HISTORICO_FACTURA VALUES(141,to_date('11/01/2004', 'dd/mm/yyyy'), 82000, 2, 1 , 12976578);
INSERT INTO HISTORICO_FACTURA VALUES(142,to_date('21/03/2005', 'dd/mm/yyyy'), 22000, 1, 2 , 17924636);
INSERT INTO HISTORICO_FACTURA VALUES(143,to_date('28/04/2006', 'dd/mm/yyyy'), 1750000, 1, 3 , 18767676);
INSERT INTO HISTORICO_FACTURA VALUES(144,to_date('29/04/2007', 'dd/mm/yyyy'), 4400000, 2, 6 , 18009878);
INSERT INTO HISTORICO_FACTURA VALUES(145,to_date('29/05/2008', 'dd/mm/yyyy'), 525000, 1, 7 , 18987653);
INSERT INTO HISTORICO_FACTURA VALUES(146,to_date('09/05/2009', 'dd/mm/yyyy'), 780000, 1, 8 , 17924636);

commit;