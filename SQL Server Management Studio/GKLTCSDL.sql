--1. Tao bang
create table SinhVien (
	SV# char(8) NOT NULL,
	HoTen nvarchar(30) NOT NULL,
	Lop nvarchar (20),
	QueQuan nvarchar(50),
	NgaySinh date,
	constraint KhoaChinhS primary key(SV#)
);

create table MonThi (
	MT# char(8) not null,
	TenMon nvarchar(30) not null,
	SoTinChi int,
	constraint KhoaChinhM primary key(MT#)
);

create table KetQua (
	SV# char(8) NOT NULL,
	MT# char(8) not null,
	Diem float,
	primary key(SV#, MT#),
	foreign key(SV#) references SinhVien (SV#),
	foreign key(MT#) references MonThi(MT#),
);

--2. Truy van SQL
--a. Đưa ra thông tin sinh viên có quê quán ở Hải Dương

select * from SinhVien
where QueQuan like N'%Hải Dương%'

--b. Đưa ra mã số, họ tên của các sinh viên thi môn tên là "Cơ sở dữ liệu".

select S.SV#, HoTen from SinhVien S
inner join KetQua K on K.SV# = S.SV#
inner join MonThi M on M.MT# = K.MT#
where TenMon = N'Cơ sở dữ liệu' 

--c. Cho biết tổng điểm thi tất cả các môn của sinh viên có mã số là "20111625".

select sum(Diem) as N'Tổng điểm thi' from KetQua
where SV# = '20111625'

--d. Cho biết thông tin những sinh viên đạt tổng điểm cao nhất của kỳ thi.

select * from SinhVien
where SV# in
(
	select SV# from KetQua
	group by SV#
	having sum(Diem) >= ALL(select sum(Diem) from KetQua 
							group by SV# )
)