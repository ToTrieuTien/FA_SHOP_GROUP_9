<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Trang chủ - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .container { max-width: 1200px; margin: 0 auto; padding: 40px 20px; }
        .product-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 30px; }
        .product-item { background: #fff; padding: 15px; text-align: center; transition: 0.3s; border: 1px solid #f0f0f0; border-radius: 8px; }
        .product-item:hover { box-shadow: 0 5px 15px rgba(0,0,0,0.1); transform: translateY(-5px); }
        .product-item img { max-width: 100%; height: 250px; object-fit: cover; margin-bottom: 15px; border-radius: 4px; }
        .product-item h3 { font-size: 16px; margin: 10px 0; color: #333; height: 40px; }
        .product-item p { font-weight: bold; color: #ff4d4d; font-size: 18px; }
        .btn-view { display: inline-block; margin-top: 10px; padding: 10px 20px; background: #1a233a; color: #fff; text-decoration: none; font-size: 14px; font-weight: bold; border-radius: 4px; transition: 0.3s; }
        .btn-view:hover { background: #4CAF50; }
    </style>
</head>
<body style="background-color: #f9f9f9; margin: 0;">

    <c:if test="${not empty sessionScope.SUCCESS_MSG}">
        <div id="toastMessage" style="position: fixed; top: 80px; right: 20px; background-color: #4CAF50; color: white; padding: 15px 25px; border-radius: 4px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 9999; font-size: 16px; font-weight: bold; transition: opacity 0.5s;">
            ✅ ${sessionScope.SUCCESS_MSG}
        </div>
        <c:remove var="SUCCESS_MSG" scope="session" />
        <script>
            setTimeout(function() {
                var toast = document.getElementById("toastMessage");
                if (toast) {
                    toast.style.opacity = "0";
                    setTimeout(function() { toast.style.display = "none"; }, 500);
                }
            }, 3000); 
        </script>
    </c:if>
    <div class="user-header" style="background: #1a233a; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; box-shadow: 0 2px 10px rgba(0,0,0,0.2);">
        <div style="font-size: 24px; font-weight: bold; letter-spacing: 2px;">
            <a href="MainController" style="color: white; text-decoration: none;">FA SHOP</a>
        </div>
        <div>
            <c:choose>
                <c:when test="${not empty sessionScope.LOGIN_USER}">
                    <span style="margin-right: 20px; font-size: 15px;">Xin chào, <b>${sessionScope.LOGIN_USER.fullName}</b>!</span>
                    <a href="MainController" style="color: white; text-decoration: none; margin-right: 20px; font-size: 15px;">Trang chủ</a>
                    <a href="MainController?action=view-cart" style="color: #4CAF50; text-decoration: none; margin-right: 20px; font-weight: bold; font-size: 15px;">
                        🛒 Giỏ hàng (<c:out value="${sessionScope.CART != null ? sessionScope.CART.cart.size() : 0}"/>)
                    </a>
                    <a href="MainController?action=logout" style="color: #ff4d4d; text-decoration: none; font-weight: bold; font-size: 15px;">Đăng xuất</a>
                </c:when>
                <c:otherwise>
                    <a href="MainController" style="color: white; text-decoration: none; margin-right: 20px; font-size: 15px;">Trang chủ</a>
                    <a href="login.jsp" style="color: #4CAF50; text-decoration: none; font-weight: bold; font-size: 15px; border: 1px solid #4CAF50; padding: 8px 15px; border-radius: 4px;">Đăng nhập / Đăng ký</a>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="container">
        <h2 style="text-align: center; margin-bottom: 40px; letter-spacing: 2px; font-size: 28px;">SẢN PHẨM MỚI NHẤT</h2>
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