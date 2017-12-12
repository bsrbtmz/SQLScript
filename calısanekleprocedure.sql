use acentaOtobus
Create PROC SP_CalisanEkle
(
@CalisanId int,
@CalisanAd nvarchar(40),
@CalisanSoyAd nvarchar(40),
@CalisanTipId int
)
AS
IF EXISTS(SELECT * FROM calisanlar WHERE personelAd=@CalisanAd and personelSoyad=@CalisanSoyAd)
BEGIN

PRINT 'Sistemde id numarasý mevcuttur!'
END
ELSE
BEGIN
INSERT INTO Calisanlar(personelId,personelAd,personelSoyad,calisanTipId) VALUES (@CalisanId,
@CalisanAd,@CalisanSoyAd,@CalisanTipId)
END
