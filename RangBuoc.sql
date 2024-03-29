
use SHOPEE
go

--CÁC RÀNG BUỘC

--ràng buộc giá sản phẩm không được nhỏ hơn 1000
--alter table SANPHAM add constraint ck_Gia check (GIASP > 1000)

--ràng buộc cho tình trạng của sản phẩm
--0:chờ giao
--1:đang giao
--2:đã giao
--3:bị hủy
alter table SANPHAM add constraint ck_TinhTrang check (TINHTRANG_ between 0 and 3)

--ràng buộc giá sản phẩm phải lớn hơn 0
alter table SANPHAM add constraint ck_GiaSP check (GIASP > 0)

--ràng buộc số lượng hàng của khách bán không âm
alter table SANPHAMKB add constraint ck_SoLuongKhachBan check (SOLUONGHT >= 0 and SOLUONGDB >= 0)

--ràng buộc cho tình trang xem của đơn mua
--0:chờ giao
--1:đang giao
--2:đã giao
--3:bị hủy
alter table DONMUA add constraint ck_TTXEM check (TTXEM between 0 and 3)

--ràng buộc cho tình trang giao của đơn giao
--0:chờ giao
--1:đang giao
--2:đã giao
--3:bị hủy
alter table DONGIAO add constraint ck_TTGIAO check (TTGIAO between 0 and 3)

--ràng buộc lương nhân viên phải lớn hơn 0
alter table NHANVIEN add constraint ck_Luong check (LUONGNV >= 0)

--ràng buộc giá trị của giới tính nhân viên
alter table NHANVIEN add constraint ck_GioiTinhNV check (GIOITINHNV = 'Nam' or GIOITINHNV = 'Nu')

--ràng buộc giá trị của giới tính khách hàng
alter table KHACHHANG add constraint ck_GioiTinhKH check (GIOITINHKH = 'Nam' or GIOITINHKH = 'Nu')

--ràng buộc số lượng giao của CHITIETDG phải lớn hơn 0
alter table CHITIETDG add constraint ck_SoLuongGiao check (SOLUONGGIAO > 0)

--ràng buộc số lượng mua của CHITIETDM phải lớn hơn 0
alter table CHITIETDM add constraint ck_SoLuongMua check (SOLUONGMUA > 0)

--ràng buộc tiền giảm trong mã giảm giá phải lớn hơn 0
alter table MAGIAMGIA add constraint ck_TienGiam check (TIENGIAM > 0)

go
--ràng buộc ngày bắt đầu mã giảm giá phải nhỏ hơn ngày kết thúc mã giảm giá
ALTER trigger before_insert_MaGiamGia on MAGIAMGIA for insert
as
begin
	--nếu ngày bắt đầu lơn1 hơn ngày kết thúc thì rollback
	if((select NGAYKTMGG from inserted) != NULL)
	begin
		if((select NGAYBDMGG from inserted) > (select NGAYKTMGG from inserted))
		begin
			rollback tran
		end
	end
end

--ràng buộc phí của DOITACVANCHUYEN phải lớn hơn 0
alter table DOITACVANCHUYEN add constraint ck_Phi check (PHI > 0)

--ràng buộc số lượng trong chi tiết kho không được âm
alter table CHITIETKHO add constraint ck_SoLuongSanPhamKho check (SOLUONGSPHT >= 0 AND SOLUONGSPDG >= 0)
SET IDENTITY_INSERT dbo.SANPHAM ON