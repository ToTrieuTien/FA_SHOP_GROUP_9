USE PRJ_FashionShop;
GO

-- 1. Xóa sạch dấu vết cũ
DROP TABLE IF EXISTS Reviews; DROP TABLE IF EXISTS OrderDetails; DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductImages; DROP TABLE IF EXISTS ProductVariants; DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories; DROP TABLE IF EXISTS Users; DROP TABLE IF EXISTS Roles;
GO

-- 2. Tạo bảng Roles và Users
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY, 
    RoleName NVARCHAR(50) NOT NULL
);

CREATE TABLE Users (
    UserID VARCHAR(20) PRIMARY KEY, 
    FullName NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE, 
    Password VARCHAR(100) NOT NULL,
    Phone VARCHAR(20), 
    Address NVARCHAR(255),
    RoleID INT FOREIGN KEY REFERENCES Roles(RoleID), 
    Status BIT DEFAULT 0, -- Mặc định là 0: Chưa xác thực 
    VerificationCode VARCHAR(100) -- Thêm cột lưu mã xác thực trực tiếp tại đây 
);

-- 3. Tạo bảng Categories
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX), 
    Status BIT DEFAULT 1
);

-- 4. Tạo bảng Products và ProductVariants
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX), 
    BasePrice DECIMAL(18, 2) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID), 
    Status BIT DEFAULT 1
);

CREATE TABLE ProductVariants (
    VariantID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Size VARCHAR(10), 
    Color NVARCHAR(50), 
    StockQuantity INT DEFAULT 0
);

-- 5. Tạo bảng Orders và OrderDetails
CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY, 
    UserID VARCHAR(20) FOREIGN KEY REFERENCES Users(UserID),
    OrderDate DATETIME DEFAULT GETDATE(), 
    TotalMoney DECIMAL(18, 2),
    ShippingAddress NVARCHAR(255), 
    Phone VARCHAR(20), 
    Status NVARCHAR(50) DEFAULT N'Pending'
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    VariantID INT FOREIGN KEY REFERENCES ProductVariants(VariantID), 
    Quantity INT NOT NULL, 
    Price DECIMAL(18, 2) NOT NULL
);

CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID), 
    ImageURL VARCHAR(255) NOT NULL, 
    IsPrimary BIT DEFAULT 1
);
GO

-- =========================================================
-- 6. CHÈN DỮ LIỆU
-- =========================================================

INSERT INTO Roles (RoleID, RoleName) VALUES (1, 'Admin'), (2, 'Customer');

-- Chèn dữ liệu Users (Status = 1 cho các tài khoản có sẵn để đăng nhập được ngay)
INSERT INTO Users (UserID, FullName, Email, Password, Phone, Address, RoleID, Status, VerificationCode) VALUES 
('SE193160', N'Ngô Đức Tài', 'taingo1181@gmail.com', '1', '0913573096', N'Vinhome Q9', 1, 1, NULL),
('SE193621', N'Phạm Gia Huy', 'giahuypham1234@gmail.com', '1', '1234567891', N'Vinhome Q9', 1, 1, NULL),
('SE196703', N'Tô Triệu Tiến', 'totien@gmail.com', '1', '0123456789', N'Vinhome Q9', 1, 1, NULL),
('SE000004', N'Cristiano Ronaldo', 'ronaldo@gmail.com', '1', '0000000007', N'Bồ Đào Nha', 2, 1, NULL),
('SE000005', N'Lionel Messi', 'messi@gmail.com', '1', '0000000010', N'Argentina', 2, 1, NULL),
('SE000006', N'Neymar Jr', 'neymar@gmail.com', '1', '0000000011', N'Brazil', 2, 1, NULL);

INSERT INTO Categories (CategoryName, Description) VALUES 
(N'Áo Polo', N'Áo thun có cổ sang trọng'), 
(N'Quần Jean', N'Quần jean denim'), 
(N'Phụ Kiện', N'Thắt lưng ví da');

INSERT INTO Products (ProductName, Description, BasePrice, CategoryID, Status) VALUES 
(N'Áo Polo Monogram', N'Cotton 100%', 450000, 1, 1),
(N'Quần Jean Slimfit Blue', N'Denim cao cấp', 650000, 2, 1),
(N'Ví Da Fendi Black', N'Da bò thật', 1200000, 3, 1);

INSERT INTO ProductVariants (ProductID, Size, Color, StockQuantity) VALUES 
(1, 'L', 'Black', 50), (2, '32', 'Blue', 40), (3, 'None', 'Black', 30);

INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) VALUES 
(1, 'polo.png', 1), (2, 'jean.png', 1), (3, 'fendi.png', 1);
GO

DELETE FROM Users WHERE UserID = 'SE193621';