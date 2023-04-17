/*
	Bases de Datos I	
	Proyecto II
	Creado por:
		Daniel Vargas Castro
		Harold Ramírez Mora
		Armando Villalta Pérez
*/

create database SistemaControlFinca;
go
use SistemaControlFinca;
go
create schema SCF;
go

-- Creación de la tabla Trabajadores (Entidad)
IF OBJECT_ID ('SCF.Trabajadores', 'U') IS NOT NULL 
   drop table SCF.Trabajadores;
go

create table SCF.Trabajadores
(
    Cedula				char(11)        not null,
    Nombre              varchar(30)        not null,
    Apellido1           varchar(30)        not null,
    Apellido2           varchar(30)        not null,
    constraint	PK_Cedula_Trabajadores primary key (Cedula),
	CONSTRAINT CHK_Cedula_Trabajadores
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla TelefonosTrabajadores (Atributo Multivalorado)
IF OBJECT_ID ('SCF.TelefonosTrabajadores', 'U') IS NOT NULL 
   drop table SCF.TelefonosTrabajadores;
go

create table SCF.TelefonosTrabajadores
(
    Cedula				char(11)		not null,
    Telefono			char(9)			not null,
    constraint	PK_Cedula_Telefonos_TelefonosTrabajadores primary key (Cedula,Telefono),
    constraint	FK_Cedula_TelefonosTrabajadores foreign key (Cedula) references SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TelefonosTrabajadores
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'),
	CONSTRAINT CHK_Telefonos_TelefonosTrabajadores
        check (Telefono like  '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla Reses (Entidad)
IF OBJECT_ID ('SCF.Reses', 'U') IS NOT NULL 
   drop table SCF.Reses;
go
create table SCF.Reses
(
	IdRes				int				not null,
	Fierro				char(3)			not null default('E2X'),
	Genero				char(1)			not null default('H'),
	Raza				char(10)		not null default('Gyr'),
	constraint	PK_IdRes_Reses primary key (IdRes),
	CONSTRAINT CHK_Genero_Reses
		 check (Genero in ('H','M'))
);
go

-- Creación de la tabla Ventas (Entidad)
IF OBJECT_ID ('SCF.Ventas', 'U') IS NOT NULL 
   drop table SCF.Ventas;
go
create table SCF.Ventas
(
	Fecha				date			not null,
	TotalLitros			int				not null,
	constraint	PK_Fecha_Ventas primary key (Fecha),
	CONSTRAINT CHK_Fecha_Ventas
        check (Fecha like  '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
);
go

-- Creación de la tabla Ordeños (Entidad)
IF OBJECT_ID ('SCF.Ordeños', 'U') IS NOT NULL 
   drop table SCF.Ordeños;
go
create table SCF.Ordeños
(
	FechaHora			smalldatetime		not null,
	LitrosLeche			int				not null,
	constraint	PK_FechaHora_Ordeños primary key (FechaHora)
);
go

-- Creación de la tabla Ovulaciones (Entidad)
IF OBJECT_ID ('SCF.Ovulaciones', 'U') IS NOT NULL 
   drop table SCF.Ovulaciones;
go
create table SCF.Ovulaciones
(
	FechaHora		smalldatetime		not null,
	Descripcion		varchar(300)		null,
	CONSTRAINT PK_FechaHora_Ovulaciones 
		PRIMARY KEY (FechaHora)
);
go

-- Creación de la tabla Gestaciones (Entidad)
IF OBJECT_ID ('SCF.Gestaciones', 'U') IS NOT NULL 
   drop table SCF.Gestaciones;
go
create table SCF.Gestaciones
(
	FechaHoraPreñez		smalldatetime	not null,
	RazaPadrote			char(10)	not null default ('Brahman'),
	CONSTRAINT PK_FechaHoraPreñez_Gestaciones 
		PRIMARY KEY (FechaHoraPreñez),

);
go

-- Creación de la tabla Pastoreos (Entidad)
IF OBJECT_ID ('SCF.Pastoreos', 'U') IS NOT NULL 
   drop table SCF.Pastoreos;
go
create table SCF.Pastoreos
(
	NumeroLote			int			not null,
	CantidadReses		int			not null,
	FechaHoraInicio		smalldatetime	not null,
	FechaHoraFinal		smalldatetime	not null,
	CONSTRAINT PK_NumeroLote_Pastoreos 
		PRIMARY KEY (NumeroLote),
);
go

-- Creación de la tabla Alimentaciones (Entidad)
IF OBJECT_ID ('SCF.Alimentaciones', 'U') IS NOT NULL 
   drop table SCF.Alimentaciones;
go
create table SCF.Alimentaciones
(
	FechaHora		smalldatetime		 not null,
	Tipo			varchar(20)		 not null default('Concentrado'),
	Descripcion		varchar(300)		 null,
	CONSTRAINT PK_FechaHora_Alimentaciones 
		PRIMARY KEY (FechaHora)
);
go

-- Creación de la tabla Medicamentos (Entidad)
IF OBJECT_ID ('SCF.Medicamentos', 'U') IS NOT NULL 
   drop table SCF.Medicamentos;
go
create table SCF.Medicamentos
(
    Nombre				varchar(30)        not null,
    CantidadDisponible  int             not null,
    FechaExpiracion     date            not null,
    Descripcion         varchar(300)		null,
    constraint	PK_Nombre_Medicamentos primary key (Nombre)
);
go

-- Creación de la tabla Vacunaciones (Entidad)
IF OBJECT_ID ('SCF.Vacunaciones', 'U') IS NOT NULL 
   drop table SCF.Vacunaciones;
go
create table SCF.Vacunaciones
(
    FechaHora			smalldatetime		not null,
    constraint	PK_FechaHora_Vacunaciones primary key (FechaHora)
);
go

-- Creación de la tabla VentasOrdeños (Relacion N:N)
IF OBJECT_ID ('SCF.VentasOrdeños', 'U') IS NOT NULL 
   drop table SCF.VentasOrdeños;
go
create table SCF.VentasOrdeños
(
	FechaHora			smalldatetime		not null,
	FechaVenta			date			not null,
	constraint	PK_FechaHora_FechaVenta_VentasOrdeños primary key (FechaHora,FechaVenta),
	constraint	FK_FechaHora_VentasOrdeños foreign key (FechaHora) references SCF.Ordeños(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_FechaVenta_VentasOrdeños foreign key (FechaVenta) references SCF.Ventas(Fecha) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_FechaVenta_VentasOrdeños
        check (FechaVenta like  '[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
);
go

-- Creación de la tabla ResesPastoreos (Relacion N:N)
IF OBJECT_ID ('SCF.ResesPastoreos', 'U') IS NOT NULL 
   drop table SCF.ResesPastoreos;
go
create table SCF.ResesPastoreos
(
	IdRes				int				not null,
	NumeroLote			int				not null,
	constraint	PK_IdRes_NumeroLote_ResesPastoreos primary key (IdRes,NumeroLote),
	constraint	FK_IdRes_ResesPastoreos foreign key (IdRes) references SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_NumeroLote_ResesPastoreos foreign key (NumeroLote) references SCF.Pastoreos(NumeroLote) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla ResesOvulaciones (Relacion N:N)
IF OBJECT_ID ('SCF.ResesOvulaciones', 'U') IS NOT NULL 
   drop table SCF.ResesOvulaciones;
go
create table SCF.ResesOvulaciones
(
	IdRes				int				not null,
	FechaHora			smalldatetime		not null,
	constraint	PK_IdRes_FechaHora_ResesOvulaciones primary key (IdRes,FechaHora),
	constraint	FK_IdRes_ResesOvulaciones foreign key (IdRes) references SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_FechaHora_ResesOvulaciones foreign key (FechaHora) references SCF.Ovulaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla ResesGestaciones (Relacion N:N)
IF OBJECT_ID ('SCF.ResesGestaciones', 'U') IS NOT NULL 
   drop table SCF.ResesGestaciones;
go
create table SCF.ResesGestaciones
(
	IdRes				int				not null,
	FechaHoraPreñez		smalldatetime		not null,
	constraint	PK_IdRes_FechaHora_ResesGestaciones primary key (IdRes,FechaHoraPreñez),
	constraint	FK_IdRes_ResesGestaciones foreign key (IdRes) references SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_FechaHoraPreñez_ResesGestaciones foreign key (FechaHoraPreñez) references SCF.Gestaciones(FechaHoraPreñez) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla ResesOrdeños (Relacion N:N)
IF OBJECT_ID ('SCF.ResesOrdeños', 'U') IS NOT NULL 
   drop table SCF.ResesOrdeños;
go
create table SCF.ResesOrdeños
(
	IdRes				int				not null,
	FechaHora			smalldatetime		not null,
	constraint	PK_IdRes_FechaHora_ResesOrdeños primary key (IdRes,FechaHora),
	constraint	FK_IdRes_ResesOrdeños foreign key (IdRes) references SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_FechaHora_ResesOrdeños foreign key (FechaHora) references SCF.Ordeños(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla VacunacionesMedicamentos (Relacion N:N)
IF OBJECT_ID ('SCF.VacunacionesMedicamentos', 'U') IS NOT NULL 
   drop table SCF.VacunacionesMedicamentos;
go
create table SCF.VacunacionesMedicamentos
(
	Nombre				varchar(30)		not null,
	FechaHora			smalldatetime		not null,
	Dosis				char(6)			not null,
	constraint	PK_Nombre_FechaHora_VacunacionesMedicamentos primary key (Nombre,FechaHora),
	constraint	FK_Nombre_VacunacionesMedicamentos foreign key (Nombre) references SCF.Medicamentos(Nombre) ON UPDATE CASCADE ON DELETE CASCADE,
	constraint	FK_Dosis_VacunacionesMedicamentos foreign key (FechaHora) references SCF.Vacunaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
    constraint	CHK_Dosis_VacunacionesMedicamentos check (Dosis like '[0-9][0-9][0-9][0-9]ml')

);
go

-- Creación de la tabla ResesAlimentaciones (Relacion N:N)
IF OBJECT_ID ('SCF.ResesAlimentaciones', 'U') IS NOT NULL 
   drop table SCF.ResesAlimentaciones;
go
create table SCF.ResesAlimentaciones
(
	IdRes			int				not null,
	FechaHora		smalldatetime		not null,

	CONSTRAINT PK_FechaHora_IdRes_ResesAlimentaciones 
		PRIMARY KEY (FechaHora, IdRes),
	CONSTRAINT FK_FechaHora_ResesAlimentaciones
		FOREIGN KEY (FechaHora) REFERENCES SCF.Alimentaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_IdRes_ResesAlimentaciones
		FOREIGN KEY (IdRes)		REFERENCES SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla ResesVacunaciones (Relacion N:N)
IF OBJECT_ID ('SCF.ResesVacunaciones', 'U') IS NOT NULL 
   drop table SCF.ResesVacunaciones;
go
create table SCF.ResesVacunaciones
(
	IdRes			int				not null,
	FechaHora		smalldatetime		not null,
	CONSTRAINT PK_FechaHora_IdRes_ResesVacunaciones  
		PRIMARY KEY (IdRes, FechaHora),
	CONSTRAINT FK_IdRes_ResesVacunaciones 
		FOREIGN KEY (IdRes) REFERENCES SCF.Reses(IdRes) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_FechaHora_ResesVacunaciones 
		FOREIGN KEY (FechaHora) REFERENCES SCF.Vacunaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE
);
go

-- Creación de la tabla TrabajadoresOvulaciones (Relacion N:N)
IF OBJECT_ID ('SCF.TrabajadoresOvulaciones', 'U') IS NOT NULL 
   drop table SCF.TrabajadoresOvulaciones;
go
create table SCF.TrabajadoresOvulaciones
(
	Cedula				char(11)		not null,
	FH_Ovulaciones		smalldatetime		not null,
	CONSTRAINT PK_Cedula_FH_Ovulaciones_TrabajadoresOvulaciones
		PRIMARY KEY (Cedula, FH_Ovulaciones),
	CONSTRAINT FK_Cedula_TrabajadoresOvulaciones 
		FOREIGN KEY (Cedula) REFERENCES SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_FH_Ovulaciones_TrabajadoresOvulaciones 
		FOREIGN KEY (FH_Ovulaciones) REFERENCES SCF.Ovulaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TrabajadoresOvulaciones
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla TrabajadoresOrdeños (Relacion N:N)
IF OBJECT_ID ('SCF.TrabajadoresOrdeños', 'U') IS NOT NULL 
   drop table SCF.TrabajadoresOrdeños;
go
create table SCF.TrabajadoresOrdeños
(
	Cedula				char(11)		not null,
	FH_Ordeños			smalldatetime		not null,
	CONSTRAINT PK_Cedula_FH_Ordeños_TrabajadoresOrdeños
		PRIMARY KEY (Cedula, FH_Ordeños),
	CONSTRAINT FK_Cedula_TrabajadoresOrdeños 
		FOREIGN KEY (Cedula) REFERENCES SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_FH_Ordeños_TrabajadoresOrdeños 
		FOREIGN KEY (FH_Ordeños) REFERENCES SCF.Ordeños(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TrabajadoresOrdeños
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla TrabajadoresVacunaciones (Relacion N:N)
IF OBJECT_ID ('SCF.TrabajadoresVacunaciones', 'U') IS NOT NULL 
   drop table SCF.TrabajadoresVacunaciones;
go
create table SCF.TrabajadoresVacunaciones
(
	Cedula				char(11)		not null,
	FH_Vacunaciones		smalldatetime		not null,
	CONSTRAINT PK_Cedula_FH_Vacunaciones_TrabajadoresVacunaciones
		PRIMARY KEY (Cedula, FH_Vacunaciones),
	CONSTRAINT FK_Cedula_TrabajadoresVacunaciones 
		FOREIGN KEY (Cedula) REFERENCES SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_FH_Vacunaciones_TrabajadoresVacunaciones 
		FOREIGN KEY (FH_Vacunaciones) REFERENCES SCF.Vacunaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TrabajadoresVacunaciones
        check (Cedula like '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla TrabajadoresAlimentaciones (Relacion N:N)
IF OBJECT_ID ('SCF.TrabajadoresAlimentaciones', 'U') IS NOT NULL 
   drop table SCF.TrabajadoresAlimentaciones;
go
create table SCF.TrabajadoresAlimentaciones
(
	Cedula					char(11)		not null,
	FH_Alimentaciones		smalldatetime		not null,
	CONSTRAINT PK_Cedula_FH_Alimentaciones_TrabajadoresAlimentaciones
		PRIMARY KEY (Cedula, FH_Alimentaciones),
	CONSTRAINT FK_Cedula_TrabajadoresAlimentaciones
		FOREIGN KEY (Cedula) REFERENCES SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_FH_Alimentaciones_TrabajadoresAlimentaciones
		FOREIGN KEY (FH_Alimentaciones) REFERENCES SCF.Alimentaciones(FechaHora) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TrabajadoresAlimentaciones
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de la tabla TrabajadoresPastoreos (Relacion N:N)
IF OBJECT_ID ('SCF.TrabajadoresPastoreos', 'U') IS NOT NULL 
   drop table SCF.TrabajadoresPastoreos;
go
create table SCF.TrabajadoresPastoreos
(
	Cedula				char(11)		not null,
	NumeroLote			int				not null,
	CONSTRAINT PK_Cedula_NumeroLote_TrabajadoresPastoreos
		PRIMARY KEY (Cedula, NumeroLote),
	CONSTRAINT FK_Cedula_TrabajadoresPastoreos
		FOREIGN KEY (Cedula) REFERENCES SCF.Trabajadores(Cedula) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT FK_NumeroLote_TrabajadoresPastoreos
		FOREIGN KEY (NumeroLote) REFERENCES SCF.Pastoreos(NumeroLote) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT CHK_Cedula_TrabajadoresPastoreos
        check (Cedula like  '[0-9]-[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')
);
go

-- Creación de tabla Prints, que se utiliza para mostrar información desde la pagina web que se desarrolló 
create table SCF.Prints
(
    Dato    varchar(900)    null
);
go