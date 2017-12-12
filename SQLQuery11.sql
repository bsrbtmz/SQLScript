--1*her �ehirden ka� bilet sat�lm��
--2*herhangi bir�ehri soyleyerek o sehr� en cok ziyaret eden musteri ve ziyaretci say�s�
--3*ikinci sorgudaki ki�inin bir ay icerisindeki yolculuk s�kl�g�
--4*iki haftal�k yolculuk sures�nde yolculuk etmi� kad�n yolcular�n erkek yolcularaoran�
--5*indirimli bilet alm�� olan yolcular�n say�s�
--6*bir haftadaki seferlerin sat�� potansiyelinin gercek sat�sa oran�
--7*bir hafta i�erisinde kac farkl� yolcu...sehre yolculuk etmi�tir
--8*bir hafta i�erisinde iptal edilmi� sefer say�s� nedir
--9*�ehirlere g�re iptal edilmi� sefer say�s�(aylara gore bakabilirsiniz)
--10*�� haftal�k s�re i�indeki ortalama kazanc�n i�erisinde bulunan haftada dinilmi� kazanca oran�
--11*sefer tarihi de�i�tirilmi� olanlara yap�lan �nd�r�m verilen hafta i�erisinde ne kadar zarara mal oldu?
--12*hastal�k dolay�s�yla seferini iptal etmi� olan �of�rler kimlerdir
use acentaOtobus
--2
select * from (select tbl.yolcuId from (select top 1 y.yolcuId, COUNT(*) as yolcuSay from seferler s,yolcular y
 where s.seferId=y.yolcuId and s.varisSehriId=3 group by y.yolcuId order by yolcuSay desc) as tbl)
--1
select s.kalkisSehriId, COUNT(bd.biletId) as biletSayisi from seferler s,biletDetay bd,biletler b where s.seferId=b.seferId and b.biletId=bd.biletId group by s.kalkisSehriId
--12
select c.personelAd from otobusMasraflar om,otobusler o,calisanlar c where om.otobusId=o.otobusId and c.calisanTipId=o.calisanId and om.masrafTipID=3
--8
select s.sehirAdi, COUNT(sef.seferId) as �ptalSefer from sehirler s, seferler sef where sef.kalkisSehriId=s.sehirId and  sef.iptalDurumu=1 and sef.kalkisTarihi between '2017-01-01' and '2017-02-15' group by s.sehirAdi
--9
select s.sehirAdi, COUNT(sef.seferId) as �ptalSefer from sehirler s, seferler sef where sef.kalkisSehriId=s.sehirId and  sef.iptalDurumu=1 group by s.sehirAdi
--4
select CONVERT(int ,(select COUNT(*) from yolcular y,seferler s where y.seferId=s.seferId and 
y.cinsiyet='Kad�n'  ))
/
convert (int, (select COUNT(*) from yolcular y,seferler s where y.seferId=s.seferId and 
y.cinsiyet='Erkek'  )) where seferler.kalkisTarihi between '2017-0-01' and '2017-01-15'
--10,6
select 
convert (money,
	(select AVG(bd.biletUcret) from biletDetay bd, biletler b,seferler s 
	where bd.biletId=b.biletId and b.seferId=s.seferId  ))
/
convert(money ,(select avg(bd.biletUcret) from biletDetay bd, biletler b,seferler s 
	where bd.biletId=b.biletId and b.seferId=s.seferId and s.kalkisTarihi between '2017-01-01' and '2017-02-01'))
--5
go
create function PercentageFinder(@op money, @np money) returns money
	begin
		declare @difference money = @np - @op;
		declare @percentage money = @difference / @op * 100;
		return @percentage;
	end

go 
select dbo.PercentageFinder(bd.biletUcret,s.biletSeferTutari) as indirimTutar 
from seferler s, biletDetay bd,biletler b where s.seferId=b.seferId and b.biletId=bd.biletId
