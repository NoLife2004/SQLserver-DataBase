CREATE DATABASE NexTrip_Adventure

CREATE TABLE Role (
	id_role				varchar(10) PRIMARY KEY,
	nama_role			varchar (50)
);

CREATE TABLE Staff (
	id_staff			varchar(10) PRIMARY KEY,
	id_role				varchar(10) NOT NULL,
	nama_staff			varchar(50) NOT NULL,
	email				varchar(25) NOT NULL,
	no_telp				varchar(13) NOT NULL,
	username			varchar(25) NOT NULL,
	password			varchar(25) NOT NULL
	FOREIGN KEY (id_role) REFERENCES Role(id_role)
);
drop table Staff
select * from Staff

ALTER TABLE Staff
ALTER COLUMN email varchar(50);

CREATE TABLE Customer (
	id_customer			varchar(10) PRIMARY KEY,
	nama_customer		varchar(50) NOT NULL,
	gender				varchar(15) NOT NULL,
	alamat				varchar(50) NOT NULL,
	no_telp				varchar(13) NOT NULL,
);
drop table Customer

CREATE TABLE UnitTravel (
	id_unit				varchar(10) PRIMARY KEY,
	no_polisi			varchar(10) NOT NULL,
	status_unit			varchar(15) NOT NULL,
	jenis_unit			varchar(25) NOT NULL,
	merk_unit			varchar(20) NOT NULL,
	kapasitas			int			NOT NULL
);
DROP TABLE UnitTravel

CREATE TABLE Paket_Trip (
	id_paket			varchar(10) PRIMARY KEY,
	nama_paket			varchar(50) NOT NULL,
	deskripsi_paket		varchar(100) NOT NULL
);
DROP TABLE Paket_Trip

CREATE TABLE Jadwal_Trip (
	id_jadwalTrip		varchar(10) PRIMARY KEY,
	id_staff			varchar(10) NOT NULL,
	id_paket			varchar(10) NOT NULL,
	id_unit				varchar(10) NOT NULL,
	tanggal_berangkat	date NOT NULL,
	waktu_berangkat		varchar(25) NOT NULL,
	tanggal_pulang		date NOT NULL,
	waktu_pulang		varchar(25) NOT NULL,
	status_jadwal		varchar(15) NOT NULL,
	kapasitas			int NOT NULL,
	harga				money NOT NULL
	FOREIGN KEY (id_paket) REFERENCES Paket_Trip(id_paket),
	FOREIGN KEY (id_unit) REFERENCES UnitTravel(id_unit),
	FOREIGN KEY (id_staff) REFERENCES Staff(id_staff)
);
DROP TABLE Jadwal_Trip

CREATE TABLE Jadwal_Bus (
	id_jadwalBus		varchar(10) PRIMARY KEY,
	id_unit				varchar(10) NOT NULL,
	id_staff			varchar(10) NOT NULL,
	tanggal_berangkat	date NOT NULL,
	waktu_berangkat		varchar(25) NOT NULL,
	waktu_tiba			varchar(25) NOT NULL,
	destinasi			varchar(50) NOT NULL,
	harga				money NOT NULL,
	kapasitas			int NOT NULL
	FOREIGN KEY (id_unit) REFERENCES UnitTravel(id_unit),
	FOREIGN KEY (id_staff) REFERENCES Staff(id_staff)
);
DROP TABLE Jadwal_Bus

CREATE TABLE Pemesanan_TiketBus (
	id_pemesananTiket	varchar(10) PRIMARY KEY,
	id_jadwalBus		varchar(10) NOT NULL,
	id_staff			varchar(10) NOT NULL,
	harga				money NOT NULL,
	total_harga			money NOT NULL,
	tanggal_pemesanan	datetime NOT NULL,
	FOREIGN KEY (id_jadwalBus) REFERENCES Jadwal_Bus(id_jadwalBus),
	FOREIGN KEY (id_staff) REFERENCES Staff(id_staff)
);
drop table Pemesanan_TiketBus

CREATE TABLE Pemesanan_Trip (
	id_pemesananTrip	varchar(10) PRIMARY KEY,
	id_jadwalTrip		varchar(10) NOT NULL,
	id_customer			varchar(10) NOT NULL,
	id_staff			varchar(10) NOT NULL,
	jumlah_tiket		int NOT NULL,
	harga				money NOT NULL,
	total_harga			money NOT NULL,
	tanggal_pemesanan   datetime NOT NULL,
	FOREIGN KEY (id_jadwalTrip) REFERENCES Jadwal_Trip(id_jadwalTrip),
	FOREIGN KEY (id_customer) REFERENCES Customer(id_customer),
	FOREIGN KEY (id_staff) REFERENCES Staff(id_staff)
);
drop table Pemesanan_Trip

CREATE TABLE DetailPemesananTiketBus (
	id_pemesananTiket	varchar(10) NOT NULL,
	id_customer			varchar(10) NOT NULL,
	jumlah_tiket		int			NOT NULL
	PRIMARY KEY (id_pemesananTiket, id_customer),
    FOREIGN KEY (id_pemesananTiket) REFERENCES Pemesanan_TiketBus(id_pemesananTiket),
    FOREIGN KEY (id_customer) REFERENCES Customer(id_customer)
);

CREATE TABLE DaftarPenumpang (
	id_penumpang		varchar(10) PRIMARY KEY,
	id_pemesananTiket	varchar(10) NOT NULL,
	nama				varchar(50) NOT NULL,
	alamat				varchar(50) NOT NULL,
	no_telp				varchar(13) NOT NULL,
	data_wali			varchar(50) NOT NULL
	FOREIGN KEY (id_pemesananTiket) REFERENCES Pemesanan_TiketBus(id_pemesananTiket)
);
drop table DaftarPenumpang


-----------------------------------------------------------------------------------------------------------------------------
-- SP

--INSERT, UPDATE, DELETE STAFF
-- insert Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputStaff
	@id_staff			varchar(10),
	@id_role			varchar(10),
	@nama_staff			varchar(50),
	@email				varchar(25),
	@no_telp			varchar(13),
	@username			varchar(25),
	@password			varchar(25)
AS
BEGIN
	INSERT INTO Staff
	VALUES(@id_staff, @id_role, @nama_staff, @email, @no_telp, @username, @password)
END

-- update Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateStaff
	@id_staff			varchar(10),
	@id_role			varchar(10),
	@nama_staff			varchar(50),
	@email				varchar(25),
	@no_telp			varchar(13)
AS
BEGIN
	UPDATE Staff SET	
	id_role				= @id_role,
	nama_staff			= @nama_staff,	
	email				= @email,	
	no_telp				= @no_telp
	WHERE id_staff	= @id_staff
END

-- delete Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteStaff
	@id_staff varchar(10)
AS
BEGIN
	DELETE FROM Staff WHERE id_staff = @id_staff
END


--INSERT, UPDATE, DELETE UNIT
-- insert Unit
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputUnit
	@id_unit				varchar(10),
	@no_polisi				varchar(10),
	@status_unit			varchar(15),
	@jenis_unit				varchar(25),
	@merk_unit				varchar(20)
AS
BEGIN
	INSERT INTO Unit
	VALUES(@id_unit, @no_polisi, @status_unit, @jenis_unit, @merk_unit)
END

-- update Unit
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateUnit
	@id_unit				varchar(10),
	@no_polisi				varchar(10),
	@status_unit			varchar(15),
	@jenis_unit				varchar(25),
	@merk_unit				varchar(20),
	@kapasitas				int
AS
BEGIN
	UPDATE Unit SET	
	no_polisi			= @no_polisi,	
	status_unit			= @status_unit,	
	jenis_unit			= @jenis_unit,
	merk_unit			= @merk_unit,
	kapasitas			= @kapasitas
	WHERE id_unit		= @id_unit
END

-- delete 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteUnit
	@id_unit varchar(10)
AS
BEGIN
	DELETE FROM Unit WHERE id_unit = @id_unit
END

--INSERT, UPDATE, DELETE PAKET
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputPaket
	@id_paket			varchar(10),
	@nama_paket			varchar(50),
	@deskripsi_paket	varchar(100)
AS
BEGIN
	INSERT INTO Paket_Trip
	VALUES(@id_paket, @nama_paket, @deskripsi_paket)
END

-- update 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdatePaket
	@id_paket			varchar(10),
	@nama_paket			varchar(50),
	@deskripsi_paket	varchar(100)
AS
BEGIN
	UPDATE Paket_Trip SET	
	nama_paket			= @nama_paket,
	deskripsi_paket		= @deskripsi_paket
	WHERE id_paket		= @id_paket
END

-- delete 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeletePaket
	@id_paket varchar(10)
AS
BEGIN
	DELETE FROM Paket_Trip WHERE id_paket = @id_paket
END

--INSERT, UPDATE, DELETE Jadwal Trip
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputJadwal_Trip
	@id_jadwalTrip		varchar(10),
	@id_staff			varchar(10),
	@id_paket			varchar(10),
	@id_unit			varchar(10),
	@tanggal_berangkat	date,
	@waktu_berangkat	varchar(10),
	@tanggal_pulang		date,
	@waktu_pulang		varchar(10),
	@status_jadwal		varchar(15),
	@kapasitas			int,
	@harga				money
AS
BEGIN
	INSERT INTO Jadwal_Trip
	VALUES(@id_jadwalTrip, @id_staff, @id_paket, @id_unit, @tanggal_berangkat, @waktu_berangkat, @tanggal_pulang, @waktu_pulang, @status_jadwal, @kapasitas, @harga)
END

-- update
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateJadwal_Trip
	@id_jadwalTrip		varchar(10),
	@id_staff			varchar(10),
	@id_paket			varchar(10),
	@id_unit			varchar(10),
	@tanggal_berangkat	date,
	@waktu_berangkat	varchar(10),
	@tanggal_pulang		date,
	@waktu_pulang		varchar(10),
	@status_jadwal		varchar(15),
	@kapasitas			int,
	@harga				money
AS
BEGIN
	UPDATE Jadwal_Trip SET	
	id_staff			= @id_staff,	
	id_paket			= @id_paket,	
	id_unit				= @id_unit,
	tanggal_berangkat	= @tanggal_berangkat,
	waktu_berangkat		= @waktu_berangkat,
	tanggal_pulang		= @tanggal_pulang,
	waktu_pulang		= @waktu_pulang,
	status_jadwal		= @status_jadwal,
	kapasitas			= @kapasitas,
	harga				= @harga
	WHERE id_jadwalTrip		= @id_jadwalTrip
END

-- delete Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteJadwal_Trip
	@id_jadwalTrip varchar(10)
AS
BEGIN
	DELETE FROM Jadwal_Trip WHERE id_jadwalTrip = @id_jadwalTrip
END

--INSERT, UPDATE, DELETE JADWAL BUS
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputJadwal_Bus
	@id_jadwalBus		varchar(10),
	@id_unit			varchar(10),
	@id_staff			varchar(10),
	@tanggal_berangkat	date,
	@waktu_berangkat	varchar(25),
	@waktu_tiba			varchar(25),
	@destinasi			varchar(50),
	@harga				money,
	@kapasitas			int
AS
BEGIN
	INSERT INTO Jadwal_Bus
	VALUES(@id_jadwalBus, @id_unit, @id_staff, @tanggal_berangkat, @waktu_berangkat, @waktu_tiba, @destinasi,  @harga, @kapasitas)
END

-- update
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateJadwalBus
	@id_jadwalBus		varchar(10),
	@id_unit			varchar(10),
	@id_staff			varchar(10),
	@tanggal_berangkat	date,
	@waktu_berangkat	varchar(10),
	@waktu_tiba			varchar(10),
	@destinasi			varchar(50),
	@harga				money,
	@kapasitas			int
AS
BEGIN
	UPDATE Jadwal_Bus SET	
	id_unit			= @id_unit,
	id_staff			= @id_staff,	
	tanggal_berangkat		= @tanggal_berangkat,	
	waktu_berangkat	= @waktu_berangkat,
	waktu_tiba			= @waktu_tiba,
	destinasi			= @destinasi,
	harga				= @harga,
	kapasitas			= @kapasitas
	WHERE id_jadwalBus		= @id_jadwalBus
END

-- delete Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteJadwalBus
	@id_jadwalBus varchar(10)
AS
BEGIN
	DELETE FROM Jadwal_Bus WHERE id_jadwalBus = @id_jadwalBus
END

--INSERT, UPDATE, DELETE Customer 
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputCustomer
	@id_customer			varchar(10),
	@nama_customer		varchar(50),
	@gender				varchar(15),
	@alamat				varchar(50),
	@no_telp				varchar(13)
AS
BEGIN
	INSERT INTO Customer
	VALUES(@id_customer, @nama_customer, @gender, @alamat, @no_telp)
END

-- update Unit
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateCustomer
	@id_customer		varchar(10),
	@nama_customer		varchar(50),
	@gender				varchar(15),
	@alamat				varchar(50),
	@no_telp			varchar(13)
AS
BEGIN
	UPDATE Customer SET	
	nama_customer		= @nama_customer,
	gender				= @gender,	
	alamat				= @alamat,	
	no_telp				= @no_telp
	WHERE id_customer		= @id_customer
END

-- delete Staff
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteCustomer
	@id_customer varchar(10)
AS
BEGIN
	DELETE FROM Customer WHERE id_customer = @id_customer
END

-- INSERT, UPDATE, DELETE ROLE
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputRole
	@id_role				varchar(10),
	@nama_role			varchar (50)
AS
BEGIN
	INSERT INTO Role
	VALUES(@id_role, @nama_role)
END

-- update 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateRole
	@id_role			varchar(10),
	@nama_role			varchar (50)
AS
BEGIN
	UPDATE Role SET	
	nama_role			= @nama_role	
	WHERE id_role		= @id_role
END

-- delete
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteRole
	@id_role varchar(10)
AS
BEGIN
	DELETE FROM Role WHERE id_role = @id_role
END

-- INSERT, UPDATE, DELETE Detail Pemesanan tiket bus
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputDetail
	@id_pemesananTiket	varchar(10),
	@id_customer			varchar(10),
	@jumlah_tiket		int			
AS
BEGIN
	INSERT INTO DetailPemesananTiketBus
	VALUES(@id_pemesananTiket, @id_customer, @jumlah_tiket)
END

-- update Kursi
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateDetail
	@id_pemesananTiket	varchar(10),
	@id_customer		varchar(10),
	@jumlah_tiket		int	
AS
BEGIN
	UPDATE DetailPemesananTiketBus SET	
	id_customer			= @id_customer,
	jumlah_tiket			= @jumlah_tiket
	WHERE id_pemesananTiket		= @id_pemesananTiket
END

-- delete
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteDetail
	@id_pemesananTiket varchar(10)
AS
BEGIN
	DELETE FROM DetailPemesananTiketBus WHERE id_pemesananTiket = @id_pemesananTiket
END
-- INSERT, UPDATE, DELETE DAFTAR PENUMPANG
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputDaftarPenumpang
	@id_penumpang		varchar(10),
	@id_pemesananTiket	varchar(10),
	@nama				varchar(50),
	@alamat				varchar(50),
	@no_telp			varchar(13),
	@data_wali			varchar(50) 
AS
BEGIN
	INSERT INTO DaftarPenumpang
	VALUES(@id_penumpang, @id_pemesananTiket, @nama, @alamat, @no_telp, @data_wali)
END

-- update Kursi
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdateDaftarPenumpang
	@id_penumpang		varchar(10),
	@id_pemesananTiket	varchar(10),
	@nama				varchar(50),
	@alamat				varchar(50),
	@no_telp			varchar(13),
	@data_wali			varchar(50) 
AS
BEGIN
	UPDATE DaftarPenumpang SET	
	id_pemesananTiket			= @id_pemesananTiket,	
	nama						= @nama,
	alamat						= @alamat,
	no_telp					= @no_telp,
	data_wali					= @data_wali
	WHERE @id_penumpang		= @id_penumpang
END

-- delete
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeleteDaftarPenumpang
	@id_penumpang varchar(10)
AS
BEGIN
	DELETE FROM DaftarPenumpang WHERE id_penumpang = @id_penumpang
END

DROP TABLE Customer
DROP TABLE DetailPemesananTiketBus
DROP TABLE Pemesanan_TiketBus
DROP TABLE Jadwal_Bus
DROP TABLE Jadwal_Trip
DROP TABLE Pemesanan_Trip
DROP TABLE DaftarPenumpang

-- INSERT, UPDATE, DELETE Pemesanan tiket bus
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InputPemesananTiketBus
	@id_pemesananTiket	varchar(10),
	@id_jadwalBus		varchar(10),
	@id_staff			varchar,
	@harga				money,
	@total_harga		money,
	@tanggal_pemesanan	datetime		
AS
BEGIN
	INSERT INTO PemesananTiketBus
	VALUES(@id_pemesananTiket, @id_jadwalBus, @id_staff, @harga, @total_harga, @tanggal_pemesanan)
END

-- update Kursi
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdatePemesananTiket
	@id_pemesananTiket	varchar(10),
	@id_jadwalBus		varchar(10),
	@id_staff			varchar,
	@harga				money,
	@total_harga		money,
	@tanggal_pemesanan	datetime	
AS
BEGIN
	UPDATE PemesananTiketBus SET	
	id_jadwalBus			= @id_jadwalBus,
	id_staff				= @id_staff,
	harga					= @harga,
	total_harga				= @total_harga,
	tanggal_pemesanan		= @tanggal_pemesanan
	WHERE id_pemesananTiket		= @id_pemesananTiket
END

-- delete
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeletePemesananTiketBus
	@id_pemesananTiket varchar(10)
AS
BEGIN
	DELETE FROM PemesananTiketBus WHERE id_pemesananTiket = @id_pemesananTiket
END

-- INSERT, UPDATE, DELETE Detail Pemesanan tiket bus
-- insert 
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_InsertPemesananTrip
	@id_pemesananTrip	varchar(10),
	@id_jadwalTrip		varchar(10),
	@id_customer			varchar(10),
	@id_staff			varchar(10),
	@jumlah_tiket		int,
	@harga				money,
	@total_harga			money,
	@tanggal_pemesanan   datetime		
AS
BEGIN
	INSERT INTO	Pemesanan_Trip
	VALUES(@id_pemesananTrip, @id_jadwalTrip, @id_customer, @id_staff, @jumlah_tiket, @harga, @total_harga, @tanggal_pemesanan)
END

-- update Kursi
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_UpdatePemesananTrip
	@id_pemesananTrip	varchar(10),
	@id_jadwalTrip		varchar(10),
	@id_customer			varchar(10),
	@id_staff			varchar(10),
	@jumlah_tiket		int,
	@harga				money,
	@total_harga			money,
	@tanggal_pemesanan   datetime	
AS
BEGIN
	UPDATE Pemesanan_Trip SET	
	id_jadwalTrip			= @id_jadwalTrip,
	id_customer			= @id_customer,
	id_staff				= @id_staff,
	jumlah_tiket			= @jumlah_tiket,
	harga					= @harga,
	total_harga			= @total_harga,
	tanggal_pemesanan		= @tanggal_pemesanan
	WHERE id_pemesananTrip		= @id_pemesananTrip
END

-- delete
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC sp_DeletePemesananTrip
	@id_pemesananTrip varchar(10)
AS
BEGIN
	DELETE FROM Pemesanan_Trip WHERE id_pemesananTrip = @id_pemesananTrip
END