create database DayBooks
use DayBooks
go
create table Users
(
	id int primary key identity(1,1),
	name nvarchar(20) not null,
	password nvarchar(20) not null
)

go
create table Daybook
(
	id int primary key identity(1,1),
	userId int foreign key references Users(id),
	blog text,
	dateBook datetime2(7) default getdate()
)

go
create procedure usersGet(@name nvarchar(20),@password nvarchar(20))
as
begin
	select*from Users where name=@name and password=@password
end
go
create procedure usersInsert (@name nvarchar(20),@password nvarchar(20))
as
begin
	insert into Users(name,password) values (@name,@password)
end

go
create procedure usersUpdate(@id int, @name nvarchar(20),@password nvarchar(20))
as
begin
	update Users set name=@name, password=@password where id=@id
end

go
create procedure usersDelete(@id int)
as
begin
	delete Users where id=@id
end


go
create procedure DaybookGet(@userId int)
as
begin
	select*from Daybook where userId=@userId 
end
go
create procedure daybookInsert (@userId int, @blog text,@date datetime2(7))
as
begin
	insert into Daybook(userId, blog,dateBook) values (@userId, @blog,@date)
end

go
create procedure daybookUpdate(@id int, @blog text,@date datetime2(7))
as
begin
	update Daybook set blog=blog, dateBook=@date where id=@id
end

go
create procedure daybookDelete(@id int)
as
begin
	delete Users where id=@id
end
