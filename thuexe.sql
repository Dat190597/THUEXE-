create database THUEXE
use THUEXE
 -- tạo bảng-------------
 create table HANGSX(
	[HSX_ID] varchar(5) PRIMARY KEY,
	[HSX_TEN] varchar(30) NOT NULL
 )

 create table LOAIXE(
	[LX_ID] varchar(10) PRIMARY KEY,
	[LX_TEN] nvarchar(50) NOT NULL
)

create table KHACHHANG(
	[KH_CMND] char(9) PRIMARY KEY,
	[KH_TEN] nvarchar(80) NOT NULL
)

create table TTXE(
	[TTX_BSX] varchar(10) PRIMARY KEY,
	[LX_ID] varchar(10) NOT NULL,
	[HSX_ID] varchar(5) NOT NULL,
	[DONGIA] varchar(10) NOT NULL,
	[TTX_TRANGTHAI] nvarchar(30) NOT NULL default N'trống'
)

create table NDBAOTRI(
	[NDBT_ID] varchar(30) PRIMARY KEY CONSTRAINT df_NDBT_ID DEFAULT dbo.AUTO_ID('NDBAOTRI'),
	[NDBT_ND] ntext NOT NULL,
	[NDBT_CHIPHI] int NOT NULL,
	[NDBT_NGAYBT] date NOT NULL,
	[TTX_BSX] varchar(10) NOT NULL
)

create table CHUCVU(
	[CV_ID] char(2) PRIMARY KEY,
	[CV_TEN] nvarchar(20) NOT NULL
)

create table NHANVIEN(
	[NV_ID] varchar(30) PRIMARY KEY CONSTRAINT df_NV_ID DEFAULT dbo.AUTO_ID('NHANVIEN'),
	[NV_TEN] nvarchar(80) NOT NULL,
	[CV_ID] char(2) NOT NULL
)

create table CHITIETTHUE(
	[CTT_ID] varchar(30) PRIMARY KEY CONSTRAINT df_CTT_ID DEFAULT dbo.AUTO_ID('CHITIETTHUE'),
	[CTT_TGLX] varchar(2) NOT NULL,
	[CTT_TGTX] varchar(2) NOT NULL,
	[CTT_NGAY] date DEFAULT GETDATE(),
	[CTT_TGTXTT] varchar(2),
	[CTT_TONGTIEN] int,
	[CTT_TIENNG] int,
	[NV_ID] varchar(30) NOT NULL,
	[TTX_BSX] varchar(10) NOT NULL,
	[KH_CMND] char(9)NOT NULL,
	[DGQG_ID] varchar(5) NOT NULL
)


create table DONGIAQG(
	DGQG_ID varchar(5) PRIMARY KEY,
	DGQG_DONGIA varchar(5)
)


--ràng buộc-------------------


-- fk -- TTXE
alter table TTXE add constraint fk_LX_ID_TTXE foreign key(LX_ID) references LOAIXE(LX_ID)  on update cascade on delete cascade
alter table TTXE add constraint fk_HSX_ID_TTXE foreign key(HSX_ID) references HANGSX(HSX_ID) on update cascade on delete cascade

-- fk -- NDBAOTRI 
alter table NDBAOTRI add constraint fk_TTX_BSX_TTXE foreign key(TTX_BSX) references TTXE(TTX_BSX)  on update cascade on delete cascade

-- fk -- NHANVIEN
alter table NHANVIEN add constraint fk_CV_ID_NHANVIEN foreign key(CV_ID) references CHUCVU(CV_ID)  on update cascade on delete cascade

-- fk -- CHITIETTHUE
alter table CHITIETTHUE add constraint fk_NV_ID_CHITIETTHUE foreign key(NV_ID) references NHANVIEN(NV_ID) on update cascade on delete cascade
alter table CHITIETTHUE add constraint fk_TTX_BSX_CHITIETTHUE foreign key(TTX_BSX) references TTXE(TTX_BSX) on update cascade on delete cascade
alter table CHITIETTHUE add constraint fk_KH_CMND_CHITIETTHUE foreign key(KH_CMND) references KHACHHANG(KH_CMND) on update cascade on delete cascade
alter table CHITIETTHUE add constraint fk_KH_DGQG_ID_CHITIETTHUE foreign key(DGQG_ID) references DONGIAQG(DGQG_ID) on update cascade on delete cascade



-- df -- 
alter table NDBAOTRI drop constraint df_NDBT_ID
alter table NHANVIEN drop constraint df_NV_ID
alter table CHITIETTHUE drop constraint df_CTT_ID

alter table NDBAOTRI add constraint df_NDBT_ID default dbo.AUTO_ID('NDBAOTRI') for NDBT_ID 
alter table NHANVIEN add constraint df_NV_ID default dbo.AUTO_ID('NHANVIEN') for NV_ID
alter table CHITIETTHUE add constraint df_CTT_ID default dbo.AUTO_ID('CHITIETTHUE') for CTT_ID

--thêm dữ liệu----------------------------------

-- CHUCVU
insert into CHUCVU values ('nv', N'Nhân viên')
insert into CHUCVU values ('ql', N'Quản lý')

select * from CHUCVU

-- NHANVIEN
insert into NHANVIEN(NV_TEN, CV_ID) values (N'Nguyễn Tấn Đạt', 'nv')
insert into NHANVIEN(NV_TEN, CV_ID) values (N'Lê Chí Nhân', 'nv')
insert into NHANVIEN(NV_TEN, CV_ID) values (N'Trần Kim Quốc', 'ql')

select * from NHANVIEN

-- LOAIXE
insert into LOAIXE values('4c',N'xe 4 chổ')
insert into LOAIXE values('7c',N'xe 7 chổ')
insert into LOAIXE values('16c',N'xe 16 chổ')
insert into LOAIXE values('29c',N'xe 29 chổ')
insert into LOAIXE values('n3.5t',N'xe tải dưới 3.5 tấn')
insert into LOAIXE values('l3.5t',N'xe tải trên 3.5 tấn') 
delete from LOAIXE

select * from LOAIXE

-- HANGSX
insert into HANGSX values ('tyt','toyota')
insert into HANGSX values ('md','mazda')
insert into HANGSX values ('sbr','subaru')
insert into HANGSX values ('ad','audi')
insert into HANGSX values ('vf','vinfast')
insert into HANGSX values ('hd','honda')

select * from HANGSX

-- TTXE
insert into TTXE values('95A31471','4c','hd','100000', N'trống')
select * from TTXE

-- FUNCTION ----------------------------------------------------------------
-- function tạo ID NDBAOTRI NHANVIEN CHITIETTHUE

create function AUTO_ID( @table varchar(20))
returns varchar(30)
as
begin
	declare @ID varchar(30);

	if(@table = 'NDBAOTRI' )
		begin
			select @ID = max(NDBT_ID) from NDBAOTRI;
			if((select count(NDBT_ID) from NDBAOTRI) <> 0 AND SUBSTRING(@ID,3,4) = year(getdate()))
			begin
				set @ID = 'BT' + format(getdate(),'yyyymmdd') + '_' +  convert(char,convert(int,SUBSTRING(@ID,12,len(SUBSTRING(@ID,12,len(@ID)-11))))+1);
			end
			else
			begin
				set @ID ='0';
				set @ID = 'BT' + format(getdate(),'yyyymmdd') + '_' + convert(char,convert(int,right(@ID,1))+1);
			end
		end		
	else if(@table = 'NHANVIEN' )
	
		begin
			select @ID = max(NV_ID) from NHANVIEN;
			if((select count(NV_ID) from NHANVIEN) <> 0 AND SUBSTRING(@ID,3,4) = year(getdate()))
			begin
				set @ID = 'NV' + format(getdate(),'yyyymmdd') + '_' +  convert(char,convert(int,SUBSTRING(@ID,12,len(SUBSTRING(@ID,12,len(@ID)-11))))+1);
			end
			else
			begin
				set @ID ='0';
				set @ID = 'NV' + format(getdate(),'yyyymmdd') + '_' + convert(char,convert(int,right(@ID,1))+1);
			end
		end
	else if(@table = 'CHITIETTHUE' )
		begin
			select @ID = max(CTT_ID) from CHITIETHUE;
			if((select count(CTT_ID) from CHITIETHUE) <> 0 AND SUBSTRING(@ID,4,4) = year(getdate()))
			begin
				set @ID = 'CTT' + format(getdate(),'yyyymmdd') + '_' +  convert(char,convert(int,SUBSTRING(@ID,13,len(SUBSTRING(@ID,13,len(@ID)-12))))+1);
			end
			else
			begin
				set @ID ='0';
				set @ID = 'CTT' + format(getdate(),'yyyymmdd') + '_' + convert(char,convert(int,right(@ID,1))+1);
			end
		end
	return @ID;
		
end


select convert(datetime2,'2019-05-29 10')



-- STORE PROCEDURE ----------------------------------------------------------

-- TTXE ---------------------------------------------------------------------------------------
---------------- showTTXE-------------------
create proc showTTXE 
as
begin
	select * from TTXE order by TTX_BSX
end

exec showTTXE


---------------- insertTTXE-------------------
create proc insertTTXE
	@TTX_BSX varchar(10),
	@LX_ID varchar(10),
	@HSX_ID varchar(5),
	@TTX_DONGIA varchar(10)
as
begin
	insert into TTXE(TTX_BSX,LX_ID,HSX_ID,DONGIA) values(@TTX_BSX, @LX_ID, @HSX_ID, @TTX_DONGIA)
end

exec insertTTXE '65A123456', '7c', 'tyt', '200000'


---------------- updateTTXE-------------------
create proc updateTTXE
@TTX_BSX varchar(10),
@TTX_DONGIA varchar(10)
as
begin
	update TTXE set DONGIA = @TTX_DONGIA where TTX_BSX = @TTX_BSX
end

exec updateTTXE '65A123456','300000'


---------------- deleteTTXE-------------------
create proc deleteTTXE
@TTX_BSX varchar(10)
as
begin
	delete from TTXE where TTX_BSX = @TTX_BSX
end

exec deleteTTXE '65A123456'

-- HANGSX -----------------------------------------------------------------------------------------

create proc showHANGSX
as
begin
	select * from HANGSX order by HSX_ID
end

exec showHANGSX
-- LOAIXE -----------------------------------------------------------------------------------------

create proc showLOAIXE
as
begin
	select * from LOAIXE order by LX_ID
end

exec showLOAIXE