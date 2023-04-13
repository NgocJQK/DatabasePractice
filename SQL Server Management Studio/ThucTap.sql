

-- Câu hỏi 1: Tạo DB
CREATE TABLE Khoa(
	makhoa char(10) primary key,
	tenkhoa char(30),
	dienthoai char(10)
);

CREATE TABLE GiangVien (
	magv int primary key,
	hotengv char(30),
	luong decimal(5,2),
	makhoa char(10) references Khoa
	
);

CREATE TABLE SinhVien (
	masv int primary key,
	hotensv char(30),
	makhoa char(10) foreign key references Khoa,
	namsinh int,
	quequan char(30)
);

CREATE TABLE DeTai(
	madt char(10) primary key,
	tendt char(30),
	kinhphi int,
	noithuctap char(30)
);

CREATE TABLE HuongDan(
	masv int primary key,
	madt char(10) foreign key references DeTai,
	magv int foreign key references GiangVien,
	ketqua decimal(5,2)
);

insert into Khoa values
('Geo', 'Dia ly va QLTN', '3855413'),
('Math', 'Toan', '3855411'),
('Bio', 'Cong nghe Sinh hoc', '3855412');
INSERT INTO Khoa VALUES
('JK','JoshiKousei',3855416);
-- insert dữ liệu số thì ko cần cho vào '', ký tự thì cần cho vào ''
INSERT INTO Khoa VALUES
(1, 1, 1);


insert into GiangVien values
('11', 'Thanh Xuan', '700', 'Geo');
insert into GiangVien values
(12, 'Thu Minh', 500, 'Math');
insert into GiangVien values
('13', 'Chu Tuan', '650', 'Geo'),
(14, 'Le Thi Lan', '500', 'Bio'),
(15, 'Tran Xoay', 900, 'Math');

insert into SinhVien values
(1, 'Le Van Sao', 'Bio', 1990, 'Nghe An'),
(2, 'Nguyen Thi My', 'Geo', 1990 , 'Thanh Hoa'),
(3, 'Bui Xuan Duc', 'Math', 1992, 'Ha Noi'),
(4, 'Nguyen Van Tung', 'Bio', null, 'Ha Tinh'),
(5, 'Le Khanh Linh', 'Bio', 1989, 'Ha Nam'),
(6, 'Tran Khac Trong', 'Geo', 1991, 'Thanh Hoa'),
(7, 'Le Thi Van', 'Math', null, null),
(8, 'Hoang Van Duc', 'Bio', 1992, 'Nghe An');

insert into DeTai values
('Dt01', 'GIS', 100, 'Nghe An'),
('Dt02', 'ARC GIS', 500, 'Nam Dinh'),
('Dt03', 'Spatial DB', 100, 'Ha Tinh'),
('Dt04', 'MAP', 300, 'Quang Binh');

insert into HuongDan values
(1, 'Dt01', 13, 8),
(2, 'Dt03', 14, 0),
(3, 'Dt03', 12, 10),
(5, 'Dt04', 14, 7),
(6, 'Dt01', 13, null),
(7, 'Dt04', 11, 10),
(8, 'Dt03', 15, 6);
insert into HuongDan values
(4, 'Dt03', 14, 9);

-- câu hỏi 2: Đưa ra thông tin gồm mã số, họ tên và tên khoa của tất cả các giảng viên
select magv, hotengv, tenkhoa from GiangVien
inner join Khoa on GiangVien.makhoa = Khoa.makhoa

-- câu hỏi 3: Sử dụng lệch xuất ra mã số, họ tên, tên khoa của các giảng viên hướng dẫn từ 3 sv trở lên
select GV.magv, hotengv, tenkhoa from GiangVien GV
inner join Khoa K on K.makhoa = GV.makhoa
inner join HuongDan HD on GV.magv = HD.magv
group by GV.magv, hotengv, tenkhoa
having count(masv) >= 3

select GV.magv, hotengv, tenkhoa from GiangVien GV
inner join Khoa K on K.makhoa = GV.makhoa
where magv in 
(
	select magv from HuongDan
	group by magv
	having count(masv) >=3 
)

-- câu hoi4 : xuất ra thông tin về những sinh viên chưa có điểm thực tập
select * from SinhVien
where masv in
(
	select masv from HuongDan
	where ketqua is null
)

-- câu hỏi 5: xuất ra sdt của khoa mà sinh viên có tên 'Le van sao' đang theo học
select dienthoai from Khoa
where makhoa in
(
	select makhoa from SinhVien
	where hotensv = 'Le van sao'
)

-- câu hỏi 6: lấy ra mã số và tên các đề tài có nhiều hơn 2 sinh viên tham gia thực tập
select madt, tendt from DeTai
where madt in
(
	select madt from HuongDan
	group by madt
	having count(masv) > 2
)

-- câu hỏi 7: lấy ra mã số, tên đề tài của đề tài có kinh phí cao nhất
select madt, tendt from DeTai
where kinhphi >= ALL(select kinhphi from Detai)

select madt, tendt from DeTai
where kinhphi = (select max(kinhphi) from DeTai)

-- câu hỏi 8: xuất ra tên khoa, số lượng sinh viên mỗi khoa
select tenkhoa, count(masv) 'số lượng sinh viên' from Khoa
inner join SinhVien on SinhVien.makhoa = Khoa.makhoa
group by Khoa.tenkhoa

-- câu hỏi 9: xuất ra mã số, họ tên và điểm của các sinh viên khoa "Dia ly va QLTN'
select SV.masv, hotensv , ketqua from SinhVien SV
inner join HuongDan HD on SV.masv = HD.masv
inner join Khoa on SV.makhoa = Khoa.makhoa
where tenkhoa = 'Dia ly va QLTN'

-- câu hỏi 10: xuất ra danh sách gồm mã số, họ tên và tuổi của các sinh viên khoa "toan"
select masv, hotensv, YEAR(getdate()) - namsinh 'Tuổi' from SinhVien
where makhoa in
(
	select makhoa from Khoa
	where tenkhoa = 'Toan'	
)
