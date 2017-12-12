create database TekServis
 use TekServis

 go
 create table AdresDetay
 (
	Id int IDENTITY(1,1) not null primary key,
	Adi nvarchar(50),
	MahalleCadde nvarchar(50),
	Sokak nvarchar(50),
	Apartman nvarchar(50),
	KapiNo tinyint,
	DaireNo tinyint,
	Semt nvarchar(50),
	Ilce nvarchar(50),
	Il nvarchar(50)
 );

 go
 create table Ariza
 (
	Id int IDENTITY(1,1) not null primary key,
	ArizaAciklama nvarchar(250)
 );

 go
 create table Kategori
 (
	Id int IDENTITY(1,1) not null primary key,
	Adi nvarchar(50)
 );

 go
 create table Marka
 (
	Id int IDENTITY(1,1) not null primary key,
	Adi nvarchar(50),
	constraint fkkat foreign key (Id) references Kategori(Id)
 );

 go
 create table Model
 (	
	Id int IDENTITY(1,1) not null primary key,
	Adi nvarchar(50),
	constraint fkkat foreign key (Id) references Marka(Id)
 
 );

 go
 create table Musteri
 (
	Id int IDENTITY(1,1) not null primary key,
	Adi nvarchar(50),
	Soyadi nvarchar(50),
	Email nvarchar(50),
	Telefon nchar(15)
 );

 go
 create table MusteriDetay
 (
	MusteriId int ,	
	AdresId int,	
	constraint fk foreign key (MusteriId) references Musteri(Id),
	constraint fkk foreign key (AdresId) references AdresDetay(Id),
	constraint pk primary key AdresId,
	constraint pk primary key MusteriId,
 );

 go 
 create table Personel
 (
	Id int IDENTITY(1,1) not null primary key,
	Ad nvarchar(50),
	Soyad nvarchar(50),
	DogumTarihi datetime,
	IseGirisTarihi datetime,
	Email nvarchar(50),
	Telefon nchar(15)
 );

 go 
 create table ServisDurum
 (
	Id int IDENTITY(1,1) not null primary key,
	ServisDurum nvarchar(50)
 );

 go
 create table ServisYeri 
 (
	Id int IDENTITY(1,1) not null primary key,
	ServisYeri nvarchar(50)
 );

 go 
 create table Urun
 (
	Id int IDENTITY(1,1) not null primary key,
	IslemNo int,
	MarkaId int,
	constraint fk foreign key (MarkaId) references Marka(Id),
	ModelId int,
	constraint fk foreign key (ModelId) references Model(Id),
	KategoriId int,
	constraint fk foreign key (KategoriId) references Kategori(Id),
	GirisTarihi datetime,arantilimi bit
 );

 go 
 create table UrunTeslim
 (
	Id int IDENTITY(1,1) not null primary key,
	TeslimEdenPersonelId int,
	constraint fk foreign key (TeslimEdenPersonelId) references Personel(Id),
	ServisBedeli money,
	TeslimBedeli money,
	UrunId int,
	constraint fku foreign key (UrunId) references Urun(Id),
	MusteriId int,
	constraint fkm foreign key(MusteriId) references Musteri(Id),
	TeslimTarihi datetime
 );

 go
 create table Islem
 (
	Id int IDENTITY(1,1) not null primary key,
	ArizaId int,
	constraint fka foreign key (ArizaId) references Ariza(Id),
	ServisYeriId int,
	constraint fks foreign key (ServisYeriId) references ServisYeri(Id),
	ServisDurumId int,
	constraint fksd foreign key (ServisDurumId) references ServisDurum(Id),
	UrunTeslimId int,
	constraint fkud foreign key (UrunTeslimId) references UrunTeslim(Id),
	UrunId int,
	constraint fku foreign key (UrunId) references Urun(Id)
 );


