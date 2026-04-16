
CREATE DATABASE SchoolQA_V2;
GO
USE SchoolQA_V2;
GO

CREATE TABLE Categories (
    cateID INT PRIMARY KEY IDENTITY(1,1),
    cateName NVARCHAR(100)
);

CREATE TABLE Users (
    userID INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) UNIQUE,
    password VARCHAR(50),
    fullName NVARCHAR(100),
    role INT -- 1: Teacher, 0: Student
);

CREATE TABLE Questions (
    id INT PRIMARY KEY IDENTITY(1,1),
    title NVARCHAR(200),
    content NVARCHAR(MAX),
    cateID INT FOREIGN KEY REFERENCES Categories(cateID),
    userID INT FOREIGN KEY REFERENCES Users(userID),
    status INT DEFAULT 1,
    createdAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Answers (
    ansID INT PRIMARY KEY IDENTITY(1,1),
    content NVARCHAR(MAX),
    questionID INT FOREIGN KEY REFERENCES Questions(id),
    userID INT FOREIGN KEY REFERENCES Users(userID),
    isCorrect BIT DEFAULT 0,
    createdAt DATETIME DEFAULT GETDATE()
);

INSERT INTO Categories (cateName) VALUES 
(N'Lập trình Java'),
(N'Cơ sở dữ liệu'),
(N'Mạng máy tính'),
(N'Thủ tục hành chính'),
(N'Đời sống sinh viên');

-- 2. Chèn dữ liệu vào bảng Users (Tài khoản)
-- Role: 1 là Teacher (Giáo viên), 0 là Student (Sinh viên)
INSERT INTO Users (username, password, fullName, role) VALUES 
('gv_tam', '123', N'Thầy Lý Minh Tâm', 1),
('gv_hoa', '123', N'Cô Nguyễn Hồng Hoa', 1),
('anh_nd', '123', N'Nông Hoàng Duy Anh', 0),
('sv_test', '123', N'Sinh Viên Test', 0),
('hung_vt', '123', N'Vũ Thế Hùng', 0);

-- 3. Chèn dữ liệu vào bảng Questions (Câu hỏi)
-- cateID 1: Java, 2: DB, 4: Thủ tục
INSERT INTO Questions (title, content, cateID, userID, status) VALUES 
(N'Lỗi kết nối JDBC', N'Em dùng driver mssql nhưng bị báo lỗi ClassNotFound, thầy cô giúp em với!', 1, 3, 1),
(N'Cách dùng INNER JOIN', N'Làm sao để lấy dữ liệu từ 3 bảng cùng lúc trong SQL Server ạ?', 2, 5, 1),
(N'Lịch thi học kỳ 2', N'Cho em hỏi khi nào thì có lịch thi chính thức của kỳ Spring 2026 ạ?', 4, 3, 1),
(N'Cài đặt Tomcat 10', N'Servlet của em không chạy trên Tomcat 10, có cần lưu ý gì về Jakarta không ạ?', 1, 4, 1);

-- 4. Chèn dữ liệu vào bảng Answers (Câu trả lời)
-- userID 1 và 2 là giáo viên sẽ trả lời
INSERT INTO Answers (content, questionID, userID, isCorrect) VALUES 
(N'Em kiểm tra lại đã add file .jar vào thư mục WEB-INF/lib chưa nhé.', 1, 1, 1),
(N'Em dùng cú pháp: SELECT * FROM A JOIN B ON A.id = B.aid JOIN C ON B.id = C.bid.', 2, 2, 1),
(N'Dự kiến tuần sau sẽ có thông báo trên trang portal của trường em nhé.', 3, 1, 0);