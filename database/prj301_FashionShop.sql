-- 1. Xóa các bảng cũ theo đúng thứ tự (Bảng phụ xóa trước, bảng chính xóa sau)
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductImages;
DROP TABLE IF EXISTS ProductVariants;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;

-- 2. Tạo lại bảng Users (UserID là String, không dùng IDENTITY)
CREATE TABLE Users (
    UserID NVARCHAR(20) PRIMARY KEY, -- Định dạng: SE123456
    FullName NVARCHAR(150),
    Email NVARCHAR(150),
    Password NVARCHAR(255),
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    RoleID INT, -- 1: Admin, 2: Customer
    Status BIT,
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 3. Tạo lại các bảng liên quan (UserID phải đồng bộ kiểu NVARCHAR(20))
CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(150),
    Description NVARCHAR(255)
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(150),
    Description NVARCHAR(255),
    BasePrice DECIMAL(10,2),
    CategoryID INT,
    Status BIT,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
);

CREATE TABLE ProductImages (
    ImageID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    ImageURL NVARCHAR(255),
    IsPrimary BIT,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE ProductVariants (
    VariantID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT,
    Size NVARCHAR(50),
    Color NVARCHAR(50),
    StockQuantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    UserID NVARCHAR(20), -- Phải là NVARCHAR để khớp với bảng Users
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(50),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE OrderDetails (
    DetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT,
    VariantID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (VariantID) REFERENCES ProductVariants(VariantID)
);

CREATE TABLE Reviews (
    ReviewID INT IDENTITY(1,1) PRIMARY KEY,
    UserID NVARCHAR(20), -- Phải là NVARCHAR
    ProductID INT,
    Rating INT,
    Comment NVARCHAR(255),
    ReviewDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Users (UserID, FullName, Email, Password, Phone, Address, RoleID, Status)
VALUES 
('SE193160', N'Ngô Đức Tài', 'taingo1181@gmail.com', '7', '0913573096', N'Vinhome Grand Park, Quận 9 HCM', 1, 1),
('SE196703', N'Tô Triệu Tiến', 'totien@gmail.com', '1', '0123456789', N'Vinhome Grand Park, Quận 9 HCM', 1, 1),
('SE193621', N'Phạm Gia Huy', 'giahuypham1234@gmail.com', '1', '1234567891', N'Vinhome Grand Park, Quận 9 HCM', 1, 1);

INSERT INTO Users (UserID, FullName, Email, Password, Phone, Address, RoleID, Status)
VALUES 
('SE000004', N'Cristiano Ronaldo', 'ronaldo@gmail.com', '1', '0000000007', N'Bồ Đào Nha', 2, 1),
('SE000005', N'Lionel Messi', 'messi@gmail.com', '1', '0000000010', N'Argentina', 2, 1),
('SE000006', N'Neymar Jr', 'neymar@gmail.com', '1', '0000000011', N'Brazil', 2, 1);

-- 2. Thêm Danh mục (Categories)
INSERT INTO Categories (CategoryName, Description)
VALUES 
(N'Áo Polo', N'Áo thun có cổ sang trọng, lịch sự'),
(N'Quần Jean', N'Quần jean denim dáng ôm, co giãn'),
(N'Phụ Kiện', N'Thắt lưng và ví da cao cấp');

-- 3. Thêm Sản phẩm (Products)
-- Giả sử ID tự tăng là 1, 2, 3
INSERT INTO Products (ProductName, Description, BasePrice, CategoryID, Status)
VALUES 
(N'Áo Polo Monogram', N'Chất liệu cotton 100%, họa tiết in chìm', 450000, 1, 1),
(N'Quần Jean Slimfit Blue', N'Denim cao cấp, bền màu', 650000, 2, 1),
(N'Ví Da Fendi Black', N'Da bò thật 100%, ngăn chứa rộng', 1200000, 3, 1);