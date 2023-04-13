create table student(
StudentID varchar(8) not null Primary key,
Name nvarchar(50) not null,
Address nvarchar(50) not null
);

create table subject(
SubjectCode varchar(10) not null Primary key,
Name nvarchar(50) not null,
Faculty nvarchar(50) not null
);

create table take(
StudentID varchar(8) not null,
SubjectCode varchar(10) not null,
Foreign key (SubjectCode) references subject (SubjectCode),
Foreign key (StudentID) references student (StudentID),
);

/*
drop table take
drop table student
drop table subject
*/

Insert into subject values ('IT3292', 'Database', 'CNTT'),
('FE2020', 'KTD', 'Co khi dong luc'),
('RD5655', 'Math', 'Toan'),
('IT2020', 'C', 'CNTT'),
('IT1010', 'Python', 'CNTT'),
('IT9595', 'C+', 'CNTT')

Insert into student values ('20194588', 'Pham Duc Huy', 'HaiDuong'),
('20194593', 'Nguyen Thuy', 'Ha Noi'),
('20194595', 'Pham Chung', 'Hai Phong'),
('20194596', 'Nguyen Manh', 'Ninh Binh'),
('20194597', 'Do Hieu', 'Ba Dinh'),
('20194598', 'Dinh Ha', 'HaiDuong')


Insert into take values ('20194588', 'IT3292'),
('20194593', 'IT3292'),
('20194595', 'IT3292'),
('20194596', 'IT3292'),
('20194597', 'IT3292'),
('20194588', 'FE2020'),
('20194593', 'RD5655'),
('20194596', 'IT2020'),
('20194595', 'IT2020'),
('20194597', 'IT1010'),
('20194598', 'IT9595')

Insert into student values ('20194400', 'Phan Huy', 'HaiDuong'),
('20194401', 'Phan Huy', 'HaiDuong'),
('20194402', 'Tran Huy', 'HaiDuong'),
('20194403', 'Phan Kim', 'HaiDuong'),
('20194404', 'Do Huy', 'Hai Phong'),
('20194405', 'Phan Nhat Huy', 'Hai Phong'),
('20194406', 'Phan Hieu', 'Ba Dinh'),
('20194407', 'Phan Lam', 'Ba Dinh'),
('20194408', 'Tran Huy', 'Ninh Binh'),
('20194409', 'Phan Huy', 'Ninh Binh')

select Address from student
where name like '% Huy'
group by Address
having count(StudentID) > 1 and count(StudentID like '%5%') > 1