<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Thêm một chút Style riêng cho trang Home để hiện lưới sản phẩm đẹp hơn */
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .product-grid { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); 
            gap: 30px; 
        }
        .product-item { 
            background: #fff; 
            padding: 15px; 
            text-align: center; 
            transition: 0.3s;
            border: 1px solid #f0f0f0;
        }
        .product-item:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.1); }
        .product-item img { max-width: 100%; height: auto; margin-bottom: 15px; }
        .product-item h3 { font-size: 16px; margin: 10px 0; color: #333; }
        .product-item p { font-weight: bold; color: #000; }
        .btn-view { 
            display: inline-block; 
            margin-top: 10px; 
            padding: 8px 20px; 
            background: #000; 
            color: #fff; 
            text-decoration: none; 
            font-size: 13px; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h2 style="text-align: center; margin-bottom: 40px; letter-spacing: 2px;">DANH SÁCH SẢN PHẨM</h2>
        
        <div class="product-grid">
            <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                <div class="product-item">
                    <img src="images/${p.imageURL}" alt="${p.productName}">
                    <h3>${p.productName}</h3>
                    <p>${p.basePrice} VNĐ</p>
                    <a href="MainController?action=view-product&id=${p.productID}" class="btn-view">XEM CHI TIẾT</a>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>