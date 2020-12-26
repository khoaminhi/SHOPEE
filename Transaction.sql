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

