use SHOPEE
go

--T1 Thêm một khách hàng
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
begin TRAN
	DECLARE @idKH INT = dbo.f_timIDKH() + 1
	insert KHACHHANG
	values(@idKH, @ten, @gioi, @ngaysinh, @email, @dt, @tk)
	INSERT KHACHMUA
	VALUES(@idKH, NULL)
	IF @@ERROR != 0
		rollback tran
commit tran
go

/*EXEC dbo.sp_themKhachHang @ten = 'xyz',                -- varchar(40)
                          @gioi = 'nu',               -- varchar(3)
                          @ngaysinh = '2020-12-27', -- date
                          @email = 'khoa031099@gmail.com',              -- varchar(40)
                          @dt = '0336069400',                 -- char(10)
                          @tk = NULL                  -- varchar(16)
GO
SELECT * FROM dbo.KHACHHANG WHERE EMAILKH='minhkhoa031099@gmail.com'*/


--T2 Cập nhật thông tin của một khách hàng 
create proc sp_suaKhachHang 
	@id int = NULL,
	@ten varchar(40) = NULL, 
	@gioi varchar(3) = NULL,
	@ngaysinh date = NULL,
	@email varchar(40) = NULL,
	@dt char(10) = NULL,
	@tk varchar(16) = NULL
as
begin tran
	update KHACHHANG
	set TENKH = @ten
	where IDKH = @id and (@ten != NULL or @ten != '')
	update KHACHHANG
	set GIOITINHKH = @gioi
	where IDKH = @id and (@gioi != NULL or @gioi != '')
	update KHACHHANG
	set NGAYSINHKH = @ngaysinh
	where IDKH = @id and (@ngaysinh != NULL or @ngaysinh != '')
	update KHACHHANG
	set EMAILKH = @email
	where IDKH = @id and (@email != NULL or @email != '')
	update KHACHHANG
	set DIENTHOAIKH = @dt
	where IDKH = @id and (@dt != NULL or @dt != '')
	update KHACHHANG
	set TAIKHOANKH = @tk
	where IDKH = @tk and (@tk != NULL or @tk != '')
	if @@ERROR != 0
		rollback tran
commit tran
go

/*EXEC dbo.sp_suaKhachHang @id = 150001,                  -- int
                         @ten = 'Pham Minh Khoa',                -- varchar(40)
                         @gioi = 'nam',               -- varchar(3)
                         @ngaysinh = '1999-10-03', -- date
                         @email = '',              -- varchar(40)
                         @dt = '',                 -- char(10)
                         @tk = ''                  -- varchar(16)
GO*/


--(3)  Thống kê doanh thu theo thang của khách bán 
create proc sp_thongkeDoanhThuKH @ngaybd date, @ngaykt date
as
begin tran
	declare cur cursor scroll for
	select kb.IDKH, spkb.IDSP, sp.GIASP, ctdg.SOLUONGGIAO, ctdg.IDDG, dg.NGAYGIAO
	from KHACHBAN kb left join SANPHAMKB spkb on kb.IDKH = spkb.IDKH
		join SANPHAM sp on sp.IDSP = spkb.IDSP
		join CHITIETDG ctdg on ctdg.IDSP = sp.IDSP
		join (select IDDG, NGAYGIAO from DONGIAO where TTGIAO = 1) dg on dg.IDDG = ctdg.IDDG
	group by kb.IDKH, spkb.IDSP, sp.GIASP, ctdg.IDDG, dg.NGAYGIAO, ctdg.SOLUONGGIAO

	open cur
	declare @bangDoanhThu table(idKH int, thang smallint, nam smallint, tien money)
	DECLARE @tienThang MONEY = 0
	declare @idKH int, @idSP int, @giaSP money, @soluong INT, @idDG int, @ngaygiao date
	declare @idKHCU int, @ngaygiaoCU date
	--declare @numberRows int = @@CURSOR_ROWS, @countRows int = 0 --tránh trường hợp tới dòng cuối cùng cur next tiêp mà không có giá trị vào các biến @idKH2

	fetch next from cur into @idKH, @idSP, @giaSP, @soluong, @idDG, @ngaygiao
	SET @idKHCU = @idKH
	SET @ngaygiaoCu = @ngaygiao
	while @@FETCH_STATUS=0
	begin
		--set @countRows += 1

		if(@idKH = @idKHCU)
		begin
			IF((YEAR(@ngaygiao) != YEAR(@ngaygiaoCU)) OR (MONTH(@ngaygiao) != MONTH(@ngaygiaoCU)))
			BEGIN
				INSERT @bangDoanhThu
				(
				    idKH,
				    thang,
				    nam,
				    tien
				)
				VALUES
				(   @idKHCU,   -- idKH - int
				    MONTH(@ngaygiao),   -- thang - smallint
				    YEAR(@ngaygiaoCU),   -- nam - smallint
				    @tienThang -- tien - money
				    )
				SET @tienThang = 0
				SET @tienthang += @idDG * @soluong
            END
            ELSE IF((YEAR(@ngaygiao) = YEAR(@ngaygiaoCU)) AND (MONTH(@ngaygiao) = MONTH(@ngaygiaoCU)))
			BEGIN
				SET @tienthang += @idDG * @soluong
            END 
		end
		else if(@idKH != @idKHCU)
		BEGIN
			INSERT @bangDoanhThu
				(
				    idKH,
				    thang,
				    nam,
				    tien
				)
				VALUES
				(   @idKHCU,   -- idKH - int
				    MONTH(@ngaygiao),   -- thang - smallint
				    YEAR(@ngaygiaoCU),   -- nam - smallint
				    @tienThang -- tien - money
				)
			SET @tienThang = 0
			SET @tienthang += @idDG * @soluong
        END 
		SET @idKHCU = @idKH
		SET @ngaygiaoCU = @ngaygiao
		fetch next from cur into @idKH, @idSP, @giaSP, @soluong, @idDG, @ngaygiao
	END
    
	close cur
	deallocate cur

	SELECT * FROM @bangDoanhThu
	if @@ERROR != 0
		rollback tran
commit TRAN
GO
/*EXEC dbo.sp_thongkeDoanhThuKH @ngaybd = '2018-1-1', -- date
                              @ngaykt = '2020-12-1'  -- date*/

--(7) Khách mua mua hàng
CREATE FUNCTION f_getIDDM()
RETURNS int
BEGIN
	RETURN (SELECT (MAX(IDDM) + 1) FROM DONMUA)
END 
GO 

CREATE PROC sp_muaHANG @idKH INT, @idSP INT, @soLuong INT 
AS
BEGIN TRAN 
	DECLARE @idDM int = dbo.f_getIDDM()
	INSERT dbo.DONMUA
	(
	    IDDM,
	    IDKH,
	    NGAYMUA,
	    TTXEM
	)
	VALUES
	(   @idDM,         -- IDDM - int
	    @idKH,         -- IDKH - int
	    GETDATE(), -- NGAYMUA - datetime
	    0          -- TTXEM - tinyint
	    )

	INSERT dbo.CHITIETDM
	(
	    IDDM,
	    IDSP,
	    SOLUONGMUA
	)
	VALUES
	(   @idDM, -- IDDM - int
	    @idSP, -- IDSP - int
	    @soLuong  -- SOLUONGMUA - int
	    )
 IF @@ERROR <> 0
	ROLLBACK TRAN
COMMIT TRAN
GO

EXEC dbo.sp_muaHANG @idKH = 1,   -- int
                    @idSP = 1,   -- int
                    @soLuong = 1 -- int
GO

SELECT * FROM dbo.DONMUA WHERE IDKH = 1



--(4) Thống ke số lượng tồn kho trên mỗi sản phẩm của mỗi khách bán 
--
--(5)  Tìm kiếm sản phẩm 
--
--(6) Xem thông tin đơn giao hàng 
--
--(7) Xem thông tin đơn mua hàng 
--
--(8) Xem đánh giá của mỗi shop 
--
--(9) Đăng bán sản phẩm 
--
--(10) Chỉnh sửa, xóa sản phẩm 
SELECT COUNT(*) FROM dbo.CHITIETDM
SELECT COUNT(*) FROM dbo.KHACHHANG
