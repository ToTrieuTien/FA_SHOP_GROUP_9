<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Chi tiết sản phẩm - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="wrapper" style="display: block;">
        <div class="login-breadcrumb" style="max-width: 1200px; margin: 20px auto;">
            <a href="MainController" style="text-decoration: none; color: #888; font-weight: bold;">Trang chủ</a> / <span>Chi tiết sản phẩm</span>
        </div>
        
        <div class="data-board" style="max-width: 1000px; margin: 0 auto; padding: 40px; display: flex; gap: 40px;">
            <div style="flex: 1; text-align: center;">
                <img src="images/${PRODUCT_DETAIL.imageURL}" alt="${PRODUCT_DETAIL.productName}" style="max-width: 100%; border-radius: 8px; box-shadow: 0 4px 10px rgba(0,0,0,0.1);">
            </div>
            
            <div style="flex: 1;">
                <h1 style="margin-top: 0; font-size: 28px;">${PRODUCT_DETAIL.productName}</h1>
                <h2 style="color: #ff4d4d; font-size: 24px;">${PRODUCT_DETAIL.basePrice} VNĐ</h2>
                <hr style="border: 0; border-top: 1px solid #eee; margin: 20px 0;">
                
                <p style="font-size: 16px; line-height: 1.6;"><strong>Mô tả:</strong> ${PRODUCT_DETAIL.description}</p>
                <p style="font-size: 16px; margin-top: 15px;"><strong>Tình trạng:</strong> 
                    <c:choose>
                        <c:when test="${PRODUCT_DETAIL.status == true}">
                            <span class="status in-stock" style="padding: 8px 15px; font-size: 14px;">Còn hàng</span>
                        </c:when>
                        <c:otherwise>
                            <span class="status out-of-stock" style="padding: 8px 15px; font-size: 14px;">Tạm hết hàng</span>
                        </c:otherwise>
                    </c:choose>
                </p>

                <form action="MainController" method="POST" style="margin-top: 40px;">
                    <input type="hidden" name="action" value="add-to-cart">
                    <input type="hidden" name="productID" value="${PRODUCT_DETAIL.productID}">
                    <button type="submit" class="btn-primary" style="width: 100%; padding: 15px; font-size: 16px; cursor: pointer;">
                        THÊM VÀO GIỎ HÀNG
                    </button>
                </form>
            </div>
        </div>
    </div>
</body>
</html>