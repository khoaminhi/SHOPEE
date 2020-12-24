/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2012                    */
/* Created on:     12/24/2020 12:24:01 PM                       */
/*==============================================================*/

use master
go

create database SHOPEE
go

use SHOPEE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDG') and o.name = 'FK_CHITIETD_CHITIETDG_DONGIAO')
alter table CHITIETDG
   drop constraint FK_CHITIETD_CHITIETDG_DONGIAO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDG') and o.name = 'FK_CHITIETD_DGSP_SANPHAM')
alter table CHITIETDG
   drop constraint FK_CHITIETD_DGSP_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDM') and o.name = 'FK_CHITIETD_CHITIETDM_DONMUA')
alter table CHITIETDM
   drop constraint FK_CHITIETD_CHITIETDM_DONMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETDM') and o.name = 'FK_CHITIETD_DMSP_SANPHAM')
alter table CHITIETDM
   drop constraint FK_CHITIETD_DMSP_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETKHO') and o.name = 'FK_CHITIETK_CHITIETKH_KHO')
alter table CHITIETKHO
   drop constraint FK_CHITIETK_CHITIETKH_KHO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('CHITIETKHO') and o.name = 'FK_CHITIETK_KHOSP_SANPHAM')
alter table CHITIETKHO
   drop constraint FK_CHITIETK_KHOSP_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DANHGIASP') and o.name = 'FK_DANHGIAS_DANGGIACU_SANPHAM')
alter table DANHGIASP
   drop constraint FK_DANHGIAS_DANGGIACU_SANPHAM
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DANHGIASP') and o.name = 'FK_DANHGIAS_DANHCUAKM_KHACHMUA')
alter table DANHGIASP
   drop constraint FK_DANHGIAS_DANHCUAKM_KHACHMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DIACHIKH') and o.name = 'FK_DIACHIKH_O_KHACHHAN')
alter table DIACHIKH
   drop constraint FK_DIACHIKH_O_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONGIAO') and o.name = 'FK_DONGIAO_CHO_KHACHMUA')
alter table DONGIAO
   drop constraint FK_DONGIAO_CHO_KHACHMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONGIAO') and o.name = 'FK_DONGIAO_LAY_KHO')
alter table DONGIAO
   drop constraint FK_DONGIAO_LAY_KHO
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONGIAO') and o.name = 'FK_DONGIAO_TU_DONMUA')
alter table DONGIAO
   drop constraint FK_DONGIAO_TU_DONMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONGIAO') and o.name = 'FK_DONGIAO_VANCHUYEN_DOITACVA')
alter table DONGIAO
   drop constraint FK_DONGIAO_VANCHUYEN_DOITACVA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('DONMUA') and o.name = 'FK_DONMUA_TAO_KHACHMUA')
alter table DONMUA
   drop constraint FK_DONMUA_TAO_KHACHMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KHACHBAN') and o.name = 'FK_KHACHBAN_CON2_KHACHHAN')
alter table KHACHBAN
   drop constraint FK_KHACHBAN_CON2_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KHACHMUA') and o.name = 'FK_KHACHMUA_CON1_KHACHHAN')
alter table KHACHMUA
   drop constraint FK_KHACHMUA_CON1_KHACHHAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('KHO') and o.name = 'FK_KHO_QUANLY_NHANVIEN')
alter table KHO
   drop constraint FK_KHO_QUANLY_NHANVIEN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MAGIAMKM') and o.name = 'FK_MAGIAMKM_CHITIETMG_MAGIAMGI')
alter table MAGIAMKM
   drop constraint FK_MAGIAMKM_CHITIETMG_MAGIAMGI
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MAGIAMKM') and o.name = 'FK_MAGIAMKM_MGGKH_KHACHMUA')
alter table MAGIAMKM
   drop constraint FK_MAGIAMKM_MGGKH_KHACHMUA
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAM') and o.name = 'FK_SANPHAM_THUOC_DANHMUC')
alter table SANPHAM
   drop constraint FK_SANPHAM_THUOC_DANHMUC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAMKB') and o.name = 'FK_SANPHAMK_DANG_KHACHBAN')
alter table SANPHAMKB
   drop constraint FK_SANPHAMK_DANG_KHACHBAN
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SANPHAMKB') and o.name = 'FK_SANPHAMK_SPCUAKH_SANPHAM')
alter table SANPHAMKB
   drop constraint FK_SANPHAMK_SPCUAKH_SANPHAM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDG')
            and   name  = 'DGSP_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDG.DGSP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDG')
            and   name  = 'CHITIETDG_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDG.CHITIETDG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETDG')
            and   type = 'U')
   drop table CHITIETDG
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDM')
            and   name  = 'DMSP_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDM.DMSP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETDM')
            and   name  = 'CHITIETDM_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETDM.CHITIETDM_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETDM')
            and   type = 'U')
   drop table CHITIETDM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETKHO')
            and   name  = 'KHOSP_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETKHO.KHOSP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('CHITIETKHO')
            and   name  = 'CHITIETKHOA_FK'
            and   indid > 0
            and   indid < 255)
   drop index CHITIETKHO.CHITIETKHOA_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('CHITIETKHO')
            and   type = 'U')
   drop table CHITIETKHO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DANHGIASP')
            and   name  = 'DANGGIACUASP_FK'
            and   indid > 0
            and   indid < 255)
   drop index DANHGIASP.DANGGIACUASP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DANHGIASP')
            and   name  = 'DANHCUAKM_FK'
            and   indid > 0
            and   indid < 255)
   drop index DANHGIASP.DANHCUAKM_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DANHGIASP')
            and   type = 'U')
   drop table DANHGIASP
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DANHMUC')
            and   type = 'U')
   drop table DANHMUC
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DIACHIKH')
            and   type = 'U')
   drop table DIACHIKH
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DOITACVANCHUYEN')
            and   type = 'U')
   drop table DOITACVANCHUYEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONGIAO')
            and   name  = 'TU_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONGIAO.TU_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONGIAO')
            and   name  = 'LAY_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONGIAO.LAY_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONGIAO')
            and   name  = 'VANCHUYEN_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONGIAO.VANCHUYEN_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONGIAO')
            and   name  = 'CHO_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONGIAO.CHO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DONGIAO')
            and   type = 'U')
   drop table DONGIAO
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('DONMUA')
            and   name  = 'TAO_FK'
            and   indid > 0
            and   indid < 255)
   drop index DONMUA.TAO_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('DONMUA')
            and   type = 'U')
   drop table DONMUA
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHACHBAN')
            and   type = 'U')
   drop table KHACHBAN
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHACHHANG')
            and   type = 'U')
   drop table KHACHHANG
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHACHMUA')
            and   type = 'U')
   drop table KHACHMUA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('KHO')
            and   name  = 'QUANLY_FK'
            and   indid > 0
            and   indid < 255)
   drop index KHO.QUANLY_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('KHO')
            and   type = 'U')
   drop table KHO
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MAGIAMGIA')
            and   type = 'U')
   drop table MAGIAMGIA
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MAGIAMKM')
            and   name  = 'MGGKH_FK'
            and   indid > 0
            and   indid < 255)
   drop index MAGIAMKM.MGGKH_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MAGIAMKM')
            and   name  = 'CHITIETMGG_FK'
            and   indid > 0
            and   indid < 255)
   drop index MAGIAMKM.CHITIETMGG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MAGIAMKM')
            and   type = 'U')
   drop table MAGIAMKM
go

if exists (select 1
            from  sysobjects
           where  id = object_id('NHANVIEN')
            and   type = 'U')
   drop table NHANVIEN
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAM')
            and   name  = 'THUOC_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAM.THUOC_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SANPHAM')
            and   type = 'U')
   drop table SANPHAM
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAMKB')
            and   name  = 'SPCUAKH_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAMKB.SPCUAKH_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SANPHAMKB')
            and   name  = 'DANG_FK'
            and   indid > 0
            and   indid < 255)
   drop index SANPHAMKB.DANG_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SANPHAMKB')
            and   type = 'U')
   drop table SANPHAMKB
go

/*==============================================================*/
/* Table: CHITIETDG                                             */
/*==============================================================*/
create table CHITIETDG (
   IDDG                 int                  not null,
   IDSP                 int                  not null,
   SOLUONGGIAO          int                  null
)
go

/*==============================================================*/
/* Index: CHITIETDG_FK                                          */
/*==============================================================*/
create index CHITIETDG_FK on CHITIETDG (
IDDG ASC
)
go

/*==============================================================*/
/* Index: DGSP_FK                                               */
/*==============================================================*/
create index DGSP_FK on CHITIETDG (
IDSP ASC
)
go

/*==============================================================*/
/* Table: CHITIETDM                                             */
/*==============================================================*/
create table CHITIETDM (
   IDDM                 int                  not null,
   IDSP                 int                  not null,
   SOLUONGMUA           int                  null
)
go

/*==============================================================*/
/* Index: CHITIETDM_FK                                          */
/*==============================================================*/
create index CHITIETDM_FK on CHITIETDM (
IDDM ASC
)
go

/*==============================================================*/
/* Index: DMSP_FK                                               */
/*==============================================================*/
create index DMSP_FK on CHITIETDM (
IDSP ASC
)
go

/*==============================================================*/
/* Table: CHITIETKHO                                            */
/*==============================================================*/
create table CHITIETKHO (
   IDSP                 int                  not null,
   IDKHO                int                  not null,
   SOLUONGSPHT          int                  not null,
   SOLUONGSPDG          int                  not null
)
go

/*==============================================================*/
/* Index: CHITIETKHOA_FK                                        */
/*==============================================================*/
create index CHITIETKHOA_FK on CHITIETKHO (
IDKHO ASC
)
go

/*==============================================================*/
/* Index: KHOSP_FK                                              */
/*==============================================================*/
create index KHOSP_FK on CHITIETKHO (
IDSP ASC
)
go

/*==============================================================*/
/* Table: DANHGIASP                                             */
/*==============================================================*/
create table DANHGIASP (
   IDSP                 int                  not null,
   IDKH                 int                  not null,
   DANHGIA              varchar(3000)        null
)
go

/*==============================================================*/
/* Index: DANHCUAKM_FK                                          */
/*==============================================================*/
create index DANHCUAKM_FK on DANHGIASP (
IDKH ASC
)
go

/*==============================================================*/
/* Index: DANGGIACUASP_FK                                       */
/*==============================================================*/
create index DANGGIACUASP_FK on DANHGIASP (
IDSP ASC
)
go

/*==============================================================*/
/* Table: DANHMUC                                               */
/*==============================================================*/
create table DANHMUC (
   IDDANHMUC            int                  not null,
   TENDANHMUC           varchar(40)          null,
   constraint PK_DANHMUC primary key nonclustered (IDDANHMUC)
)
go

/*==============================================================*/
/* Table: DIACHIKH                                              */
/*==============================================================*/
create table DIACHIKH (
   IDKH                 int                  not null,
   TINHKH               varchar(15)          not null,
   HUYENKH              varchar(25)          not null,
   XAKH                 varchar(25)          not null,
   NHAKH                varchar(50)          not null,
   constraint PK_DIACHIKH primary key (IDKH)
)
go

/*==============================================================*/
/* Table: DOITACVANCHUYEN                                       */
/*==============================================================*/
create table DOITACVANCHUYEN (
   IDDT                 int                  not null,
   TENDT                varchar(40)          not null,
   PHI                  money                not null,
   constraint PK_DOITACVANCHUYEN primary key nonclustered (IDDT)
)
go

/*==============================================================*/
/* Table: DONGIAO                                               */
/*==============================================================*/
create table DONGIAO (
   IDDG                 int                  not null,
   IDKHO                int                  not null,
   IDDM                 int                  not null,
   IDDT                 int                  not null,
   IDKH                 int                  not null,
   NGAYGIAO             datetime             null,
   TTGIAO               smallint             null,
   constraint PK_DONGIAO primary key nonclustered (IDDG)
)
go

/*==============================================================*/
/* Index: CHO_FK                                                */
/*==============================================================*/
create index CHO_FK on DONGIAO (
IDKH ASC
)
go

/*==============================================================*/
/* Index: VANCHUYEN_FK                                          */
/*==============================================================*/
create index VANCHUYEN_FK on DONGIAO (
IDDT ASC
)
go

/*==============================================================*/
/* Index: LAY_FK                                                */
/*==============================================================*/
create index LAY_FK on DONGIAO (
IDKHO ASC
)
go

/*==============================================================*/
/* Index: TU_FK                                                 */
/*==============================================================*/
create index TU_FK on DONGIAO (
IDDM ASC
)
go

/*==============================================================*/
/* Table: DONMUA                                                */
/*==============================================================*/
create table DONMUA (
   IDDM                 int                  not null,
   IDKH                 int                  not null,
   NGAYMUA              datetime             null,
   TTXEM                tinyint              not null,
   constraint PK_DONMUA primary key nonclustered (IDDM)
)
go

/*==============================================================*/
/* Index: TAO_FK                                                */
/*==============================================================*/
create index TAO_FK on DONMUA (
IDKH ASC
)
go

/*==============================================================*/
/* Table: KHACHBAN                                              */
/*==============================================================*/
create table KHACHBAN (
   IDKH                 int                  not null,
   MOTAKB               varchar(3000)        not null,
   ANHKB                varchar(50)          null,
   VIDEOKB              varchar(50)          null,
   HIEUQUAKB            smallint             not null,
   constraint PK_KHACHBAN primary key (IDKH)
)
go

/*==============================================================*/
/* Table: KHACHHANG                                             */
/*==============================================================*/
create table KHACHHANG (
   IDKH                 int                  not null,
   TENKH                varchar(40)          not null,
   GIOITINHKH           varchar(3)           not null,
   NGAYSINHKH           datetime             not null,
   EMAILKH              varchar(40)          not null,
   DIENTHOAIKH          char(10)             not null,
   TAIKHOANKH           varchar(16)          null,
   constraint PK_KHACHHANG primary key nonclustered (IDKH)
)
go

/*==============================================================*/
/* Table: KHACHMUA                                              */
/*==============================================================*/
create table KHACHMUA (
   IDKH                 int                  not null,
   ANHKM                varchar(50)          null,
   constraint PK_KHACHMUA primary key (IDKH)
)
go

/*==============================================================*/
/* Table: KHO                                                   */
/*==============================================================*/
create table KHO (
   IDKHO                int                  not null,
   IDNV                 int                  not null,
   TENKHO               varchar(40)          not null,
   DIACHIKHO            varchar(100)         not null,
   constraint PK_KHO primary key nonclustered (IDKHO)
)
go

/*==============================================================*/
/* Index: QUANLY_FK                                             */
/*==============================================================*/
create index QUANLY_FK on KHO (
IDNV ASC
)
go

/*==============================================================*/
/* Table: MAGIAMGIA                                             */
/*==============================================================*/
create table MAGIAMGIA (
   IDMGG                int                  not null,
   TENMGG               varchar(40)          not null,
   TIENGIAM             money                not null,
   MOTAMGG              varchar(500)         not null,
   NGAYBDMGG            datetime             not null,
   NGAYKTMGG            datetime             not null,
   constraint PK_MAGIAMGIA primary key nonclustered (IDMGG)
)
go

/*==============================================================*/
/* Table: MAGIAMKM                                              */
/*==============================================================*/
create table MAGIAMKM (
   IDMGG                int                  not null,
   IDKH                 int                  not null
)
go

/*==============================================================*/
/* Index: CHITIETMGG_FK                                         */
/*==============================================================*/
create index CHITIETMGG_FK on MAGIAMKM (
IDMGG ASC
)
go

/*==============================================================*/
/* Index: MGGKH_FK                                              */
/*==============================================================*/
create index MGGKH_FK on MAGIAMKM (
IDKH ASC
)
go

/*==============================================================*/
/* Table: NHANVIEN                                              */
/*==============================================================*/
create table NHANVIEN (
   IDNV                 int                  not null,
   TENNV                varchar(40)          not null,
   SDTNV                char(10)             not null,
   DIACHINV             varchar(100)         not null,
   EMAILNV              varchar(40)          not null,
   GIOITINHNV           varchar(3)           not null,
   NGAYSINHNV           datetime             not null,
   LUONGNV              money                not null,
   constraint PK_NHANVIEN primary key nonclustered (IDNV)
)
go

/*==============================================================*/
/* Table: SANPHAM                                               */
/*==============================================================*/
create table SANPHAM (
   IDSP                 int                  not null,
   IDDANHMUC            int                  not null,
   TENSP                varchar(100)         not null,
   MOTASP               varchar(3000)        not null,
   ANHSP                varchar(50)          not null,
   VIDEOSP              varchar(50)          null,
   THUONGHIEU           varchar(50)          not null,
   GIASP                money                not null,
   MASKU                varchar(20)          null,
   TINHTRANG_           tinyint              not null,
   constraint PK_SANPHAM primary key nonclustered (IDSP)
)
go

/*==============================================================*/
/* Index: THUOC_FK                                              */
/*==============================================================*/
create index THUOC_FK on SANPHAM (
IDDANHMUC ASC
)
go

/*==============================================================*/
/* Table: SANPHAMKB                                             */
/*==============================================================*/
create table SANPHAMKB (
   IDSP                 int                  not null,
   IDKH                 int                  not null,
   SOLUONGHT            int                  not null,
   SOLUONGDB            int                  not null
)
go

/*==============================================================*/
/* Index: DANG_FK                                               */
/*==============================================================*/
create index DANG_FK on SANPHAMKB (
IDKH ASC
)
go

/*==============================================================*/
/* Index: SPCUAKH_FK                                            */
/*==============================================================*/
create index SPCUAKH_FK on SANPHAMKB (
IDSP ASC
)
go

alter table CHITIETDG
   add constraint FK_CHITIETD_CHITIETDG_DONGIAO foreign key (IDDG)
      references DONGIAO (IDDG)
go

alter table CHITIETDG
   add constraint FK_CHITIETD_DGSP_SANPHAM foreign key (IDSP)
      references SANPHAM (IDSP)
go

alter table CHITIETDM
   add constraint FK_CHITIETD_CHITIETDM_DONMUA foreign key (IDDM)
      references DONMUA (IDDM)
go

alter table CHITIETDM
   add constraint FK_CHITIETD_DMSP_SANPHAM foreign key (IDSP)
      references SANPHAM (IDSP)
go

alter table CHITIETKHO
   add constraint FK_CHITIETK_CHITIETKH_KHO foreign key (IDKHO)
      references KHO (IDKHO)
go

alter table CHITIETKHO
   add constraint FK_CHITIETK_KHOSP_SANPHAM foreign key (IDSP)
      references SANPHAM (IDSP)
go

alter table DANHGIASP
   add constraint FK_DANHGIAS_DANGGIACU_SANPHAM foreign key (IDSP)
      references SANPHAM (IDSP)
go

alter table DANHGIASP
   add constraint FK_DANHGIAS_DANHCUAKM_KHACHMUA foreign key (IDKH)
      references KHACHMUA (IDKH)
go

alter table DIACHIKH
   add constraint FK_DIACHIKH_O_KHACHHAN foreign key (IDKH)
      references KHACHHANG (IDKH)
go

alter table DONGIAO
   add constraint FK_DONGIAO_CHO_KHACHMUA foreign key (IDKH)
      references KHACHMUA (IDKH)
go

alter table DONGIAO
   add constraint FK_DONGIAO_LAY_KHO foreign key (IDKHO)
      references KHO (IDKHO)
go

alter table DONGIAO
   add constraint FK_DONGIAO_TU_DONMUA foreign key (IDDM)
      references DONMUA (IDDM)
go

alter table DONGIAO
   add constraint FK_DONGIAO_VANCHUYEN_DOITACVA foreign key (IDDT)
      references DOITACVANCHUYEN (IDDT)
go

alter table DONMUA
   add constraint FK_DONMUA_TAO_KHACHMUA foreign key (IDKH)
      references KHACHMUA (IDKH)
go

alter table KHACHBAN
   add constraint FK_KHACHBAN_CON2_KHACHHAN foreign key (IDKH)
      references KHACHHANG (IDKH)
go

alter table KHACHMUA
   add constraint FK_KHACHMUA_CON1_KHACHHAN foreign key (IDKH)
      references KHACHHANG (IDKH)
go

alter table KHO
   add constraint FK_KHO_QUANLY_NHANVIEN foreign key (IDNV)
      references NHANVIEN (IDNV)
go

alter table MAGIAMKM
   add constraint FK_MAGIAMKM_CHITIETMG_MAGIAMGI foreign key (IDMGG)
      references MAGIAMGIA (IDMGG)
go

alter table MAGIAMKM
   add constraint FK_MAGIAMKM_MGGKH_KHACHMUA foreign key (IDKH)
      references KHACHMUA (IDKH)
go

alter table SANPHAM
   add constraint FK_SANPHAM_THUOC_DANHMUC foreign key (IDDANHMUC)
      references DANHMUC (IDDANHMUC)
go

alter table SANPHAMKB
   add constraint FK_SANPHAMK_DANG_KHACHBAN foreign key (IDKH)
      references KHACHBAN (IDKH)
go

alter table SANPHAMKB
   add constraint FK_SANPHAMK_SPCUAKH_SANPHAM foreign key (IDSP)
      references SANPHAM (IDSP)
go

