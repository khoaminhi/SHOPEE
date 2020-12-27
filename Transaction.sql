UPDATE dbo.Account 
SET id = 2 WHERE UserName='staff'

SELECT * FROM dbo.Food

SELECT * FROM dbo.SANPHAM

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

SELECT * FROM dbo.SANPHAM

INSERT INTO dbo.SANPHAM
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
(   0,    -- IDSP - int
    0,    -- IDDANHMUC - int
    '',   -- TENSP - varchar(100)
    '',   -- MOTASP - varchar(3000)
    '',   -- ANHSP - varchar(50)
    '',   -- VIDEOSP - varchar(50)
    '',   -- THUONGHIEU - varchar(50)
    NULL, -- GIASP - money
    '',   -- MASKU - varchar(20)
    0     -- TINHTRANG_ - tinyint
    

	SELECT * FROM dbo.CHITIETDM
	SELECT * FROM dbo.DANHMUC


	SELECT DISTINCT * FROM (dbo.SANPHAM JOIN dbo.SANPHAMKB ON SANPHAMKB.IDSP = SANPHAM.IDSP) JOIN dbo.KHACHBAN KB ON KB.IDKH= dbo.SANPHAMKB.IDKH  WHERE dbo.SANPHAMKB.IDKH='1'
	SELECT * FROM dbo.KHACHBAN

	SELECT * FROM dbo.KHACHHANG
	SELECT * FROM dbo.DONMUA
	

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
SELECT * FROM dbo.CHITIETDM
SELECT * FROM dbo.DONMUA WHERE IDKH =1
SELECT * FROM dbo.KHACHHANG
SELECT * FROM dbo.KHACHBAN
SELECT * FROM dbo.KHACHMUA
SELECT * FROM dbo.KHO

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
ALTER PROCEDURE USP_InsertProduct @iddm INT, @tensp VARCHAR(50),@motasp VARCHAR(100),@anh VARCHAR(50),@video VARCHAR(50),@thuonghieu VARCHAR(10),@gia FLOAT,@maSKU VARCHAR(10),@tinhtrang TINYINT
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
ALTER PROC usp_deleteproduct @idsp int
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
SELECT * FROM dbo.KHO
ALTER PROC usp_insertInventory @idnv INT,@tenkho VARCHAR (50),@diachi VARCHAR(100)
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

	UPDATE dbo.KHO 
	SET TENKHO ='Kho C'
	WHERE IDKHO=2

ALTER PROC usp_deleteInventory @idkho int
AS
BEGIN
     alter table dbo.CHITIETKHO NOCHECK constraint ALL
	  alter table dbo.DONGIAO NOCHECK constraint ALL
	 DELETE FROM kho WHERE IDKHO=@idKho
	   ALTER table dbo.CHITIETKHO check constraint ALL
	   ALTER table dbo.DONGIAO check constraint ALL
END
EXEC usp_deleteInventory 481

SELECT * FROM dbo.KHACHHANG

SELECT dbo.DONGIAO.IDDG, SOLUONGGIAO*SP.GIASP AS TONGTIEN FROM (dbo.DONGIAO JOIN dbo.CHITIETDG ON CHITIETDG.IDDG = DONGIAO.IDDG) JOIN dbo.SANPHAM SP ON SP.IDSP = dbo.CHITIETDG.IDSP WHERE TTGIAO = 1
CREATE PROC sp_timSPKB @idCus INT
AS
BEGIN
    SELECT * FROM dbo.SANPHAM JOIN dbo.SANPHAMKB ON SANPHAMKB.IDSP = SANPHAM.IDSP WHERE IDKH=@idCus
END
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