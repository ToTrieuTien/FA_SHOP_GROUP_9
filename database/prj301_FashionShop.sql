USE PRJ_FashionShop;
GO

-- 1. Xóa các bảng cũ theo đúng thứ tự để không dính lỗi khóa ngoại
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductImages;
DROP TABLE IF EXISTS ProductVariants;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
GO

-- ==========================================
-- 2. TẠO LẠI CÁC BẢNG (TABLES) CHUẨN XÁC
-- ==========================================

-- Bảng Roles 
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY,
    RoleName NVARCHAR(50) NOT NULL
);

-- Bảng Users (Mở rộng UserID lên VARCHAR(20) để chứa đủ SE193621...)
CREATE TABLE Users (
    UserID VARCHAR(20) PRIMARY KEY,   
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Address NVARCHAR(255),
    RoleID INT FOREIGN KEY REFERENCES Roles(RoleID),
    Status BIT DEFAULT 1              
);

-- Bảng Categories (Chuẩn 100%: Chỉ có ID, Tên, Trạng thái - KHÔNG CÓ CỘT DESCRIPTION)
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Status BIT DEFAULT 1
);

-- Bảng Products (Có cột Description cho Sản phẩm)
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    BasePrice DECIMAL(18, 2) NOT NULL,       
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID),
    Status BIT DEFAULT 1                     
);

-- Bảng ProductImages
CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    ImageURL VARCHAR(255) NOT NULL,
    IsPrimary BIT DEFAULT 1                  
);

-- Bảng Orders
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID VARCHAR(20) FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalMoney DECIMAL(18, 2),
    ShippingAddress NVARCHAR(255),
    Phone VARCHAR(20),
    Status NVARCHAR(50) DEFAULT N'Pending'   
);

-- Bảng OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    Price DECIMAL(18, 2) NOT NULL
);

-- Bảng ProductVariants
CREATE TABLE ProductVariants (
    VariantID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Size VARCHAR(10),
    Color NVARCHAR(50),
    StockQuantity INT DEFAULT 0
);

-- Bảng Reviews 
CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    UserID VARCHAR(20) FOREIGN KEY REFERENCES Users(UserID),
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Comment NVARCHAR(MAX),
    ReviewDate DATETIME DEFAULT GETDATE()
);
GO

-- ==========================================
-- 3. THÊM DỮ LIỆU MẪU ĐỂ CHẠY WEB
-- ==========================================

-- Thêm quyền
INSERT INTO Roles (RoleID, RoleName) VALUES (1, 'Admin'), (2, 'Customer');

-- Thêm tài khoản các thành viên trong nhóm
INSERT INTO Users (UserID, FullName, Email, Password, Phone, Address, RoleID, Status) 
VALUES 
('SE000000', N'Quản Trị Viên', 'admin@fashop.com', '123', '0123456789', N'FPTU', 1, 1),
('SE193160', N'Ngô Đức Tài', 'taingo1181@gmail.com', '7', '0913573096', N'Vinhome Grand Park, Quận 9 HCM', 1, 1),
('SE196703', N'Tô Triệu Tiến', 'totien@gmail.com', '1', '0123456789', N'Vinhome Grand Park, Quận 9 HCM', 1, 1),
('SE193621', N'Phạm Gia Huy', 'giahuypham1234@gmail.com', '1', '1234567891', N'Vinhome Grand Park, Quận 9 HCM', 1, 1),
('SE000004', N'Cristiano Ronaldo', 'ronaldo@gmail.com', '1', '0000000007', N'Bồ Đào Nha', 2, 1),
('SE000005', N'Lionel Messi', 'messi@gmail.com', '1', '0000000010', N'Argentina', 2, 1),
('SE000006', N'Neymar Jr', 'neymar@gmail.com', '1', '0000000011', N'Brazil', 2, 1);

-- Thêm Danh mục (Đã xóa cột Description cho khớp với bảng)
INSERT INTO Categories (CategoryName, Status) VALUES (N'Áo Polo (Nam)', 1);
INSERT INTO Categories (CategoryName, Status) VALUES (N'Quần Jean', 1);
INSERT INTO Categories (CategoryName, Status) VALUES (N'Phụ Kiện', 1);

-- Thêm Sản phẩm
INSERT INTO Products (ProductName, Description, BasePrice, CategoryID, Status)
VALUES 
(N'Áo Polo Monogram', N'Chất liệu cotton 100%, họa tiết in chìm', 450000, 1, 1),
(N'Quần Jean Slimfit Blue', N'Denim cao cấp, bền màu', 650000, 2, 1),
(N'Ví Da Fendi Black', N'Da bò thật 100%, ngăn chứa rộng', 1200000, 3, 1);

-- Thêm ảnh
INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) 
VALUES 
(1, 'polo_monogram.png', 1),
(2, 'jeans_blue.png', 1),
(3, 'wallet_fendi.png', 1);
GO