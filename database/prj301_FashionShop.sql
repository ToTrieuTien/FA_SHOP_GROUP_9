USE PRJ_FashionShop;
GO

-- =========================================================
-- 1. XÓA DỮ LIỆU CŨ (Thứ tự từ bảng con đến bảng cha)
-- =========================================================
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS ProductImages;
DROP TABLE IF EXISTS ProductVariants;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Roles;
GO

USE [PRJ_FashionShop]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[VariantID] [int] NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [varchar](20) NULL,
	[OrderDate] [datetime] NULL,
	[TotalMoney] [decimal](18, 2) NULL,
	[ShippingAddress] [nvarchar](255) NULL,
	[Phone] [varchar](20) NULL,
	[Status] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductImages](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[ImageURL] [varchar](255) NOT NULL,
	[IsPrimary] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[BasePrice] [decimal](18, 2) NOT NULL,
	[CategoryID] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductVariants](
	[VariantID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NULL,
	[Size] [varchar](10) NULL,
	[Color] [nvarchar](50) NULL,
	[StockQuantity] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[VariantID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] NOT NULL,
	[RoleName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- =========================================================
-- ĐÃ LỒNG STATUS DEFAULT 0 VÀ VERIFICATION CODE
-- =========================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [varchar](20) NOT NULL,
	[FullName] [nvarchar](100) NOT NULL,
	[Email] [varchar](100) NULL,
	[Password] [varchar](100) NOT NULL,
	[Phone] [varchar](20) NULL,
	[Address] [nvarchar](255) NULL,
	[RoleID] [int] NULL,
	[Status] [bit] DEFAULT 0, -- Mặc định là 0: Chưa xác thực 
	[VerificationCode] [varchar](100), -- Thêm cột lưu mã xác thực
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (1, N'Áo Polo', N'Áo thun có cổ sang trọng', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (2, N'Quần Jean', N'Quần jean denim', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (3, N'Phụ Kiện (Ví, Thắt lưng...)', N'Thắt lưng ví da', 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (4, N'Áo Khoác', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (5, N'Quần Dài', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (6, N'Áo Sơ Mi', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (8, N'Áo Thun', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (9, N'Quần Short', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (10, N'Giày & Dép', NULL, 1)
INSERT [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Status]) VALUES (11, N'Nón', NULL, 1)
SET IDENTITY_INSERT [dbo].[Categories] OFF
GO

SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (1, 1, 1, 1, CAST(1200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (2, 2, 1, 1, CAST(1200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (3, 3, 1, 1, CAST(5000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (4, 4, 1, 1, CAST(450000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (5, 5, 1, 1, CAST(299000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (6, 6, 1, 1, CAST(299000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (7, 7, 1, 1, CAST(799000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (8, 8, 1, 1, CAST(1200000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (9, 9, 1, 1, CAST(450000.00 AS Decimal(18, 2)))
INSERT [dbo].[OrderDetails] ([OrderDetailID], [OrderID], [VariantID], [Quantity], [Price]) VALUES (10, 10, 1, 1, CAST(799000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
GO

SET IDENTITY_INSERT [dbo].[Orders] ON 

INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (1, N'SE000004', CAST(N'2026-03-26T15:35:27.950' AS DateTime), CAST(1200000.00 AS Decimal(18, 2)), N'Bồ Đào Nha', N'0000000007', N'Completed')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (2, N'SE000004', CAST(N'2026-03-26T15:35:45.113' AS DateTime), CAST(1200000.00 AS Decimal(18, 2)), N'Bồ Đào Nha', N'0000000007', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (3, N'SE000004', CAST(N'2026-03-26T15:36:44.083' AS DateTime), CAST(5000.00 AS Decimal(18, 2)), N'Bồ Đào Nha', N'0000000007', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (4, N'SE000005', CAST(N'2026-03-26T16:08:28.397' AS DateTime), CAST(450000.00 AS Decimal(18, 2)), N'Argentina', N'0000000010', N'Completed')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (5, N'SE000005', CAST(N'2026-03-26T16:19:57.453' AS DateTime), CAST(299000.00 AS Decimal(18, 2)), N'Argentina', N'0000000010', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (6, N'SE000005', CAST(N'2026-03-26T16:33:14.593' AS DateTime), CAST(299000.00 AS Decimal(18, 2)), N'Argentina', N'0000000010', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (7, N'Siu', CAST(N'2026-03-26T22:20:31.517' AS DateTime), CAST(799000.00 AS Decimal(18, 2)), N'TPHCM', N'0913573096', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (8, N'Siu', CAST(N'2026-03-26T23:56:02.073' AS DateTime), CAST(1200000.00 AS Decimal(18, 2)), N'TPHCM', N'0913573096', N'Awaiting Payment')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (9, N'Siu', CAST(N'2026-03-26T23:56:20.287' AS DateTime), CAST(450000.00 AS Decimal(18, 2)), N'TPHCM', N'0913573096', N'Canceled')
INSERT [dbo].[Orders] ([OrderID], [UserID], [OrderDate], [TotalMoney], [ShippingAddress], [Phone], [Status]) VALUES (10, N'Siu', CAST(N'2026-03-27T12:37:26.567' AS DateTime), CAST(799000.00 AS Decimal(18, 2)), N'TPHCM', N'0913573096', N'Processing')
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO

SET IDENTITY_INSERT [dbo].[ProductImages] ON 

INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (1, 1, N'polo_monogram.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (2, 2, N'jean_slim_fit.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (3, 3, N'fendi_black_wallet.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (5, 5, N'varsity_jacket.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (6, 6, N'Bamboo_DATB920.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (7, 7, N'Cotton-Iconic-Form-Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (8, 8, N'Quan_Short.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (9, 9, N'black_classy_look.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (10, 10, N'Dep.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (11, 11, N'Non.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (12, 12, N'Polo_Epic.png', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (13, 13, N'_ao-thun-len-nam-mono-sense-form-regular471_79ced4bcefc7424697034bc07d0a02b3_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (14, 14, N'ao-thun-nam-cotton-austin-texas-form-regular_6021_2a5d556dc1a0438fa542abb652aa5c86_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (15, 15, N'ao-thun-nam-cotton-iconic-form-regular_0134_ec53a35e395b4ab6bf1f14569a1c73f2_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (16, 16, N'ao-thun-nam-elevyn-form-boxy54_71112c8e05ca4efa87c22b2dad5ac0c7_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (17, 17, N'ao-thun-nam-endurance-form-regular_e4e4f8e1b2ea4891b7669ef3dab305cb_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (18, 18, N'ao-thun-nam-marvel-the-amazing-form-boxy6677_8fc0eee70d7741a68a104e3dd2e70084_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (19, 19, N'ao-thun-nam-nineteen-egde-form-boxy_4550_8008f26277e54321aef95e2ead008e80_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (20, 20, N'ao-thun-nam-refined-form-boxy_7670_f522776899d44a38a29ba7cfc8b8e519_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (21, 21, N'ao-thun-nam-traction-form-regular_5217_1f3dae7272564270a2e68c4ab8b31ce0_1024x1024.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (22, 22, N'Áo Polo Nam Marvel Super Soldier Form Boxy.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (23, 23, N'Áo Polo Nam Disney Mickey Grid Form Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (24, 24, N'Áo Polo Nam Quarter Zip Form Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (25, 25, N'Áo Polo Nam League Form Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (26, 26, N'Áo Polo Nam Gentle Form Boxy.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (27, 27, N'Áo Polo Nam In Predator Form Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (28, 28, N'Áo Polo Len Nam Layer Mood Form Regular.jpg', 1)
INSERT [dbo].[ProductImages] ([ImageID], [ProductID], [ImageURL], [IsPrimary]) VALUES (29, 29, N'Áo Polo Nam Classic Trim Form Regular.jpg', 1)
SET IDENTITY_INSERT [dbo].[ProductImages] OFF
GO
SET IDENTITY_INSERT [dbo].[Products] ON 

INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (1, N'Áo Polo Monogram', N'Cotton 100%', CAST(450000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (2, N'Quần Jean Slimfit Blue', N'Denim cao cấp', CAST(499000.00 AS Decimal(18, 2)), 2, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (3, N'Ví Da Fendi Black', N'Da bò thật', CAST(1200000.00 AS Decimal(18, 2)), 3, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (5, N'Áo Khoác Varsity Jacket', N'Mô tả tự động', CAST(799000.00 AS Decimal(18, 2)), 4, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (6, N'Áo Sơ Mi Dài Tay Trơn Bamboo DATB920', N'Mô tả tự động', CAST(499000.00 AS Decimal(18, 2)), 6, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (7, N'Áo Thun Nam Iconic Form Regular', N'Mô tả tự động', CAST(129000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (8, N'Quần Short Pique Nam Form Regular', N'Mô tả tự động', CAST(109000.00 AS Decimal(18, 2)), 9, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (9, N'Quần Tây Nam Black Classy Look', N'Mô tả tự động', CAST(299000.00 AS Decimal(18, 2)), 5, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (10, N'Dép Nam Easy Strap Slides', N'Mô tả tự động', CAST(349000.00 AS Decimal(18, 2)), 10, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (11, N'Nón Lưỡi Trai Nam Heroic Alpha Form Baseball Cap', N'Mô tả tự động', CAST(249000.00 AS Decimal(18, 2)), 11, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (12, N'Áo Polo Epic', N'Mô tả tự động', CAST(480000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (13, N'Áo Thun Len Nam Mono Sense Form Regular', N'Mô tả tự động', CAST(279000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (14, N'Áo Thun Nam Austin Texas Form Regular', N'Mô tả tự động', CAST(239000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (15, N'Áo Thun Nam Iconic Form Regular', N'Mô tả tự động', CAST(219000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (16, N'Áo Thun Nam Elevyn Form Boxy', N'Mô tả tự động', CAST(149000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (17, N'Áo Thun Nam Endurance Form Regular', N'Mô tả tự động', CAST(299000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (18, N'Áo Thun Nam Marvel The Amazing Form Boxy', N'Mô tả tự động', CAST(399000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (19, N'Áo Thun Nam Nineteen Egde Form Boxy', N'Mô tả tự động', CAST(209000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (20, N'Áo Thun Nam Refined Form Boxy', N'Mô tả tự động', CAST(349000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (21, N'Áo Thun Nam Traction Form Regular', N'Mô tả tự động', CAST(199000.00 AS Decimal(18, 2)), 8, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (22, N'Áo Polo Nam Marvel Super Soldier Form Boxy', N'Mô tả tự động', CAST(399000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (23, N'Áo Polo Nam Disney Mickey Grid Form Regular', N'Mô tả tự động', CAST(429000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (24, N'Áo Polo Nam Quarter Zip Form Regular', N'Mô tả tự động', CAST(299000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (25, N'Áo Polo Nam League Form Regular', N'Mô tả tự động', CAST(349000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (26, N'Áo Polo Nam Gentle Form Boxy', N'Mô tả tự động', CAST(429000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (27, N'Áo Polo Nam In Predator Form Regular', N'Mô tả tự động', CAST(399000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (28, N'Áo Polo Len Nam Layer Mood Form Regular', N'Mô tả tự động', CAST(429000.00 AS Decimal(18, 2)), 1, 1)
INSERT [dbo].[Products] ([ProductID], [ProductName], [Description], [BasePrice], [CategoryID], [Status]) VALUES (29, N'Áo Polo Nam Classic Trim Form Regular', N'Mô tả tự động', CAST(379000.00 AS Decimal(18, 2)), 1, 1)
SET IDENTITY_INSERT [dbo].[Products] OFF
GO

SET IDENTITY_INSERT [dbo].[ProductVariants] ON 

INSERT [dbo].[ProductVariants] ([VariantID], [ProductID], [Size], [Color], [StockQuantity]) VALUES (1, 1, N'L', N'Black', 50)
INSERT [dbo].[ProductVariants] ([VariantID], [ProductID], [Size], [Color], [StockQuantity]) VALUES (2, 2, N'32', N'Blue', 40)
INSERT [dbo].[ProductVariants] ([VariantID], [ProductID], [Size], [Color], [StockQuantity]) VALUES (3, 3, N'None', N'Black', 30)
SET IDENTITY_INSERT [dbo].[ProductVariants] OFF
GO

INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Roles] ([RoleID], [RoleName]) VALUES (2, N'Customer')
GO

INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE000004', N'Cristiano Ronaldo', N'ronaldo@gmail.com', N'1', N'0000000007', N'Bồ Đào Nha', 2, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE000005', N'Lionel Messi', N'messi@gmail.com', N'1', N'0000000010', N'Argentina', 2, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE000006', N'Neymar Jr', N'neymar@gmail.com', N'1', N'0000000011', N'Brazil', 2, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE193160', N'Ngô Đức Tài', N'taingo1181@gmail.com', N'1', N'0913573096', N'Vinhome Q9', 1, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE193621', N'Phạm Gia Huy', N'giahuypham1234@gmail.com', N'1', N'1234567891', N'Vinhome Q9', 1, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'SE196703', N'Tô Triệu Tiến', N'totien@gmail.com', N'1', N'0123456789', N'Vinhome Q9', 1, 1)
INSERT [dbo].[Users] ([UserID], [FullName], [Email], [Password], [Phone], [Address], [RoleID], [Status]) VALUES (N'Siu', N'CR7', N'thuthuthanhtai123@gmail.com', N'1', N'0913573096', N'TPHCM', 2, 1)
GO

SET ANSI_PADDING ON
GO
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories] ADD DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Orders] ADD DEFAULT (getdate()) FOR [OrderDate]
GO
ALTER TABLE [dbo].[Orders] ADD DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[ProductImages] ADD DEFAULT ((1)) FOR [IsPrimary]
GO
ALTER TABLE [dbo].[Products] ADD DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[ProductVariants] ADD DEFAULT ((0)) FOR [StockQuantity]
GO


ALTER TABLE [dbo].[OrderDetails] WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] WITH CHECK ADD FOREIGN KEY([VariantID])
REFERENCES [dbo].[ProductVariants] ([VariantID])
GO
ALTER TABLE [dbo].[Orders] WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[ProductImages] WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Products] WITH CHECK ADD FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[ProductVariants] WITH CHECK ADD FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Users] WITH CHECK ADD FOREIGN KEY([RoleID])
REFERENCES [dbo].[Roles] ([RoleID])
GO

USE [master]
GO
ALTER DATABASE [PRJ_FashionShop] SET READ_WRITE 
GO