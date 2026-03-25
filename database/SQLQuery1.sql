SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'Orders';
SELECT TOP 1 VariantID FROM ProductVariants WHERE Status = 1
SELECT * FROM ProductVariants
-- Giả sử bạn đã có sản phẩm với ProductID = 1 trong bảng Products
INSERT INTO ProductVariants (ProductID, Size, Color, StockQuantity, Price)
VALUES (1, 'L', 'Default', 100, 500000);

-- Sau khi chạy xong, hãy kiểm tra lại bằng lệnh:
SELECT * FROM ProductVariants;
-- Ghi lại số VariantID vừa được tạo ra (thường sẽ là 1)