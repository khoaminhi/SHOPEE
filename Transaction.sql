
CREATE TABLE account
(
	id INT,
	username VARCHAR(20),
	password VARCHAR(20),
	type int
)

INSERT INTO dbo.account
(
    id,
    username,
    password,
    type
)
VALUES
(   1,  -- id - int
    'hao', -- username - varchar(20)
    '1', -- password - varchar(20)
    1   -- type - int
    ),(   2,  -- id - int
    'staff', -- username - varchar(20)
    '1', -- password - varchar(20)
    2   -- type - int
    ),(   3,  -- id - int
    'cus', -- username - varchar(20)
    '1', -- password - varchar(20)
    3   -- type - int
    ),(   1,  -- id - int
    'sale', -- username - varchar(20)
    '1', -- password - varchar(20)
    4   -- type - int
    )

	ALTER TABLE dbo.account
	ADD displayname VARCHAR(20);
	UPDATE dbo.account SET displayname = 'test'

	SELECT * FROM dbo.account
CREATE PROC USP_GetAccountByUserName
@userName nvarchar(100)
AS 
BEGIN
	SELECT * FROM dbo.Account WHERE UserName = @userName
END
GO


CREATE PROC USP_Login
@userName nvarchar(100), @passWord nvarchar(100)
AS
BEGIN 
	SELECT * FROM dbo.Account WHERE UserName=@userName AND PassWord=@passWord
END 
GO


CREATE PROC USP_InsertBillInfo
@idBill INT, @idProduct INT, @count INT
AS
BEGIN

	DECLARE @isExitsBillInfo INT
	DECLARE @productCount INT = 1
	
	SELECT @isExitsBillInfo = IDDM, @productCount = b.SOLUONGMUA
	FROM dbo.CHITIETDM AS b 
	WHERE b.IDDM = @idBill AND b.IDSP = @idProduct

	IF (@isExitsBillInfo > 0)
	BEGIN
		DECLARE @newCount INT = @productCount + @count
		IF (@newCount > 0)
			UPDATE dbo.CHITIETDM	SET SOLUONGMUA = @productCount + @count WHERE IDSP = @idProduct
		ELSE
			DELETE dbo.CHITIETDM WHERE IDDM = @idBill AND IDSP = @idProduct
	END
	ELSE
	BEGIN
		  INSERT dbo.CHITIETDM
		  (
		      IDDM,
		      IDSP,
		      SOLUONGMUA
		  )
		  VALUES
		  (   @idBill, -- IDDM - int
		      @idProduct, -- IDSP - int
		      @count  -- SOLUONGMUA - int
		      )
	END
END
GO


CREATE PROC USP_InsertBill
@idCus INT
AS
BEGIN
INSERT INTO dbo.DONMUA
(
    IDDM,
    IDKH,
    NGAYMUA,
    TTXEM
)
VALUES
(   0,         -- IDDM - int
    @idCus,         -- IDKH - int
    GETDATE(), -- NGAYMUA - datetime
    0          -- TTXEM - tinyint
    )
	/*INSERT dbo.Bill
	        ( DateCheckIn ,
	          DateCheckOut ,
	          idCus ,
	          status,
			  discount
	        )
	VALUES  ( GETDATE() , -- DateCheckIn - datetime
	          NULL , -- DateCheckOut - datetime
	          @idTable, -- idTable - int
	          0,-- status - int
			  0 
	        )*/
END


CREATE FUNCTION [dbo].[GetUnsignString](@strInput NVARCHAR(4000)) 
RETURNS NVARCHAR(4000)
AS
BEGIN     
    IF @strInput IS NULL RETURN @strInput
    IF @strInput = '' RETURN @strInput
    DECLARE @RT NVARCHAR(4000)
    DECLARE @SIGN_CHARS NCHAR(136)
    DECLARE @UNSIGN_CHARS NCHAR (136)

    SET @SIGN_CHARS       = N'ăâđêôơưàảãạáằẳẵặắầẩẫậấèẻẽẹéềểễệếìỉĩịíòỏõọóồổỗộốờởỡợớùủũụúừửữựứỳỷỹỵýĂÂĐÊÔƠƯÀẢÃẠÁẰẲẴẶẮẦẨẪẬẤÈẺẼẸÉỀỂỄỆẾÌỈĨỊÍÒỎÕỌÓỒỔỖỘỐỜỞỠỢỚÙỦŨỤÚỪỬỮỰỨỲỶỸỴÝ'+NCHAR(272)+ NCHAR(208)
    SET @UNSIGN_CHARS = N'aadeoouaaaaaaaaaaaaaaaeeeeeeeeeeiiiiiooooooooooooooouuuuuuuuuuyyyyyAADEOOUAAAAAAAAAAAAAAAEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOUUUUUUUUUUYYYYYDD'

    DECLARE @COUNTER int
    DECLARE @COUNTER1 int
    SET @COUNTER = 1
 
    WHILE (@COUNTER <=LEN(@strInput))
    BEGIN   
      SET @COUNTER1 = 1
      --Tim trong chuoi mau
       WHILE (@COUNTER1 <=LEN(@SIGN_CHARS)+1)
       BEGIN
     IF UNICODE(SUBSTRING(@SIGN_CHARS, @COUNTER1,1)) = UNICODE(SUBSTRING(@strInput,@COUNTER ,1) )
     BEGIN           
          IF @COUNTER=1
              SET @strInput = SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)-1)                   
          ELSE
              SET @strInput = SUBSTRING(@strInput, 1, @COUNTER-1) +SUBSTRING(@UNSIGN_CHARS, @COUNTER1,1) + SUBSTRING(@strInput, @COUNTER+1,LEN(@strInput)- @COUNTER)    
              BREAK         
               END
             SET @COUNTER1 = @COUNTER1 +1
       END
      --Tim tiep
       SET @COUNTER = @COUNTER +1
    END
    RETURN @strInput
END

-----------------
CREATE PROCEDURE USP_InsertProduct @iddm INT, @tensp VARCHAR(50),@motasp VARCHAR(100),@anh VARCHAR(50),@video VARCHAR(50),@thuonghieu VARCHAR(10),@gia FLOAT,@maSKU VARCHAR(10),@tinhtrang TINYINT
as
BEGIN
DECLARE @num INT
SET @num=(SELECT MAX(IDSP) FROM dbo.SANPHAM)+1
    INSERT dbo.SANPHAM
(
    IDSP,
    IDDANHMUC,
    TENSP,
    MOTASP,
    ANHSP,
    VIDEOSP,
    THUONGHIEU,
    GIASP,
    MASKU,
    TINHTRANG_
)
VALUES
(   @num,    -- IDSP - int
    @iddm,    -- IDDANHMUC - int
    @tensp,   -- TENSP - varchar(100)
    @motasp,   -- MOTASP - varchar(3000)
    @anh,   -- ANHSP - varchar(50)
    @video,   -- VIDEOSP - varchar(50)
    @thuonghieu,   -- THUONGHIEU - varchar(50)
    @gia, -- GIASP - money
    @maSKU,   -- MASKU - varchar(20)
    @tinhtrang   -- TINHTRANG_ - tinyint
    )
END

EXEC USP_InsertProduct 1, 'abc', 'abc' ,'1' ,'1' ,'abc' ,1000,'123' ,1


CREATE PROC usp_deleteproduct @idsp int
AS
BEGIN
    alter table dbo.CHITIETDG nocheck constraint ALL
    alter table dbo.CHITIETDM nocheck constraint ALL
	alter table dbo.KHO nocheck constraint ALL
	alter table dbo.CHITIETKHO NOCHECK constraint ALL
	alter table dbo.DANHGIASP NOCHECK constraint ALL
	alter table dbo.SANPHAMKB NOCHECK constraint ALL
	DELETE from dbo.SANPHAM WHERE IDSP =@idsp
	
	ALTER table dbo.CHITIETDG check constraint ALL
    ALTER table dbo.CHITIETDM check constraint ALL
    ALTER table dbo.KHO check constraint ALL
    ALTER table dbo.CHITIETKHO check constraint ALL
    ALTER table dbo.DANHGIASP check constraint ALL
    ALTER table dbo.SANPHAMKB check constraint all
END


CREATE PROC usp_insertInventory @idnv INT,@tenkho VARCHAR (50),@diachi VARCHAR(100)
AS
DECLARE @numInventory INT
SET @numInventory = (SELECT MAX(IDKHO) FROM dbo.KHO) +1
INSERT dbo.KHO
(
    IDKHO,
    IDNV,
    TENKHO,
    DIACHIKHO
)
VALUES
(   @numInventory,  -- IDKHO - int
    @idnv,  -- IDNV - int
    @tenkho, -- TENKHO - varchar(40)
    @diachi  -- DIACHIKHO - varchar(100)
    )

	
	------
CREATE PROC sp_capnhatKho @idInven INT, @ten VARCHAR(50),@diachi VARCHAR(100),@idnv int 
AS 
BEGIN 
		
	UPDATE dbo.KHO
	SET TENKHO=@ten,
		IDNV=@idnv,
		DIACHIKHO=@diachi
		WHERE IDKHO=@idInven
    END 
	EXEC sp_capnhatKho 100,'Kho ABC','123',4
	--------------------
CREATE PROC usp_deleteInventory @idkho int
AS
BEGIN
     alter table dbo.CHITIETKHO NOCHECK constraint ALL
	  alter table dbo.DONGIAO NOCHECK constraint ALL
	 DELETE FROM kho WHERE IDKHO=@idKho
	   ALTER table dbo.CHITIETKHO check constraint ALL
	   ALTER table dbo.DONGIAO check constraint ALL
END
EXEC usp_deleteInventory 481


--------
SELECT dbo.DONGIAO.IDDG, SOLUONGGIAO*SP.GIASP AS TONGTIEN FROM (dbo.DONGIAO JOIN dbo.CHITIETDG ON CHITIETDG.IDDG = DONGIAO.IDDG) JOIN dbo.SANPHAM SP ON SP.IDSP = dbo.CHITIETDG.IDSP WHERE TTGIAO = 1
CREATE PROC sp_timSPKB @idCus INT
AS
BEGIN
    SELECT * FROM dbo.SANPHAM JOIN dbo.SANPHAMKB ON SANPHAMKB.IDSP = SANPHAM.IDSP WHERE IDKH=@idCus
END
---------
CREATE PROC sp_capnhatKho @idKHO INT,@idNV INT,@tenKHO VARCHAR(50),@diachi VARCHAR(100)
AS
BEGIN
    IF(NOT EXISTS(SELECT * FROM dbo.KHO WHERE IDKHO=@idKHO))
		RETURN;
	ELSE 
		UPDATE dbo.KHO
		SET TENKHO=@tenKHO,
			DIACHIKHO=@diachi,
			IDNV=@idNV
		WHERE IDKHO=idKHO
END


CREATE PROC sp_donmua @idkh INT,@ngaymua DATE
AS
BEGIN
	DECLARE @iddm INT
    SET @iddm = (SELECT MAX(IDDM) FROM dbo.DONMUA)+1
	INSERT dbo.DONMUA (IDDM,IDKH,NGAYMUA,TTXEM)VALUES(@iddm,@idkh,GETDATE(),0)
END
CREATE PROC sp_chitietdonmua @iddm INT,@idsp INT,@sl INT
AS
BEGIN
    INSERT dbo.CHITIETDM(IDDM,IDSP,SOLUONGMUA)
    VALUES (@iddm, @idsp, @sl)
END


CREATE PROC sp_thongkeHT_KB @idkh int
AS
BEGIN
    SELECT SP.IDSP,SP.TENSP,SPKB.SOLUONGHT FROM dbo.SANPHAM SP JOIN dbo.SANPHAMKB SPKB ON SPKB.IDSP = SP.IDSP WHERE SPKB.IDKH=@idkh
END
EXEC sp_thongkeHT_KB 3
CREATE CLUSTERED INDEX index_sanpham ON dbo.SANPHAM (IDSP)
DROP INDEX index_sanpham ON dbo.SANPHAM
------------------ Giao tac 2---------------------

create PROC sp_xoaKH @idkh INT
AS
BEGIN
  alter table dbo.DIACHIKH NOCHECK constraint ALL
  alter table dbo.KHACHBAN NOCHECK constraint ALL
  ALTER TABLE dbo.KHACHMUA NOCHECK CONSTRAINT ALL 
  ALTER TABLE dbo.SANPHAMKB NOCHECK CONSTRAINT ALL 
  ALTER TABLE dbo.DANHGIASP NOCHECK CONSTRAINT ALL
  ALTER TABLE dbo.DONGIAO NOCHECK CONSTRAINT ALL
  ALTER TABLE dbo.DONMUA NOCHECK CONSTRAINT ALL
  ALTER TABLE dbo.MAGIAMKM NOCHECK CONSTRAINT ALL
	IF(EXISTS(SELECT * FROM dbo.KHACHMUA WHERE IDKH=@idkh) AND EXISTS(SELECT * FROM dbo.KHACHBAN WHERE IDKH=@idkh))
		DELETE dbo.KHACHMUA WHERE IDKH=@idkh
		DELETE dbo.KHACHHANG WHERE IDKH=@idkh
		DELETE dbo.DIACHIKH WHERE IDKH=@idkh
		DELETE dbo.KHACHBAN WHERE IDKH=@idkh
		DELETE dbo.SANPHAMKB WHERE IDKH=@idkh
		DELETE dbo.MAGIAMKM WHERE IDKH=@idkh
	IF(EXISTS(SELECT * FROM dbo.KHACHMUA WHERE IDKH=@idkh) AND NOT EXISTS(SELECT * FROM dbo.KHACHBAN WHERE IDKH=@idkh))
		DELETE dbo.KHACHMUA WHERE IDKH=@idkh
		DELETE dbo.KHACHHANG WHERE IDKH=@idkh
		DELETE dbo.DIACHIKH WHERE IDKH=@idkh
		DELETE dbo.MAGIAMKM WHERE IDKH=@idkh
	IF(NOT EXISTS(SELECT * FROM dbo.KHACHMUA WHERE IDKH=@idkh) AND EXISTS(SELECT * FROM dbo.KHACHBAN WHERE IDKH=@idkh))
		DELETE dbo.KHACHHANG WHERE IDKH=@idkh
		DELETE dbo.DIACHIKH WHERE IDKH=@idkh
		DELETE dbo.KHACHBAN WHERE IDKH=@idkh
		DELETE dbo.SANPHAMKB WHERE IDKH=@idkh
	ALTER TABLE dbo.MAGIAMKM CHECK CONSTRAINT all
	ALTER TABLE dbo.DONMUA CHECK CONSTRAINT all
	ALTER TABLE dbo.DONGIAO CHECK CONSTRAINT all
	ALTER table dbo.DIACHIKH check constraint ALL
	ALTER table dbo.KHACHBAN check constraint ALL
	ALTER TABLE dbo.KHACHMUA CHECK CONSTRAINT ALL
    ALTER TABLE dbo.SANPHAMKB CHECK CONSTRAINT ALL
    ALTER TABLE dbo.DANHGIASP CHECK CONSTRAINT all
END
EXEC sp_xoaKH  125

------------------ Giao tac 1---------------------
create function f_timIDKH() 
returns int 
as 
begin 
	return (select max(IDKH) from KHACHHANG) 
end 
go 
create proc sp_themKhachHang  
	@ten varchar(40),  
	@gioi varchar(3), 
	@ngaysinh date, 
	@email varchar(40), 
	@dt char(10), 
	@tk varchar(16) 
as 
begin tran 
	insert KHACHHANG 
	values(dbo.f_timIDKH(), @ten, @gioi, @ngaysinh, @email, @dt, @tk) 
	if @@ERROR != 0 
		rollback tran 
commit tran 
GO 
dbo.sp_themKhachHang @ten = 'Nguyen Van B',                -- varchar(40)
                     @gioi = 'Nam',               -- varchar(3)
                     @ngaysinh = '2000-12-27', -- date
                     @email = '123@gmail.com',              -- varchar(40)
                     @dt = '123',                 -- char(10)
                     @tk = '123'                  -- varchar(16)
CREATE INDEX index_KhachHang ON dbo.KHACHHANG (IDKH)
CREATE CLUSTERED INDEX index_SP ON dbo.SANPHAM (IDSP)
DROP INDEX index_SP ON dbo.SANPHAM
DROP INDEX index_sanpham ON dbo.SANPHAM 
EXEC sp_thongkeHT_KB 100

EXEC sp_xoaKH 150


CREATE PROC sp_timSP @idsp int 
AS 
BEGIN 
    SELECT * FROM SANPHAM where IDSP=@idsp 
END 

EXEC sp_timSP 499


CREATE PROC sp_timthongtindonmuahang @id int,@ngaymua datetime
AS
BEGIN
    SELECT * FROM dbo.DONMUA WHERE IDDM=@id AND NGAYMUA=@ngaymua
END
EXEC sp_timthongtindonmuahang 100,'2000-01-01'


CREATE PROC sp_timKH 
AS 
BEGIN 
    SELECT * FROM KHACHHANG 
END 


CREATE PROC sp_timKho @idkho int 
AS 
BEGIN 
    SELECT * FROM KHO where IDKHO=@idkho 
END 

EXEC sp_timKH
EXEC sp_timKho 400


CREATE PROC sp_xoaKho @idKho int
AS 
BEGIN 
    alter table dbo.CHITIETKHO NOCHECK constraint ALL 
    alter table dbo.DONGIAO NOCHECK constraint ALL 
    DELETE FROM kho WHERE IDKHO=@idKho 
    ALTER table dbo.CHITIETKHO check constraint ALL 
    ALTER table dbo.DONGIAO check constraint ALL 
END 

EXEC sp_xoaKho 450


CREATE PROC sp_themKho @idnv INT,@tenkho VARCHAR (50),@diachi VARCHAR(100) 
AS 
BEGIN 
    DECLARE @numInventory INT 
    SET @numInventory = (SELECT MAX(IDKHO) FROM dbo.KHO) +1 
    INSERT dbo.KHO 
( 
    IDKHO, 
    IDNV, 
    TENKHO, 
    DIACHIKHO 
) 
VALUES 
(   @numInventory,  -- IDKHO - int 
    @idnv,  -- IDNV - int 
    @tenkho, -- TENKHO - varchar(40) 
    @diachi  -- DIACHIKHO - varchar(100) 
    ) 
END 
EXEC sp_themKho 450, 'Kho B1','250 Tran Phu, Quan 7,TPHCM'


CREATE PROC sp_capnhatKho @idInven INT, @ten varchar(50) ,@idnv int, @diachi varchar(100)
AS 
BEGIN 
    UPDATE dbo.KHO 
	SET TENKHO=@ten, 
	IDNV=@idnv, 
	DIACHIKHO=@diachi 
	WHERE IDKHO=@idInven 
    END 
	
	EXEC sp_capnhatKho 120,'Kho H5',59,'Nguyen Thai Hoc, Quan 7, TPHCM'


CREATE PROC sp_timSPKB @idCus INT 
AS 
BEGIN 
    SELECT * FROM dbo.SANPHAM JOIN dbo.SANPHAMKB ON SANPHAMKB.IDSP = SANPHAM.IDSP WHERE IDKH=@idCus
END 
EXEC sp_timSPKB 230
CREATE PROC sp_timHienThiSP 
AS 
BEGIN 
    SELECT * FROM SANPHAM 
END 
EXEC sp_timHienThiSP
SELECT * FROM dbo.SANPHAM

EXEC dbo.sp_themKhachHang @ten = 'Tran Thi B',                -- varchar(40)
                          @gioi = 'Nu',               -- varchar(3)
                          @ngaysinh = '2002-12-27', -- date
                          @email = '456@gmail.com',              -- varchar(40)
                          @dt = '09808',                 -- char(10)
                          @tk = '123456'                  -- varchar(16)

