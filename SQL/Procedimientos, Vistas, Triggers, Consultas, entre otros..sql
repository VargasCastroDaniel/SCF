/*
	Bases de Datos I	
	Proyecto II
	Creado por:
		Daniel Vargas Castro
		Harold Ramírez Mora
		Armando Villalta Pérez
*/;

use SistemaControlFinca;
go

/*
------------------------------------------------------------------------
	Inserciones
------------------------------------------------------------------------
*/;

-- Creación de un procedimiento para insertar en la tabla Trabajadores(Entidad);
create or alter procedure SCF.ins_Trabajadores 
    @Cedula char(11), @Nombre varchar(30), 
    @Apellido1 varchar(30), @Apellido2 varchar(30), 
    @Telefono char(9)
as
if @Cedula not in (select Cedula from SCF.Trabajadores)
	begin
		declare
			@error bit;
		set @error='False';
		begin transaction 
			print 'Insertado en la tabla de SCF.Trabajadores';
			insert SCF.Trabajadores (Cedula,Nombre,Apellido1,Apellido2)
			values (@Cedula,@Nombre,@Apellido1,@Apellido2);
			if @@ERROR>0 
			begin
				print ('Error registrando el trabajador');
				set @error='True';
			end
			insert into SCF.TelefonosTrabajadores (Cedula,Telefono) 
			values (@Cedula,@Telefono);
		
			if @@ERROR>0 
			begin
				print ('Error registrando el telefono');
				set @error='True';
			end
			if @error='True'
				begin
					Rollback transaction;
				end
			else
				begin
					Commit transaction;
				end
		end
else
	print ('Cedula Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Reses(Entidad);
create or alter procedure SCF.ins_Reses 
	@IdRes int, @Fierro char(3), @Genero char(1), @Raza char(10)
as
if @IdRes not in (select IdRes from SCF.Reses)
	begin
	    begin transaction; 
			print ('Insertado en la tabla de SCF.Reses')
			if @Fierro = '' and @Raza = '' and @Genero = ''
				insert SCF.Reses(IdRes)
				values (@IdRes);
			else
			if @Fierro = '' and @Genero = ''
				insert SCF.Reses(IdRes, Raza)
				values (@IdRes, @Raza);
			else
			if @Raza = '' and @Genero = ''
				insert SCF.Reses(IdRes,Fierro)
				values (@IdRes, @Fierro);
			else
			if @Fierro = '' and @Raza = ''
				insert SCF.Reses(IdRes, Genero)
				values (@IdRes, @Genero);
			else
			if @Fierro = ''
				insert SCF.Reses(IdRes,Raza, Genero)
				values (@IdRes, @Raza, @Genero);
			else
			if @Raza = ''
				insert SCF.Reses(IdRes,Fierro, Genero)
				values (@IdRes, @Fierro, @Genero);
			else
			if @Genero = ''
				insert SCF.Reses(IdRes,Fierro,Raza)
				values (@IdRes, @Fierro,@Raza);
			else
				insert SCF.Reses(IdRes,Fierro,Genero,Raza)
				values (@IdRes, @Fierro, @Genero, @Raza);
		if @@ERROR>0 
			begin
				print ('Error registrando la Res')
				rollback;
			end
		else
			commit;
	end
else
	print ('Id Repetido')
go

-- Creación de un procedimiento para insertar en la tabla Ventas(Entidad);
create or alter procedure SCF.ins_Ventas 
    @Fecha date, @TotalLitros int
as
if @Fecha not in (select Fecha from SCF.Ventas)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Ventas';
			insert SCF.Ventas (Fecha,TotalLitros)
			values (@Fecha,@TotalLitros);
		if @@ERROR>0 
			begin
				print ('Error registrando la Venta')
				rollback;
			end
		else
			commit;
	end
else
	print ('Fecha Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Ordeños(Entidad);
create or alter procedure SCF.ins_Ordeños
	@FechaHora smalldatetime, @LitrosLeche int
as
if @FechaHora not in (select FechaHora from SCF.Ordeños)
	begin
		begin transaction
			print 'Insertado en la tabla de SCF.Ordeños';
			insert SCF.Ordeños(FechaHora,LitrosLeche)
			values (@FechaHora, @LitrosLeche);
		if @@ERROR>0 
			begin
				print ('Error registrando el Ordeño')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Ovulaciones(Entidad);
create or alter procedure SCF.ins_Ovulaciones 
	@FechaHora smalldatetime, @Descripcion varchar(30) 
as
if @FechaHora not in (select FechaHora from SCF.Ovulaciones)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Ovulaciones';
			insert SCF.Ovulaciones(FechaHora,Descripcion)
			values (@FechaHora,@Descripcion);
		if @@ERROR>0 
			begin
				print ('Error registrando la Ovulacion')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Gestaciones(Entidad);
create or alter procedure SCF.ins_Gestaciones 
	@FechaHoraPreñez smalldatetime, @RazaPadrote char(10) 
as
if @FechaHoraPreñez not in (select FechaHoraPreñez from SCF.Gestaciones)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Gestaciones';
			if @RazaPadrote = ''
				insert SCF.Gestaciones(FechaHoraPreñez)
				values (@FechaHoraPreñez);
			else
				insert SCF.Gestaciones(FechaHoraPreñez, RazaPadrote)
				values (@FechaHoraPreñez, @RazaPadrote);
		if @@ERROR>0 
			begin
				print ('Error registrando la Gestacion')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHoraPreñez Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Pastoreos(Entidad);
create or alter procedure SCF.ins_Pastoreos 
    @NumeroLote int, @CantidadReses int, 
    @FechaHoraInicio smalldatetime, @FechaHoraFinal smalldatetime
as
if @NumeroLote not in (select NumeroLote from SCF.Pastoreos)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Pastoreos';
			insert SCF.Pastoreos (NumeroLote,CantidadReses,FechaHoraInicio,FechaHoraFinal)
			values (@NumeroLote,@CantidadReses,@FechaHoraInicio,@FechaHoraFinal);
		if @@ERROR>0 
			begin
				print ('Error registrando el Pastoreo')
				rollback;
			end
		else
			commit;
	end
else
	print ('NumeroLote Repetido')
go

-- Creación de un procedimiento para insertar en la tabla Alimentaciones(Entidad);
create or alter procedure SCF.ins_Alimentaciones
    @FechaHora smalldatetime, @Tipo varchar(20), @Descripcion varchar(300)
as
if @FechaHora not in (select FechaHora from SCF.Alimentaciones)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Alimentaciones';
			if @Tipo = ''
				insert SCF.Alimentaciones (FechaHora, Descripcion)
				values (@FechaHora, @Descripcion);
			else
				insert SCF.Alimentaciones (FechaHora, Tipo, Descripcion)
				values (@FechaHora, @Tipo, @Descripcion);
		if @@ERROR>0 
			begin
				print ('Error registrando la Alimentacion')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Repetida')
go

-- Creación de un procedimiento para insertar en la tabla Medicamentos(Entidad);
create or alter procedure SCF.ins_Medicamentos 
	@Nombre varchar(30), @CantidadDisponible int, @FechaExpiracion date, @Descripcion varchar(300)
as
if @Nombre not in (select Nombre from SCF.Medicamentos)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Medicamentos';
			insert SCF.Medicamentos(Nombre, CantidadDisponible, FechaExpiracion, Descripcion)
			values (@Nombre, @CantidadDisponible, @FechaExpiracion, @Descripcion);
		if @@ERROR>0 
			begin
				print ('Error registrando el Medicamento')
				rollback;
			end
		else
			commit;
	end
else
	print ('Nombre Repetido')
go

-- Creación de un procedimiento para insertar en la tabla Vacunaciones(Entidad);
create or alter procedure SCF.ins_Vacunaciones 
    @FechaHora smalldatetime
as
if @FechaHora not in (select FechaHora from SCF.Vacunaciones)
	begin
		begin transaction 
			print 'Insertado en la tabla de SCF.Vacunaciones';
			insert SCF.Vacunaciones (FechaHora)
			values (@FechaHora);
		if @@ERROR>0 
			begin
				print ('Error registrando la Vacunacion')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Repetida')
go

-- Creación de un procedimiento para insertar en la tabla VentasOrdeños(Relacion N:N);
create or alter procedure SCF.ins_VentasOrdeños
	@FechaHora smalldatetime, @FechaVenta date
as 
	if (@FechaHora in (select FechaHora from SCF.Ordeños) and @FechaVenta in (select Fecha from  SCF.Ventas))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.VentasOrdeños';
				insert SCF.VentasOrdeños (FechaHora, FechaVenta)
				values (@FechaHora, @FechaVenta);
				if @@ERROR>0 
			begin
				print ('Error registrando Venta-Ordeño')
				rollback;
			end
		else
			commit;
	end
else
	print ('La venta o el ordeño no existen')
go

-- Creación de un procedimiento para insertar en la tabla ResesPastoreos(Relacion N:N);
create or alter procedure SCF.ins_ResesPastoreos
	@IdRes int, @NumeroLote int
as 
	if (@IdRes in (select IdRes from SCF.Reses) and @NumeroLote in (select NumeroLote from  SCF.Pastoreos))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesPastoreos';
				insert SCF.ResesPastoreos(IdRes, NumeroLote)
				values (@IdRes, @NumeroLote);
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Pastoreos')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o el numero de lote no existe')
go

-- Creación de un procedimiento para insertar en la tabla ResesOvulaciones(Relacion N:N);
create or alter procedure SCF.ins_ResesOvulaciones
	@IdRes int, @FechaHora smalldatetime
as 
	if (@IdRes in (select IdRes from SCF.Reses) and @FechaHora in (select FechaHora from  SCF.Ovulaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesOvulaciones';
				insert SCF.ResesOvulaciones(IdRes, FechaHora)
				values (@IdRes, @FechaHora);
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Ovulaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o La fecha de la ovulacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla ResesGestaciones(Relacion N:N);
create or alter procedure SCF.ins_ResesGestaciones
	@IdRes int, @FechaHoraPreñez smalldatetime
as 
	if (@IdRes in (select IdRes from SCF.Reses) and @FechaHoraPreñez in (select FechaHoraPreñez from  SCF.Gestaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesGestaciones';
				insert SCF.ResesGestaciones(IdRes, FechaHoraPreñez)
				values (@IdRes, @FechaHoraPreñez);
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Gestaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o La fecha de la gestacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla ResesOrdeños(Relacion N:N);
create or alter procedure SCF.ins_ResesOrdeños
	@IdRes int, @FechaHora smalldatetime
as 
	if (@IdRes in (select IdRes from SCF.Reses) and @FechaHora  in (select FechaHora  from  SCF.Ordeños))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesOrdeños';
				insert SCF.ResesOrdeños(IdRes, FechaHora )
				values (@IdRes, @FechaHora );
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Ordeños')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o La fecha del ordeño no existe')
go

-- Creación de un procedimiento para insertar en la tabla VacunacionesMedicamentos(Relacion N:N);
create or alter procedure SCF.ins_VacunacionesMedicamentos
	@Nombre varchar(30), @FechaHora smalldatetime, @Dosis char(6)
as 
	if (@Nombre in (select Nombre from SCF.Medicamentos) and @FechaHora  in (select FechaHora  from  SCF.Vacunaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.VacunacionesMedicamentos';
				insert SCF.VacunacionesMedicamentos(Nombre, FechaHora, Dosis )
				values (@Nombre, @FechaHora, @Dosis );
				if @@ERROR>0 
			begin
				print ('Error registrando Vacunaciones-Medicamentos')
				rollback;
			end
		else
			commit;
	end
else
	print ('El nombre del medicamento o la fecha de la vacuna no existe')
go

-- Creación de un procedimiento para insertar en la tabla ResesAlimentaciones(Relacion N:N);
create or alter procedure SCF.ins_ResesAlimentaciones
	 @IdRes int, @FechaHora smalldatetime
as 
	if (@FechaHora in (select FechaHora from SCF.Alimentaciones) and @IdRes  in (select IdRes  from  SCF.Reses))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesAlimentaciones';
				insert SCF.ResesAlimentaciones(IdRes, FechaHora )
				values (@IdRes, @FechaHora);
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Alimentaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o la fecha de la alimentacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla ResesVacunaciones(Relacion N:N);
create or alter procedure SCF.ins_ResesVacunaciones
	 @IdRes int, @FechaHora smalldatetime
as 
	if (@FechaHora in (select FechaHora from SCF.Vacunaciones) and @IdRes  in (select IdRes  from  SCF.Reses))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.ResesVacunaciones';
				insert SCF.ResesVacunaciones(IdRes, FechaHora )
				values (@IdRes, @FechaHora);
				if @@ERROR>0 
			begin
				print ('Error registrando Reses-Vacunaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('El Id de la res o la fecha de la vacunacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla TrabajadoresOvulaciones(Relacion N:N);
create or alter procedure SCF.ins_TrabajadoresOvulaciones
	@Cedula char(11), @FH_Ovulaciones smalldatetime
as 
	if (@Cedula in (select Cedula from SCF.Trabajadores) and @FH_Ovulaciones  in (select FechaHora  from  SCF.Ovulaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.TrabajadoresOvulaciones';
				insert SCF.TrabajadoresOvulaciones(Cedula, FH_Ovulaciones)
				values (@Cedula, @FH_Ovulaciones);
				if @@ERROR>0 
			begin
				print ('Error registrando Trabajadores-Ovulaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('La cedula del trabajador o la fecha de la ovulacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla TrabajadoresOrdeños(Relacion N:N);
create or alter procedure SCF.ins_TrabajadoresOrdeños
	@Cedula char(11), @FH_Ordeños smalldatetime
as 
	if (@Cedula in (select Cedula from SCF.Trabajadores) and @FH_Ordeños  in (select FechaHora  from  SCF.Ordeños))
		begin
			begin transaction 
				print 'Insertando en la tabla de SCF.TrabajadoresOrdeños';
				insert SCF.TrabajadoresOrdeños(Cedula, FH_Ordeños)
				values (@Cedula, @FH_Ordeños);
				if @@ERROR>0 
			begin
				print ('Error registrando Trabajadores-Ordeños')
				rollback;
			end
		else
			commit;
	end
else
	print ('La cedula del trabajador o la fecha del ordeño no existe')
go

-- Creación de un procedimiento para insertar en la tabla TrabajadoresVacunaciones(Relacion N:N);
create or alter procedure SCF.ins_TrabajadoresVacunaciones
	@Cedula char(11), @FH_Vacunaciones smalldatetime
as 
	if (@Cedula in (select Cedula from SCF.Trabajadores) and @FH_Vacunaciones  in (select FechaHora  from  SCF.Vacunaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.TrabajadoresVacunaciones';
				insert SCF.TrabajadoresVacunaciones(Cedula, FH_Vacunaciones)
				values (@Cedula, @FH_Vacunaciones);
				if @@ERROR>0 
			begin
				print ('Error registrando Trabajadores-Vacunaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('La cedula del trabajador o la fecha de la vacunacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla TrabajadoresAlimentaciones(Relacion N:N);
create or alter procedure SCF.ins_TrabajadoresAlimentaciones
	@Cedula char(11), @FH_Alimentaciones smalldatetime
as 
	if (@Cedula in (select Cedula from SCF.Trabajadores) and @FH_Alimentaciones in (select FechaHora  from  SCF.Alimentaciones))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.TrabajadoresAlimentaciones';
				insert SCF.TrabajadoresAlimentaciones(Cedula, FH_Alimentaciones)
				values (@Cedula, @FH_Alimentaciones);
				if @@ERROR>0 
			begin
				print ('Error registrando Trabajadores-Alimentaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('La cedula del trabajador o la fecha de la alimentacion no existe')
go

-- Creación de un procedimiento para insertar en la tabla TrabajadoresPastoreos(Relacion N:N);
create or alter procedure SCF.ins_TrabajadoresPastoreos
	@Cedula char(11), @NumeroLote int
as 
	if (@Cedula in (select Cedula from SCF.Trabajadores) and @NumeroLote in (select NumeroLote from SCF.Pastoreos))
		begin
			begin transaction 
				print 'Insertado en la tabla de SCF.TrabajadoresPastoreos';
				insert SCF.TrabajadoresPastoreos(Cedula, NumeroLote)
				values (@Cedula, @NumeroLote);
				if @@ERROR>0 
			begin
				print ('Error registrando Trabajadores-Pastoreos')
				rollback;
			end
		else
			commit;
	end
else
	print ('La cedula del trabajador o el numero de lote no existe')
go

/*
------------------------------------------------------------------------
	Eliminaciones
------------------------------------------------------------------------
*/;

-- Creación de un procedimiento para eliminar de la tabla Trabajadores(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Trabajadores 
    @cedula char(11)
as
declare
    @error int
if @cedula in (select cedula from SCF.Trabajadores)
begin
    set @error=0
    begin tran
        delete from SCF.TelefonosTrabajadores
        where cedula=@cedula;

        if @@error>0 
        begin 
            print ('Error eliminando telefonos de Trabajador')
            set @error=1
        end

        delete from SCF.Trabajadores
        where cedula=@cedula;

        if @@error>0 
        begin 
            print ('Error eliminando Trabajador')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('Trabajador inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Reses(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Reses 
	@IdRes int
as
if @IdRes in (select IdRes from SCF.Reses)
	begin
		begin tran
			delete from  SCF.Reses
			where IdRes=@IdRes;

			if @@error>0 
				begin 
					print ('Error eliminando la res')
					Rollback tran
				end
			else
				begin
					Commit tran
				end
	end
else
	print('Res inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Pastoreos(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Pastoreos 
	@NumeroLote int
as
if @NumeroLote in (select NumeroLote from SCF.Pastoreos)
	begin
		begin tran
			delete from  SCF.Pastoreos
			where NumeroLote=@NumeroLote;

			if @@error>0 
				begin 
					print ('Error eliminando el pastoreo')
					Rollback tran
				end
			else
				begin
					Commit tran
				end
	end
else
	print ('Pastoreo inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Ovulaciones(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Ovulaciones 
	@FechaHora smalldatetime
as
if @FechaHora in (select FechaHora from SCF.Ovulaciones)
	begin
		begin tran
			delete from  SCF.Ovulaciones
			where FechaHora=@FechaHora;

			if @@error>0 
				begin 
					print ('Error eliminando la ovulacion')
					Rollback tran
				end
			else
				begin
					Commit tran
				end
	end
else
	print('Ovulacion inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Ventas(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Ventas 
	@Fecha date
as
if @Fecha in (select Fecha from SCF.Ventas)
	begin
		begin tran
			delete from  SCF.Ventas
			where Fecha=@Fecha;

			if @@error>0 
				begin 
					print ('Error eliminando la venta')
					Rollback tran
				end
			else
				begin
					Commit tran
				end
	end
else
	print('Venta inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Vacunaciones(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Vacunaciones
     @FechaHora smalldatetime
as
declare
    @error int
if @FechaHora in (select FechaHora from SCF.Vacunaciones)
begin
    set @error=0
    begin tran
        delete from SCF.Vacunaciones
        where FechaHora=@FechaHora;

        if @@error>0 
        begin 
            print ('Error eliminando Vacunacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('Vacunacion inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Medicamentos(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Medicamentos 
    @Nombre varchar(30)
as
declare
    @error int
if @Nombre in (select Nombre from SCF.Medicamentos)
begin
    set @error=0
    begin tran
        delete from SCF.Medicamentos 
        where Nombre=@Nombre;

        if @@error>0 
        begin 
            print ('Error eliminando medicamento')
			set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end
else
	print('Medicamento inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Ordeños(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Ordeños
     @FechaHora smalldatetime
as
declare
    @error int
if @FechaHora in (select FechaHora from SCF.Ordeños)
begin
    set @error=0
    begin tran
        delete from SCF.Ordeños
        where FechaHora=@FechaHora;

        if @@error>0 
        begin 
            print ('Error eliminando Ordeño')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('Ordeño inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Gestaciones(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Gestaciones
     @FechaHoraPreñez smalldatetime
as
declare
    @error int
if @FechaHoraPreñez in (select FechaHoraPreñez from SCF.Gestaciones)
begin
    set @error=0
    begin tran
        delete from SCF.Gestaciones
        where FechaHoraPreñez=@FechaHoraPreñez;

        if @@error>0 
        begin 
            print ('Error eliminando Gestacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('Gestacion inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla Alimentaciones(Entidad), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_Alimentaciones
     @FechaHora smalldatetime
as
declare
    @error int
if @FechaHora in (select FechaHora from SCF.Alimentaciones)
begin
    set @error=0
    begin tran
        delete from SCF.Alimentaciones
        where FechaHora=@FechaHora;

        if @@error>0 
        begin 
            print ('Error eliminando Alimentacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else
	print('Alimentaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla VentasOrdeños(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_VentasOrdeños
	@FechaHora smalldatetime, @FechaVenta date

as
if (@FechaVenta in (select FechaVenta from SCF.VentasOrdeños) and @FechaHora in (select FechaHora from SCF.VentasOrdeños))
	begin
		begin tran
			delete from  SCF.VentasOrdeños
			where FechaHora=@FechaHora and FechaVenta = @FechaVenta;

			if @@error>0 
				begin 
					print ('Error eliminando la venta-ordeño')
					Rollback tran
				end
			else
				begin
					Commit tran
				end
	end
else 
	print('VentaOrdeño inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesOvulaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesOvulaciones
	@IdRes int, @FechaHora smalldatetime
as
if (@IdRes in (select IdRes from SCF.ResesOvulaciones) and @FechaHora in (select FechaHora from SCF.ResesOvulaciones))
begin
	begin tran
		delete from  SCF.ResesOvulaciones
		where FechaHora=@FechaHora and IdRes = @IdRes;

		if @@error>0 
			begin 
				print ('Error eliminando la res-ovulacion')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else 
	print('ResesOvulaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesOrdeños(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesOrdeños
	@IdRes int, @FechaHora smalldatetime
as
if (@IdRes in (select IdRes from SCF.ResesOrdeños) and @FechaHora in (select FechaHora from SCF.ResesOrdeños))
begin
	begin tran
		delete from  SCF.ResesOrdeños
		where FechaHora=@FechaHora and IdRes = @IdRes;

		if @@error>0 
			begin 
				print ('Error eliminando la res-ordeño')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else 
	print('ResesOrdeños inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesAlimentaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesAlimentaciones
	@IdRes int, @FechaHora smalldatetime 
as
if (@IdRes in (select IdRes from SCF.ResesAlimentaciones) and @FechaHora in (select FechaHora from SCF.ResesAlimentaciones))
begin
	begin tran
		delete from  SCF.ResesAlimentaciones
		where FechaHora=@FechaHora and IdRes = @IdRes;

		if @@error>0 
			begin 
				print ('Error eliminando la res-alimentacion')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else
	print('ResesAlimentaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla TrabajadoresOrdeños(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_TrabajadoresOrdeños
	@Cedula char(11), @FH_Ordeños smalldatetime
as
if (@Cedula in (select Cedula from SCF.TrabajadoresOrdeños) and @FH_Ordeños in (select FH_Ordeños from SCF.TrabajadoresOrdeños))
begin
	begin tran
		delete from  SCF.TrabajadoresOrdeños
		where Cedula=@Cedula and FH_Ordeños = @FH_Ordeños;

		if @@error>0 
			begin 
				print ('Error eliminando la trabajador-ordeño')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else 
	print('TrabajadoresOrdeños inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla TrabajadoresVacunaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_TrabajadoresVacunaciones
	@Cedula char(11), @FH_Vacunaciones smalldatetime
as
if (@Cedula in (select Cedula from SCF.TrabajadoresVacunaciones) and @FH_Vacunaciones in (select FH_Vacunaciones from SCF.TrabajadoresVacunaciones))
begin
	begin tran
		delete from  SCF.TrabajadoresVacunaciones
		where Cedula=@Cedula and FH_Vacunaciones = @FH_Vacunaciones;

		if @@error>0 
			begin 
				print ('Error eliminando la trabajador-vacunacion')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else 
	print('TrabajadoresVacunaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla TrabajadoresPastoreos(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_TrabajadoresPastoreos
	@Cedula char(11), @NumeroLote int
as
if (@Cedula in (select Cedula from SCF.TrabajadoresPastoreos) and @NumeroLote in (select NumeroLote from SCF.TrabajadoresPastoreos))
begin
	begin tran
		delete from  SCF.TrabajadoresPastoreos
		where Cedula=@Cedula and NumeroLote = @NumeroLote;

		if @@error>0 
			begin 
				print ('Error eliminando la trabajador-pastoreo')
				Rollback tran
			end
		else
			begin
				Commit tran
			end
end
else
	print('TrabajadoresPastoreos inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla TrabajadoresOvulaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_TrabajadoresOvulaciones
    @Cedula char(11), @FH_Ovulaciones smalldatetime
as
declare
    @error int
if (@Cedula in (select Cedula from SCF.TrabajadoresOvulaciones) and @FH_Ovulaciones in (select FH_Ovulaciones from SCF.TrabajadoresOvulaciones))
begin
    set @error=0
    begin tran
        delete from SCF.TrabajadoresOvulaciones 
        where Cedula=@Cedula and FH_Ovulaciones=@FH_Ovulaciones;

        if @@error>0 
        begin 
            print ('Error eliminando Trabajador-Ovulacion')
			set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('TrabajadoresOvulaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesPastoreos(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesPastoreos
     @IdRes int, @NumeroLote int
as
declare
    @error int
if (@IdRes in (select IdRes from SCF.ResesPastoreos) and @NumeroLote in (select NumeroLote from SCF.ResesPastoreos))
begin
    set @error=0
    begin tran
        delete from SCF.ResesPastoreos
        where IdRes=@IdRes and NumeroLote=@NumeroLote;

        if @@error>0 
        begin 
            print ('Error eliminando ResPatoreo')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('ResesPastoreos inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesGestaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesGestaciones
     @IdRes int, @FechaHoraPreñez smalldatetime
as
declare
    @error int
if (@IdRes in (select IdRes from SCF.ResesGestaciones) and @FechaHoraPreñez in (select FechaHoraPreñez from SCF.ResesGestaciones))
begin
    set @error=0
    begin tran
        delete from SCF.ResesGestaciones
        where IdRes=@IdRes and FechaHoraPreñez=@FechaHoraPreñez;

        if @@error>0 
        begin 
            print ('Error eliminando ResGestacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('ResesGestaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla VacunacionesMedicamentos(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_VacunacionesMedicamentos
     @Nombre varchar(30), @FechaHora smalldatetime
as
declare
    @error int
if (@Nombre in (select Nombre from SCF.VacunacionesMedicamentos) and @FechaHora in (select FechaHora from SCF.VacunacionesMedicamentos))
begin
    set @error=0
    begin tran
        delete from SCF.VacunacionesMedicamentos
        where Nombre=@Nombre and FechaHora=@FechaHora;

        if @@error>0 
        begin 
            print ('Error eliminando VacunacionMedicamento')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else 
	print('VacunacionesMedicamentos inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla ResesVacunaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_ResesVacunaciones
     @IdRes int, @FechaHora smalldatetime
as
declare
    @error int
if (@IdRes in (select IdRes from SCF.ResesVacunaciones) and @FechaHora in (select FechaHora from SCF.ResesVacunaciones))
begin
    set @error=0
    begin tran
        delete from SCF.ResesVacunaciones
        where FechaHora=@FechaHora and IdRes=@IdRes;

        if @@error>0 
        begin 
            print ('Error eliminando ResVacunacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else
	print('ResesVacunaciones inexistente')
go

-- Creación de un procedimiento para eliminar de la tabla TrabajadoresAlimentaciones(Relacion N:N), recibiendo la clave primaria de la tabla,
-- para conocer cual fila eliminar y realizar la eliminacion con exito.;
create or alter procedure SCF.del_TrabajadoresAlimentaciones
     @Cedula char(11), @FH_Alimentaciones smalldatetime
as
declare
    @error int
if (@Cedula in (select Cedula from SCF.TrabajadoresAlimentaciones) and @FH_Alimentaciones in (select FH_Alimentaciones from SCF.TrabajadoresAlimentaciones))
begin
    set @error=0
    begin tran
        delete from SCF.TrabajadoresAlimentaciones
        where Cedula=@Cedula and FH_Alimentaciones=@FH_Alimentaciones;

        if @@error>0 
        begin 
            print ('Error eliminando TrabajadorAlimentacion')
            set @error=2
        end

        if @error>0 
        begin 
            Rollback tran
        end
        else
        begin
            Commit tran
        end
end;
else
	print('TrabajadoresAlimentaciones inexistente')
go

/*
----------------------------------------------------------------------------------------------------
	Modificaciones (updates)
----------------------------------------------------------------------------------------------------
*/;

-- Creación de un procedimiento para modificar la tabla Trabajadores(Entidad), recibiendo la cedula(clave primaria) de un trabajador
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Trabajadores 
    @Cedula char(11), @CedulaNueva char(11), @Nombre varchar(30), 
    @Apellido1 varchar(30), @Apellido2 varchar(30), 
    @Telefono char(9)
as
if @Cedula in (select Cedula from SCF.Trabajadores)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Trabajadores';
			update SCF.TelefonosTrabajadores
			set Cedula=@CedulaNueva,
				Telefono=@Telefono
			where Cedula=@Cedula
			update SCF.Trabajadores
			set Cedula=@CedulaNueva,
				Nombre=@Nombre,
				Apellido1=@Apellido1,
				Apellido2=@Apellido2
			where Cedula=@Cedula;
		if @@ERROR>0 
			begin
				print ('Error modificando Trabajadores')
				rollback;
			end
		else
			commit;
	end
else
	print ('Cedula Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Pastoreos(Entidad), recibiendo el numero(clave primaria) de un lote
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Pastoreos
    @NumeroLote int, @NumeroLoteNuevo int, @CantidadReses int, 
    @FechaHoraInicio smalldatetime, @FechaHoraFinal smalldatetime
as
if @NumeroLote in (select NumeroLote from SCF.Pastoreos)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Pastoreos';
			update SCF.Pastoreos
			set NumeroLote=@NumeroLoteNuevo,
				CantidadReses=@CantidadReses,
				FechaHoraInicio=@FechaHoraInicio,
				FechaHoraFinal=@FechaHoraFinal
			where NumeroLote=@NumeroLote;
		if @@ERROR>0 
			begin
				print ('Error modificando Pastoreos')
				rollback;
			end
		else
			commit;
	end
else
	print ('NumeroLote Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Vacunaciones(Entidad), recibiendo la fechahora(clave primaria) de una vacunacion
-- para conocer la fila que se desea modificar y ademas se recibe una nueva fechahora para sustituirla por la antigua (este es el unico atributo de esta entidad).;
create or alter procedure SCF.upd_Vacunaciones
    @FechaHora smalldatetime, @FechaHoraNueva smalldatetime
as
if @FechaHora in (select FechaHora from SCF.Vacunaciones)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Vacunaciones';
			update SCF.Vacunaciones
			set FechaHora=@FechaHoraNueva
			where FechaHora=@FechaHora;
		if @@ERROR>0 
			begin
				print ('Error modificando Vacunaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Reses(Entidad), recibiendo el Id(clave primaria) de una res
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Reses
    @IdRes int, @IdResNuevo int, @Fierro char(3), @Genero char(1), @Raza char(10)
as
if @IdRes in (select IdRes from SCF.Reses)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Reses';
			if @Fierro = '' and @Raza = '' and @Genero = ''
				update SCF.Reses
				set IdRes=@IdResNuevo
				where IdRes=@IdRes;
			else
			if @Fierro = '' and @Genero = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Raza=@Raza
				where IdRes=@IdRes;
			else
			if @Raza = '' and @Genero = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Fierro=@Fierro
				where IdRes=@IdRes;
			else
			if @Fierro = '' and @Raza = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Genero=@Genero
				where IdRes=@IdRes;
			else
			if @Fierro = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Genero=@Genero,
					Raza=@Raza
				where IdRes=@IdRes;
			else
			if @Raza = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Fierro=@Fierro,
					Genero=@Genero
				where IdRes=@IdRes;
			else
			if @Genero = ''
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Fierro=@Fierro,
					Raza=@Raza
				where IdRes=@IdRes;
			else
				update SCF.Reses
				set IdRes=@IdResNuevo,
					Fierro=@Fierro,
					Genero=@Genero,
					Raza=@Raza
				where IdRes=@IdRes;
		if @@ERROR>0 
			begin
				print ('Error modificando Reses')
				rollback;
			end
		else
			commit;
	end
else
	print ('IdRes Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Ordeños(Entidad), recibiendo la fechahora(clave primaria) de una ordeño
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Ordeños
    @FechaHora smalldatetime, @FechaHoraNueva smalldatetime, @LitrosLeche int
as
if @FechaHora in (select FechaHora from SCF.Ordeños)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Ordeños';
			
			update SCF.Ordeños
			set FechaHora=@FechaHoraNueva,
				LitrosLeche=@LitrosLeche
			where FechaHora=@FechaHora;

		if @@ERROR>0 
			begin
				print ('Error modificando Ordeños')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Ovulaciones(Entidad), recibiendo la fechahora(clave primaria) de una ovulacion
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Ovulaciones
    @FechaHora smalldatetime, @FechaHoraNueva smalldatetime, @Descripcion varchar(300)
as
if @FechaHora in (select FechaHora from SCF.Ovulaciones)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Ovulaciones';
			update SCF.Ovulaciones
			set FechaHora=@FechaHoraNueva,
				Descripcion=@Descripcion
			where FechaHora=@FechaHora;
		if @@ERROR>0 
			begin
				print ('Error modificando Ovulaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Gestaciones(Entidad), recibiendo la fechahorapreñez(clave primaria) de una gestacion
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Gestaciones
    @FechaHoraPreñez smalldatetime, @FechaHoraPreñezNueva smalldatetime, @RazaPadrote char(10)
as
if @FechaHoraPreñez in (select FechaHoraPreñez from SCF.Gestaciones)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Gestaciones';
			if @RazaPadrote = ''
				update SCF.Gestaciones
				set FechaHoraPreñez=@FechaHoraPreñezNueva
				where FechaHoraPreñez=@FechaHoraPreñez;
			else
				update SCF.Gestaciones
				set FechaHoraPreñez=@FechaHoraPreñezNueva,
					RazaPadrote=@RazaPadrote
				where FechaHoraPreñez=@FechaHoraPreñez;
		if @@ERROR>0 
			begin
				print ('Error modificando Gestaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Medicamentos(Entidad), recibiendo el nombre(clave primaria) de un medicamento
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Medicamentos
    @Nombre varchar(30),@NombreNuevo varchar(30), @CantidadDisponible int,
	@FechaExpiracion date, @Descripcion varchar(300)
as
if @Nombre in (select Nombre from SCF.Medicamentos)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Medicamentos';
			update SCF.Medicamentos
			set Nombre=@NombreNuevo,
				CantidadDisponible=@CantidadDisponible,
				FechaExpiracion=@FechaExpiracion,
				Descripcion=@Descripcion
			where Nombre=@Nombre;
		if @@ERROR>0 
			begin
				print ('Error modificando Medicamentos')
				rollback;
			end
		else
			commit;
	end
else
	print ('Nombre Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Ventas(Entidad), recibiendo la fecha(clave primaria) de una venta
-- para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Ventas
    @Fecha date, @FechaNueva date, @TotalLitros int
as
if @Fecha in (select Fecha from SCF.Ventas)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Ventas';
			
			update SCF.Ventas
			set Fecha=@FechaNueva,
				TotalLitros=@TotalLitros
			where Fecha=@Fecha;
		if @@ERROR>0 
			begin
				print ('Error modificando Ventas')
				rollback;
			end
		else
			commit;
	end
else
	print ('Fecha Inexistente')
go

-- Creación de un procedimiento para modificar la tabla Alimentaciones(Entidad), recibiendo la fechahora(clave primaria) de una 
-- alimentacion para conocer la fila que se desea modificar y ademas se reciben los nuevos valores para sustituirlos por los antiguos.;
create or alter procedure SCF.upd_Alimentaciones
    @FechaHora smalldatetime, @FechaHoraNueva smalldatetime, @Tipo varchar(20),
	@Descripcion varchar(300)
as
if @FechaHora in (select FechaHora from SCF.Alimentaciones)
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.Alimentaciones';
			if @Tipo = ''
				update SCF.Alimentaciones
				set FechaHora=@FechaHoraNueva,
					Descripcion=@Descripcion
				where FechaHora=@FechaHora;
			else
				update SCF.Alimentaciones
				set FechaHora=@FechaHoraNueva,
					Tipo=@Tipo,
					Descripcion=@Descripcion
				where FechaHora=@FechaHora;
		if @@ERROR>0 
			begin
				print ('Error modificando Alimentaciones')
				rollback;
			end
		else
			commit;
	end
else
	print ('FechaHora Inexistente')
go

-- Creación de un procedimiento para modificar la tabla VacunacionesMedicamentos(Relacion N:N), recibiendo el nombre del medicamento, 
-- la fechahora de la vacunacion y la dosis(este es atributo que se modificara en la tabla).;
create or alter procedure SCF.upd_VacunacionesMedicamentos
    @Nombre char(30), @FechaHora smalldatetime, @Dosis char(7)
as
if (@FechaHora in (select FechaHora from SCF.VacunacionesMedicamentos) and
	@Nombre in (select Nombre from SCF.VacunacionesMedicamentos))
	begin
		begin transaction
			print 'Modificando en la tabla de SCF.VacunacionesMedicamentos';
			
			update SCF.VacunacionesMedicamentos
			set Dosis=@Dosis
			where FechaHora=@FechaHora and Nombre=@Nombre;
		if @@ERROR>0 
			begin
				print ('Error modificando VacunacionMedicamento')
				rollback;
			end
		else
			commit;
	end
else
	print ('Relacion VacunacionMedicamento Inexistente')
go

/*
----------------------------------------------------------------------------------------------------
	Consultas
----------------------------------------------------------------------------------------------------
*/;

-- Creación de un procedimiento para consultar la tabla Trabajadores(Entidad), recibiendo la cedula de un trabajador.
-- Se muestran todos los atributos de esta entidad(tabla), incluyendo el numero de telefono.;
create or alter procedure SCF.sel_Trabajadores
	@Cedula char(11)
as
if @Cedula in (select Cedula from SCF.Trabajadores)
begin
	select T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombreCompleto], T.Cedula, TT.Telefono
	from  SCF.Trabajadores as T inner join SCF.TelefonosTrabajadores TT on (T.Cedula=TT.Cedula)
	where	(T.Cedula=@Cedula and TT.Cedula = @Cedula)

end;
else
	print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Reses(Entidad), recibiendo el Id de una res.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Reses
	@IdRes int
as
if @IdRes in (select IdRes from SCF.Reses)
begin
	select R.IdRes as [IddelaRes], R.Fierro, R.Genero, R.Raza
	from  SCF.Reses as R
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Ventas(Entidad), recibiendo la fecha de una venta.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Ventas
	 @Fecha date
as
if  @Fecha in (select Fecha from SCF.Ventas)
begin
	select cast(V.Fecha as char) as [Fecha], V.TotalLitros as [TotaldeLitros]
	from  SCF.Ventas as V
	where	(Fecha = @Fecha)
end;
else
	print ('Venta Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Ordeños(Entidad), recibiendo la fechahora de una ordeño.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Ordeños
	 @FechaHora smalldatetime
as
if  @FechaHora in (select FechaHora from SCF.Ordeños)
begin
	select cast(O.FechaHora as char) as [FechayHoradelordeño], O.LitrosLeche as [Litrosdeleche]
	from  SCF.Ordeños as O
	where	(FechaHora = @FechaHora)
end;
else
	print ('Ordeño Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Ovulaciones(Entidad), recibiendo la fechahora de una ovulacion.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Ovulaciones
	 @FechaHora smalldatetime
as
if  @FechaHora in (select FechaHora from SCF.Ovulaciones)
begin
	select cast(Ov.FechaHora as char) as [FechayHora], Ov.Descripcion
	from  SCF.Ovulaciones as Ov
	where	(FechaHora = @FechaHora)
end;
else
	print ('Ovulacion Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Gestaciones(Entidad), recibiendo la fechahorapreñez de una gestacion.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Gestaciones
	 @FechaHora smalldatetime
as
if  @FechaHora in (select FechaHoraPreñez from SCF.Gestaciones)
begin
	select cast(G.FechaHoraPreñez as char) as [FechayHora], G.RazaPadrote as [Razadelpadrote]
	from  SCF.Gestaciones as G
	where	(FechaHoraPreñez = @FechaHora)
end;
else
	print ('Gestacion Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Pastoreos(Entidad), recibiendo el numero de lote de un pastoreo.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Pastoreos
	 @NumeroLote int 
as
if  @NumeroLote in (select NumeroLote from SCF.Pastoreos)
begin
	select p.NumeroLote as [Numerodelote],p.CantidadReses as [CantidaddeReses],
	cast(p.FechaHoraInicio as char) as [FechayHoradeinicio], cast(p.FechaHoraFinal as char) as [FechayHoradefinalizacion]
	from  SCF.Pastoreos as p
	where	(NumeroLote = @NumeroLote)
end;
else
	print ('Numero de lote Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Alimentaciones(Entidad), recibiendo la fechahora de una alimentacion.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Alimentaciones
	 @FechaHora smalldatetime
as
if  @FechaHora in (select FechaHora from SCF.Alimentaciones)
begin
	select cast(a.FechaHora as char) as [FechayHora], a.Tipo, a.Descripcion
	from  SCF.Alimentaciones as a
	where	(FechaHora = @FechaHora)
end;
else
	print ('Alimentacion Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Medicamentos(Entidad), recibiendo el nombre de un medicamento.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Medicamentos
	 @Nombre char(30)
as
if  @Nombre in (select Nombre from SCF.Medicamentos)
begin
	select m.Nombre, m.CantidadDisponible as [Cantidaddisponible], cast(m.FechaExpiracion as char) as [Fechadeexpiracion], m.Descripcion
	from  SCF.Medicamentos as m
	where	(Nombre = @Nombre)
end;
else
	print ('Medicamento Inexistente')
go

-- Creación de un procedimiento para consultar la tabla Vacunaciones(Entidad), recibiendo la fechahora de una vacunacion.
-- Se muestran todos los atributos de esta entidad(tabla).;
create or alter procedure SCF.sel_Vacunaciones
	 @FechaHora smalldatetime
as
if  @FechaHora in (select FechaHora from SCF.Vacunaciones)
begin
	select cast(va.FechaHora as char) as [FechayHora]
	from  SCF.Vacunaciones as va
	where	(FechaHora = @FechaHora)
end;
else
	print ('Vacunacion Inexistente')
go

-- Creación de un procedimiento para consultar la tabla VentasOrdeños(Relacion N:N), recibiendo la fecha de una venta.
-- Se muestra la fecha de la venta y tambien las fechas de los ordeños que esten relacionados a esa venta.;
create or alter procedure SCF.sel_VentasOrdeños
	 @Fecha date
as
if  @Fecha in (select FechaVenta from SCF.VentasOrdeños)
begin
	select cast(vo.FechaVenta as char) as [Fechadelaventa], cast(vo.FechaHora as char) as [FechayHoradelordeño]
	from  SCF.VentasOrdeños as vo
	where	(@Fecha = FechaVenta)
end;
else
	print ('Venta Inexistente')
go

-- Creación de un procedimiento para consultar la tabla TrabajadoresOrdeños(Relacion N:N), recibiendo la cedula de un trabajador.
-- Se muestra el nombre completo y la cedula del trabajador, tambien se muestra la fechahora de ordeños que ha realizado el trabajador.;
create or alter procedure SCF.sel_TrabajadoresOrdeños
	@Cedula char(11)
as
if @Cedula in (select Cedula from SCF.TrabajadoresOrdeños)
begin
	select  T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombredelTrabajador], T_O.Cedula, cast(T_O.FH_Ordeños as char) as [Fechadelordeño]
	from  SCF.TrabajadoresOrdeños as T_O inner join SCF.Trabajadores T on (T_O.Cedula=T.Cedula)
	where	(T.Cedula=@Cedula and T.Cedula = @Cedula)
end;
else
	print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla TrabajadoresOvulaciones(Relacion N:N), recibiendo la cedula de un trabajador.
-- Se muestra el nombre completo y la cedula del trabajador, tambien se muestra la fechahora de ovulaciones que ha realizado el trabajador.;
create or alter procedure SCF.sel_TrabajadoresOvulaciones
    @Cedula char(11)
as
if @Cedula in (select Cedula from SCF.TrabajadoresOvulaciones)
begin
    select  T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombredelTrabajador], T_O.Cedula, cast(T_O.FH_Ovulaciones as char) as [Fechaovulacion]
    from  SCF.TrabajadoresOvulaciones as T_O inner join SCF.Trabajadores T on (T_O.Cedula=T.Cedula)
    where    (T.Cedula=@Cedula and T.Cedula = @Cedula)
end;
else
    print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla TrabajadoresVacunaciones(Relacion N:N), recibiendo la cedula de un trabajador.
-- Se muestra el nombre completo y la cedula del trabajador, tambien se muestra la fechahora de vacunaciones que ha realizado el trabajador.;
create or alter procedure SCF.sel_TrabajadoresVacunaciones
    @Cedula char(11)
as
if @Cedula in (select Cedula from SCF.TrabajadoresVacunaciones)
begin
    select  T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombredelTrabajador], T_V.Cedula, cast(T_V.FH_Vacunaciones as char) as [Fechadelavacunacion]
    from  SCF.TrabajadoresVacunaciones as T_V inner join SCF.Trabajadores T on (T_V.Cedula=T.Cedula)
    where    (T.Cedula=@Cedula and T.Cedula = @Cedula)
end;
else
    print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla TrabajadoresAlimentaciones(Relacion N:N), recibiendo la cedula de un trabajador.
-- Se muestra el nombre completo y la cedula del trabajador, tambien se muestra la fechahora de alimentaciones que ha realizado el trabajador.;
create or alter procedure SCF.sel_TrabajadoresAlimentaciones
    @Cedula char(11)
as
if @Cedula in (select Cedula from SCF.TrabajadoresAlimentaciones)
begin
    select  T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombredelTrabajador], T_A.Cedula, cast(T_A.FH_Alimentaciones as char) as [Fechadelaalimentacion]
    from  SCF.TrabajadoresAlimentaciones as T_A inner join SCF.Trabajadores T on (T_A.Cedula=T.Cedula)
    where    (T.Cedula=@Cedula and T.Cedula = @Cedula)
end;
else
    print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla TrabajadoresPastoreos(Relacion N:N), recibiendo la cedula de un trabajador.
-- Se muestra el nombre completo y la cedula del trabajador, tambien se muestra el numero de lote y la cantidad de reses de los pastoreos
-- que ha realizado el trabajador.;
create or alter procedure SCF.sel_TrabajadoresPastoreos
    @Cedula char(11)
as
if @Cedula in (select Cedula from SCF.TrabajadoresPastoreos)
begin
    select  T.Apellido1+' '+T.Apellido2+' '+T.Nombre as [NombredelTrabajador], T_P.Cedula, T_P.NumeroLote as [Numerodelote], P.CantidadReses as [CantidaddeReses]
    from  SCF.TrabajadoresPastoreos as T_P inner join SCF.Trabajadores T on (T_P.Cedula=T.Cedula) inner join SCF.Pastoreos P on (T_P.NumeroLote = P.NumeroLote) 
    where    (T.Cedula=@Cedula and T.Cedula = @Cedula)
end;
else
    print ('Trabajador Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesPastoreos(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y el numero de lote donde la res ha estado pastando.;
create or alter procedure SCF.sel_ResesPastoreos
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesPastoreos)
begin
	select RP.IdRes as [IddelaRes], RP.NumeroLote as [Numerodelote]
	from  SCF.ResesPastoreos as RP
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesOvulaciones(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y la fechahora de revisiones de los ovulos de la res (palpado rutinario).;
create or alter procedure SCF.sel_ResesOvulaciones
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesOvulaciones)
begin
	select RO.IdRes as [IddelaRes], cast(RO.FechaHora as char) as [FechayHoradelaovulacion], O.Descripcion
	from  SCF.ResesOvulaciones as RO inner join SCF.Ovulaciones O on (Ro.FechaHora = O.FechaHora)
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesGestaciones(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y la fechahora de la preñez de las gestaciones que ha tenido la res.;
create or alter procedure SCF.sel_ResesGestaciones
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesGestaciones)
begin
	select RG.IdRes as [IddelaRes], cast(RG.FechaHoraPreñez as char) as [FechayHoradelapreñez]
	from  SCF.ResesGestaciones as RG
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesOrdeños(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y la fechahora de ordeños realizados a esa res.;
create or alter procedure SCF.sel_ResesOrdeños
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesOrdeños)
begin
	select RO.IdRes as [IddelaRes], cast(RO.FechaHora as char) as [FechayHoradelordeño]
	from  SCF.ResesOrdeños as RO
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesAlimentaciones(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y la fechahora de alimentaciones dadas a esa res.;
create or alter procedure SCF.sel_ResesAlimentaciones
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesAlimentaciones)
begin
	select RA.IdRes as [IddelaRes], cast(RA.FechaHora as char) as [FechayHoradelaalimentacion]
	from  SCF.ResesAlimentaciones as RA
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla ResesVacunaciones(Relacion N:N), recibiendo el Id de una res.
-- Se muestra el Id de la res y la fechahora de vacunaciones realizadas a esa res.;
create or alter procedure SCF.sel_ResesVacunaciones
	@IdRes int
as
if @IdRes in (select IdRes from SCF.ResesVacunaciones)
begin
	select RV.IdRes as [IddelaRes], cast(RV.FechaHora as char) as [FechayHoradelavacunacion]
	from  SCF.ResesVacunaciones as RV
	where	(IdRes = @IdRes)
end;
else
	print ('Res Inexistente')
go

-- Creación de un procedimiento para consultar la tabla VacunacionesMedicamentos(Relacion N:N), recibiendo el nombre de un Medicamento.
-- Se muestra el nombre del medicamento, la fechahora de vacunaciones realizadas con ese medicamento y tambien la dosis 
-- aplicada en cada vacunacion.;
create or alter procedure SCF.sel_VacunacionesMedicamentos
	@Nombre varchar(30)
as
if @Nombre in (select Nombre from SCF.VacunacionesMedicamentos)
begin
	select VM.Nombre as [Nombre], cast(VM.FechaHora as char) as [FechayHoradelavacunacion], VM.Dosis
	from  SCF.VacunacionesMedicamentos as VM
	where	(Nombre = @Nombre)
end;
else
	print ('Medicamento Inexistente')
go

/*
----------------------------------------------------------------------------------------------------
    Tipos de datos
----------------------------------------------------------------------------------------------------
*/;

-- Declaracion de diferentes tipos de datos para algunas tablas.;
exec sp_addtype TCedula, 'char(11)', 'not null'
go
exec sp_addtype TIdRes, 'int', 'not null'
go
exec sp_addtype TGenero, 'char(1)', 'not null'
go
exec sp_addtype TtotalLitros, 'int', 'not null'
go
exec sp_addtype TTelefono, 'char(9)', 'not null'
go

-- Alteracion de las tablas para asignar los tipos de datos previamente creados.;
alter table SCF.Trabajadores alter column Cedula TCedula;
go
alter table SCF.Reses alter column IdRes TIdRes;
go
alter table SCF.Reses alter column Genero TGenero;
go
alter table SCF.Ventas alter column TotalLitros TtotalLitros;
go
alter table SCF.TelefonosTrabajadores alter column Telefono TTelefono;
go

/*
----------------------------------------------------------------------------------------------------
	Vistas
----------------------------------------------------------------------------------------------------
*/;

-- Creación de un view para la tabla Reses, que muestra el id de las reses, asi como los numeros de lotes en los que las 
-- reses han pastado, y tambien se muestran la fechahora, tipo y descricion de las alimentaciones que ha tenido la res.;
create or alter view SCF.view_Reses
as
    select RA.IdRes as [Iddelares], A.Tipo, cast(A.FechaHora as char) as [FechaHora], A.Descripcion
    from  SCF.ResesAlimentaciones RA 
	inner join SCF.Alimentaciones A on (RA.FechaHora = A.FechaHora)
go

-- Creación de un view para la tabla Trabajadores, que muestra el nombre completo de los trabajadores y su numero de cedula,
-- tambien se muestran todas las fechas en las cuales el trabajador ha realizado ordeños y los Ids de las reses que se ordeñaron
-- en dichos ordeños.;
create or alter view SCF.view_Trabajadores
as
    select T.Apellido1+' '+ T.Apellido2+' '+ T.Nombre as [NombreCompleto], T.Cedula, 
	cast(T_O.FH_Ordeños as char) as [FechaHora],
	RO.IdRes as [Iddelares]
    from  SCF.Trabajadores T  
	inner join SCF.TrabajadoresOrdeños T_O on (T.Cedula = T_O.Cedula) 
	inner join SCF.ResesOrdeños RO on (T_O.FH_Ordeños = RO.FechaHora)
go

-- Creación de un view para la tabla Medicamentos, que muestra todos los medicamentos existentes, fechas en las cuales
-- fueron aplicados en alguna vacunacion, dosis aplicada en la vacunacion y tambien muestra las reses a las que se les aplico.;
create or alter view SCF.view_Medicamentos
as
    select M.Nombre as [Nombredelmedicamento], cast(V_M.FechaHora as char) as [Fechadeaplicacion], V_M.Dosis as [Dosisaplicada], R_V.IdRes as [Iddelares]
    from  SCF.Medicamentos M inner join SCF.VacunacionesMedicamentos V_M on (M.Nombre = V_M.Nombre) 
	inner join SCF.Vacunaciones V on (V_M.FechaHora = V.FechaHora)
	inner join SCF.ResesVacunaciones R_V on (V.FechaHora = R_V.FechaHora)
go

/*
----------------------------------------------------------------------------------------------------
	Triggers
----------------------------------------------------------------------------------------------------
*/;

-- Creación de un trigger en la tabla Trabajadores, que actua luego de realizar una insercion, mostrando un breve mensaje;
create or alter trigger TR_Trabajadores 
on SCF.Trabajadores after insert
as 
begin 
	print 'La operacion se realizó exitosamente'
end
go

-- Creación de un trigger en la tabla Reses, que actua luego de realizar una insercion, mostrando un breve mensaje;
create or alter trigger TR_Reses 
on SCF.Reses after insert
as 
begin 
	print 'La operacion se realizó exitosamente'
end
go

-- Creación de un trigger en la tabla Medicamentos, que actua luego de realizar una insercion, mostrando un breve mensaje;
create or alter trigger TR_Medicamentos 
on SCF.Medicamentos after insert
as 
begin 
	print 'La operacion se realizó exitosamente'
end
go

/*
----------------------------------------------------------------------------------------------------
	Cursores implementados en procedimientos (5 consultas con grado avanzado de procesamiento)
----------------------------------------------------------------------------------------------------
*/;

/*
	Consulta 1, esta consulta recibe una cedula de un trabajador y un rango de fechas,  
	y muestra todos los ordeños en el que participó el trabajador en esas fechas y 
	tambien se mustran los IdRed de todas las reses que fueron ordeñadas en cada uno
	de los ordeños.
*/;
create or alter procedure SCF.Consulta1
    @Cedula char(11), @FechaI smalldatetime, @FechaF smalldatetime
as
delete from SCF.Prints
DECLARE @FechaT smalldatetime
DECLARE TrabajadorInfo CURSOR FOR SELECT FH_Ordeños FROM SCF.TrabajadoresOrdeños where Cedula=@Cedula and (FH_Ordeños >= @FechaI and FH_Ordeños <= @FechaF) 
OPEN TrabajadorInfo
DECLARE @Nombre as varchar(200)
set @Nombre = (select Apellido1+' '+Apellido2+' '+Nombre from SCF.Trabajadores where Cedula=@Cedula)
insert into SCF.Prints (Dato) values ('El trabajador: '+@Nombre+', del '+cast(@FechaI as varchar)+' al '+cast(@FechaF as varchar)+' participó en los siguientes ordeños:')
FETCH NEXT FROM TrabajadorInfo into @FechaT
WHILE @@fetch_status = 0
BEGIN
    DECLARE @IdVaca int , @Vacas as varchar(300)
    set @Vacas = ''
    DECLARE VacasInfo CURSOR FOR SELECT IdRes FROM SCF.ResesOrdeños where FechaHora=@FechaT
    OPEN VacasInfo
    FETCH NEXT FROM VacasInfo into @IdVaca
    WHILE @@fetch_status = 0
    BEGIN
        set @Vacas = @Vacas+ cast(@IdVaca as varchar)+ ', '
        FETCH NEXT FROM VacasInfo into @IdVaca
    END
    insert into SCF.Prints (Dato) values('        '+cast(@FechaT as varchar)+' se ordeñaron las reses con el ID: '+LEFT(@Vacas, LEN(@Vacas) - 1))
    CLOSE VacasInfo
    DEALLOCATE VacasInfo
    FETCH NEXT FROM TrabajadorInfo INTO @FechaT
END
CLOSE TrabajadorInfo
DEALLOCATE TrabajadorInfo
go

/*
	Consulta 2, esta consulta recibe un rango de fechas y muestra todas las vacunaciones
	realizadas entre esas fechas, ademas muestra el nombre y la dosis del medicamento que
	fue aplicado en la vacunacion.
*/;

create or alter procedure SCF.Consulta2
    @FechaI smalldatetime, @FechaF smalldatetime
as
delete from SCF.Prints
DECLARE @FechaV smalldatetime
DECLARE VacunacionInfo CURSOR FOR SELECT FechaHora FROM SCF.Vacunaciones where (FechaHora >= @FechaI and FechaHora <= @FechaF) 
OPEN VacunacionInfo
insert into SCF.Prints (Dato) values ('Del '+cast(@FechaI as varchar)+' al '+cast(@FechaF as varchar)+' se realizaron las siguientes vacunaciones:')
FETCH NEXT FROM VacunacionInfo into @FechaV
WHILE @@fetch_status = 0
BEGIN
    insert into SCF.Prints (Dato) values('        '+cast(@FechaV as varchar)+' se vacuno el medicamento: '+(select Nombre from VacunacionesMedicamentos where FechaHora = @FechaV)+
	' con una dosis de: '+(select Dosis from VacunacionesMedicamentos where FechaHora = @FechaV))
    FETCH NEXT FROM VacunacionInfo INTO @FechaV
END
CLOSE VacunacionInfo
DEALLOCATE VacunacionInfo
go

/*
	Consulta 3, esta consulta recibe una cedula y mustra el nombre del trabajador, 
	tambian muestra todas las alimentaciones que ha realizado ese trabajador y la 
	informacion de esas alimentaciones(fecha, tipo, descipcion).
*/;

create or alter procedure SCF.Consulta3
    @Cedula char(11)
as
delete from SCF.Prints
DECLARE @FechaA smalldatetime
DECLARE TrabajadorInfo CURSOR FOR SELECT FH_Alimentaciones FROM SCF.TrabajadoresAlimentaciones where Cedula=@Cedula
OPEN TrabajadorInfo
DECLARE @Nombre as varchar(200)
set @Nombre = (select Apellido1+' '+Apellido2+' '+Nombre from SCF.Trabajadores where Cedula=@Cedula)
insert into SCF.Prints (Dato) values ('El trabajador: '+@Nombre+', ha realizado las siguientes alimentaciones:')
FETCH NEXT FROM TrabajadorInfo into @FechaA
WHILE @@fetch_status = 0
BEGIN
    insert into SCF.Prints (Dato) values('        El '+CAST(@FechaA as varchar)+' se realizo una alimentacion de: '+
	(SELECT Tipo FROM SCF.Alimentaciones where @FechaA=FechaHora)+', con la descripcion: '+(SELECT Descripcion FROM SCF.Alimentaciones where @FechaA=FechaHora))
    FETCH NEXT FROM TrabajadorInfo INTO @FechaA
END
CLOSE TrabajadorInfo
DEALLOCATE TrabajadorInfo
go

/*
	Consulta 4, esta consulta recibe una Id de una res y un rango de fechas,  
	y muestra todos los ordeños que se le realizaron a la res en esas fechas y 
	tambien se mustran las cedulas de todos los trabajadores que participaron
	en cada ordeño.
*/;
create or alter procedure SCF.Consulta4
    @IdRes int, @FechaI smalldatetime, @FechaF smalldatetime
as
delete from SCF.Prints
DECLARE @FechaO smalldatetime
DECLARE ResInfo CURSOR FOR SELECT FechaHora FROM SCF.ResesOrdeños where IdRes=@IdRes and (FechaHora >= @FechaI and FechaHora <= @FechaF) 
OPEN ResInfo
insert into SCF.Prints (Dato) values ('La res: '+cast(@IdRes as varchar)+', del '+cast(@FechaI as varchar)+' al '+cast(@FechaF as varchar)+' se le realizaron los siguientes ordeños:')
FETCH NEXT FROM ResInfo into @FechaO
WHILE @@fetch_status = 0
BEGIN
    DECLARE @Cedula char(11) , @Trabajadores as varchar(300)
    set @Trabajadores = ''
    DECLARE TrabInfo CURSOR FOR SELECT Cedula FROM SCF.TrabajadoresOrdeños where FH_Ordeños=@FechaO
    OPEN TrabInfo
    FETCH NEXT FROM TrabInfo into @Cedula
    WHILE @@fetch_status = 0
    BEGIN
        set @Trabajadores = @Trabajadores+ cast(@Cedula as varchar)+ ', '
        FETCH NEXT FROM TrabInfo into @Cedula
    END
    insert into SCF.Prints (Dato) values('        '+cast(@FechaO as varchar)+', los trabajadores que ordeñaron fueron los de la cedula: '+LEFT(@Trabajadores, LEN(@Trabajadores) - 1))
    CLOSE TrabInfo
    DEALLOCATE TrabInfo
    FETCH NEXT FROM ResInfo INTO @FechaO
END
CLOSE ResInfo
DEALLOCATE ResInfo
go

/*
	Consulta 5, no recibe ningun parametro y muestra el total de litros de leche vendidos
	desde que se hizo la primer venta hasta la ultima que se ha realizado.
*/;
create or alter procedure SCF.Consulta5
as
delete from SCF.Prints
DECLARE @Litros int, @TotalLitros int
set @TotalLitros = 0
DECLARE Ventas CURSOR FOR SELECT TotalLitros FROM SCF.Ventas
OPEN Ventas
FETCH NEXT FROM Ventas into @Litros
WHILE @@fetch_status = 0
BEGIN
	set @TotalLitros = @TotalLitros + @Litros
    FETCH NEXT FROM Ventas INTO @Litros
END
insert into SCF.Prints (Dato) values ('El total de litros de leche vendidos a lo largo de todo el tiempo son '+cast(@TotalLitros as varchar)+' Litros')
CLOSE Ventas
DEALLOCATE Ventas
go

/*
----------------------------------------------------------------------------------------------------
	Indices
----------------------------------------------------------------------------------------------------
*/;

-- Creación de un indice en la tabla Medicamentos, basado en el atributo: CantidadDisponible;
create nonclustered index IDX_Medicamentos 
on SCF.Medicamentos (CantidadDisponible)
go

-- Creación de un indice en la tabla Trabajadores, basado en el atributo: Apellido1;
create nonclustered index IDX_Trabajadores
on SCF.Trabajadores (Apellido1)
go

-- Creación de un indice en la tabla Alimentaciones, basado en el atributo: Tipo;
create nonclustered index IDX_Alimentaciones
on SCF.Alimentaciones (Tipo)
go

select * from SCF.ResesAlimentaciones