CREATE DATABASE SQLDBQuery
GO

-- sử dụng DB SQLDBQuery
USE SQLDBQuery
GO

-- tạo bảng Giáo viên có 2 thuộc tính
CREATE TABLE GiaoVien (
	MaGV nvarchar(10),
	Name nvarchar(100)
)

GO

CREATE TABLE HocSinh
(
	MaHS nvarchar(10),
	Name nvarchar(100)
)
GO
-- sửa bảng, thêm cột ngày sinh
ALTER TABLE HocSinh ADD NgaySinh DATE

 -- xóa toàn bộ dữ liệu của bảng
TRUNCATE TABLE HocSinh

-- Gỡ bảng khỏi DB
DROP TABLE HocSinh
GO


