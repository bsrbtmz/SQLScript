--1*her þehirden kaç bilet satýlmýþ
--2*herhangi birþehri soyleyerek o sehrý en cok ziyaret eden musteri ve ziyaretci sayýsý
--3*ikinci sorgudaki kiþinin bir ay icerisindeki yolculuk sýklýgý
--4*iki haftalýk yolculuk suresýnde yolculuk etmiþ kadýn yolcularýn erkek yolcularaoraný
--5*indirimli bilet almýþ olan yolcularýn sayýsý
--6*bir haftadaki seferlerin satýþ potansiyelinin gercek satýsa oraný
--7*bir hafta içerisinde kac farklý yolcu...sehre yolculuk etmiþtir
--8*bir hafta içerisinde iptal edilmiþ sefer sayýsý nedir
--9*þehirlere göre iptal edilmiþ sefer sayýsý(aylara gore bakabilirsiniz)
--10*üç haftalýk süre içindeki ortalama kazancýn içerisinde bulunan haftada dinilmiþ kazanca oraný
--11*sefer tarihi deðiþtirilmiþ olanlara yapýlan ýndýrým verilen hafta içerisinde ne kadar zarara mal oldu?
--12*hastalýk dolayýsýyla seferini iptal etmiþ olan þoförler kimlerdir
use acentaOtobus
--2
select * from (select tbl.yolcuId from (select top 1 y.yolcuId, COUNT(*) as yolcuSay from seferler s,yolcular y
 where s.seferId=y.yolcuId and s.varisSehriId=3 group by y.yolcuId order by yolcuSay desc) as tbl)
--1
select s.kalkisSehriId, COUNT(bd.biletId) as biletSayisi from seferler s,biletDetay bd,biletler b where s.seferId=b.seferId and b.biletId=bd.biletId group by s.kalkisSehriId
--12
select c.personelAd from otobusMasraflar om,otobusler o,calisanlar c where om.otobusId=o.otobusId and c.calisanTipId=o.calisanId and om.masrafTipID=3
--8
select s.sehirAdi, COUNT(sef.seferId) as ÝptalSefer from sehirler s, seferler sef where sef.kalkisSehriId=s.sehirId and  sef.iptalDurumu=1 and sef.kalkisTarihi between '2017-01-01' and '2017-02-15' group by s.sehirAdi
--9
select s.sehirAdi, COUNT(sef.seferId) as ÝptalSefer from sehirler s, seferler sef where sef.kalkisSehriId=s.sehirId and  sef.iptalDurumu=1 group by s.sehirAdi
--4
select CONVERT(int ,(select COUNT(*) from yolcular y,seferler s where y.seferId=s.seferId and 
y.cinsiyet='Kadýn'  ))
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
