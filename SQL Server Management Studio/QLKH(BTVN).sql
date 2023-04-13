CREATE TABLE GiangVien (
	GV# char(4) NOT NULL,
	HoTen nvarchar(30) NOT NULL,
	DiaChi nvarchar(20),
	NgaySinh date,
	CONSTRAINT KhoachinhG primary key(GV#)
);

ALTER TABLE GiangVien
ALTER COLUMN DiaChi nvarchar(50)

CREATE TABLE DeTai(
	DT# char(4) NOT NULL,
	TenDT nvarchar(30) NOT NULL,
	Cap nvarchar(15),
	KinhPhi integer,
	CONSTRAINT KhoachinhD primary key(DT#)
);

CREATE TABLE ThamGia(
	GV# char(4) NOT NULL,
	DT# char(4) NOT NULL,
	SoGio int,
	primary key(GV#, DT#),
	foreign key(GV#) references GiangVien (GV#),
	foreign key(DT#) references DeTai(DT#),
);

--drop table GiangVien



INSERT INTO GiangVien VALUES('GV01',N'Vũ Tuyết Trinh',N'Hoàng Mai, Hà Nội','1975/10/10'),
('GV02',N'Nguyễn Nhật Quang',N'Hai Bà Trưng, Hà Nội','1976/11/03'),
('GV03',N'Trần Đức Khánh',N'Đống Đa, Hà Nội','1977/06/04'),
('GV04',N'Nguyễn Hồng Phương',N'Tây Hồ, Hà Nội','1983/12/10'),
('GV05',N'Lê Thanh Hương',N'Hai Bà Trưng, Hà Nội','1976/10/10')



INSERT INTO DeTai VALUES ('DT01',N'Tính toán lưới',N'Nhà nước','700'),
('DT02',N'Phát hiện tri thức',N'Bộ','300'),
('DT03',N'Phân loại văn bản',N'Bộ','270'),
('DT04',N'Dịch tự động Anh Việt',N'Trường','30')



INSERT INTO ThamGia VALUES ('GV01','DT01','100'),
('GV01','DT02','80'),
('GV01','DT03','80'),
('GV02','DT01','120'),
('GV02','DT03','140'),
('GV03','DT03','150'),
('GV04','DT04','180')

select * from GiangVien 

--B
--1.	Đưa ra thông tin giảng viên có địa chỉ ở quận “Hai Bà Trưng”, sắp xếp theo thứ tự giảm dần của họ tên.

SELECT * from GiangVien
where DiaChi LIKE N'%Hai Bà Trưng%'
order by HoTen desc -- asc(tăng dần)

--2 	Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài “Tính toán lưới”.

SELECT HoTen, DiaChi, NgaySinh 
from GiangVien, ThamGia, DeTai
where GiangVien.GV# = ThamGia.GV# AND ThamGia.DT# 
= DeTai.DT# AND TenDT LIKE N'%Tính toán lưới%'

Select HoTen, DiaChi, NgaySinh
from GiangVien inner join ThamGia on GiangVien.GV# = ThamGia.GV#
inner join DeTai on ThamGia.DT# = DeTai.DT#
where DeTai.TenDT like N'%Tính toán lưới%'

--3.	Đưa ra danh sách gồm họ tên, địa chỉ, ngày sinh của giảng viên có tham gia vào đề tài “Phân loại văn bản” hoặc “Dịch tự động Anh Việt”.
Select HoTen, DiaChi, NgaySinh
from GiangVien 
inner join ThamGia on GiangVien.GV# = ThamGia.GV#
inner join DeTai on ThamGia.DT# = DeTai.DT#
where DeTai.TenDT like N'%Phân loại văn bản%' or DeTai.TenDT like N'%Dịch tự động Anh Việt%'

--4.	Cho biết thông tin giảng viên tham gia ít nhất 2 đề tài.

select * from GiangVien
where GV# in (
				select GV# from ThamGia
				group by GV# having count(DT#) >= 2
				)
 
--5.	Cho biết tên giảng viên tham gia nhiều đề tài nhất.

select HoTen from GiangVien
where GV# in (
				select GV# from ThamGia
				group by GV# having count(DT#) >= ALL(select count(DT#) from ThamGia group by GV#)
				)

	-- ít đề tài nhất : <= ALL

--6.	Đề tài nào tốn ít kinh phí nhất?
SELECT * FROM DeTai
where KinhPhi <= ALL (Select KinhPhi from DeTai)
 --- cách 2
SELECT * from DeTai
where KinhPhi = (SELECT min(KinhPhi) from DeTai)

--7.	Cho biết tên và ngày sinh của giảng viên sống ở quận Tây Hồ và tên các đề tài mà giảng viên này tham gia.

Select HoTen, NgaySinh, TenDT
from GiangVien 
inner join ThamGia on GiangVien.GV# = ThamGia.GV#
inner join DeTai on ThamGia.DT# = DeTai.DT#
where GiangVien.DiaChi like N'%Tây Hồ%'

 --- thêm (nếu có) cuối đề
Select HoTen, NgaySinh, TenDT
from GiangVien 
left join ThamGia on GiangVien.GV# = ThamGia.GV#
left join DeTai on ThamGia.DT# = DeTai.DT#
where GiangVien.DiaChi like N'%Hai Bà Trưng%'

--8.	Cho biết tên những giảng viên sinh trước năm 1980 và có tham gia đề tài “Phân loại văn bản”

Select HoTen from GiangVien 
inner join ThamGia on GiangVien.GV# = ThamGia.GV#
inner join DeTai on ThamGia.DT# = DeTai.DT#
where DeTai.TenDT like N'%Phân loại văn bản%' and GiangVien.NgaySinh < '1/1/1980'


--9.	Đưa ra mã giảng viên, tên giảng viên và tổng số giờ tham gia nghiên cứu khoa học của từng giảng viên.
	-- có thể dùng as "Tổng số giờ"

select GiangVien.GV#, GiangVien.HoTen, sum(SoGio) as [Tổng số giờ]
from GiangVien  left join ThamGia on GiangVien.GV# = ThamGia.GV#
group by GiangVien.GV#, GiangVien.HoTen


-- 10. Cho biết thông tin giảng viên >= 40 tuổi tính đến thời điểm hiện tại

Select * from GiangVien
where YEAR(GETDATE())- YEAR(NgaySinh) >= 40

--11.	Giảng viên Ngô Tuấn Phong sinh ngày 08/09/1986 địa chỉ Đống Đa, Hà Nội mới tham gia nghiên cứu đề tài khoa học. Hãy thêm thông tin giảng viên này vào bảng GiangVien.

Insert into GiangVien
values ('GV06', N'Ngô Tuấn Phong', N'Đống Đa, Hà Nội', '08/09/1986')

select * from GiangVien

--12.	Giảng viên Vũ Tuyết Trinh mới chuyển về sống tại quận Tây Hồ, Hà Nội. Hãy cập nhật thông tin này.

Update GiangVien
set DiaChi = N'Tây Hồ, Hà Nội', NgaySinh = '1973-9-28'
where HoTen = N'Vũ Tuyết Trinh'

--13.	Giảng viên có mã GV02 không tham gia bất kỳ đề tài nào nữa. Hãy xóa tất cả thông tin liên quan đến giảng viên này trong CSDL.
delete from ThamGia where GV# = 'GV02'
delete from GiangVien where GV# = 'GV02'

-- 14. Đưa ra thông tin giảng viên ko tham gia đề tài nào
 select * from GiangVien
 where GV# not in (select GV# from ThamGia)

 select * from GiangVien
 where not exists(select * from ThamGia 
						where GiangVien.GV# = ThamGia.GV#)


select * from GiangVien 
where GV# in (
				select GV# from GiangVien
				except 
				select GV# from ThamGia
			)