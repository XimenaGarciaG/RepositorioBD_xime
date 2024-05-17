CREATE TABLE CLIENTEE(
Cliente_ID int not null identity(1,1),
rfc varchar(20) not null,
curp varchar(18)not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_cliente
primary key (Cliente_ID),
constraint unico_rfc
unique(rfc),
constraint unico_curp
unique(curp)
);

CREATE TABLE ContactoProveedor(
Contacto_ID int not null identity(1,1),
Proveedor_ID int not null,
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
constraint pk_contacto
primary key (Contacto_ID),
);

alter TABLE ContactoProveedor
add constraint fk_Proveedor_ContactoP
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)

CREATE TABLE Proveedor(
Proveedor_ID int not null identity(1,1),
nombreEmpresa varchar(50)not null,
rfc varchar(20) not null,
calle varchar(30) not null,
colonia varchar(30) not null,
cp varchar(10)not null,
paginaWeb varchar(80),
constraint pk_proveedor
primary key (Proveedor_ID),
constraint unico_empresa
unique(nombreEmpresa),
constraint unico_rfc2
unique(rfc),
);

CREATE TABLE EMPLEADO(
Empleado_ID int not null identity(1,1),
nombres varchar(50)not null,
apellido_1 varchar(50)not null,
apellido_2 varchar(50)not null,
rfc varchar(20) not null,
curp varchar(18)not null,
numExterno int,
calle varchar(50),
salario money not null,
numNomina int not null,
constraint pk_empleado
primary key (Empleado_ID),
constraint unico_rfc_Empleado
unique (rfc),
constraint unico_Curp_Empleado
unique (curp),
constraint chk_salario
check (salario>=0.0 and salario<=100000),
--Donde el (salario BETWEN entre 0.0 and 100000)--
constraint unico_nomina_empleado
unique (numNomina)
);

CREATE TABLE TelefonoProveedor(
Telefono_ID int not null identity(1,1),
NoTelefono varchar(30)not null,
Proveedor_ID int not null,
constraint pk_telefono_proveedor
primary key (Telefono_ID,Proveedor_ID),
constraint fk_telProveedor_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
on delete cascade
on update cascade
);

CREATE TABLE PRODUCTO(
Num_Control int not null identity(1,1),
descripcion varchar(50)not null,
precio money not null,
[status] int not null,
existencia int not null,
Proveedor_ID int not null,
constraint pk_producto_NumControl
primary key (Num_Control),
constraint unico_descripcion
unique(descripcion),
constraint chk_precio
--precio>=1 y precio<=20000--
check (precio between 1 and 20000),
constraint chk_status
--status en (0,1)--
check([status]=1 or [status]=0),
constraint chk_existencia
check(existencia>0),
constraint fk_Producto_Proveedor
foreign key (Proveedor_ID)
REFERENCES Proveedor (Proveedor_ID)
);
CREATE TABLE ORDEN_COMPRA(
num_Orden int not null identity (1,1),
fecha_orden date not null, 
fecha_entrega date not null,
Cliente_ID int not null,
Empleado_ID int not null,
constraint pk_OrdenCompra
primary key(num_Orden),
constraint fk_OrdenCompra_Cliente
foreign key (Cliente_ID)
references CLIENTEE (Cliente_ID),
constraint fk_OrdenComora_Empleado
foreign key (Empleado_ID)
references EMPLEADO(Empleado_ID)
);

CREATE TABLE Detalle_Compra(
Producto_ID int not null,
num_Orden int not null,
cantidad int not null,
precioCompra money not null
constraint pk_DetalleCompra
primary key(Producto_ID, num_Orden),
constraint fk_OrdenCompra_Producto
foreign key (Producto_ID)
References PRODUCTO(Num_Control),
constraint fk_OrdenCompra_Compra
foreign key (num_Orden)
references ORDEN_COMPRA (num_Orden)
);
