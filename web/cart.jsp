<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng của bạn - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body style="background-color: #f9f9f9; margin: 0;">
    
    <div class="user-header" style="background: #1a233a; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
        <div style="font-size: 20px; font-weight: bold; letter-spacing: 2px;">FA SHOP</div>
        <div>
            <span style="margin-right: 20px;">Xin chào, <b>${sessionScope.LOGIN_USER.fullName}</b>!</span>
            <a href="MainController" style="color: white; text-decoration: none; margin-right: 20px;">Trang chủ</a>
            <a href="MainController?action=view-cart" style="color: #4CAF50; text-decoration: none; margin-right: 20px; font-weight: bold;">
                🛒 Giỏ hàng (<c:out value="${sessionScope.CART != null ? sessionScope.CART.size() : 0}"/>)
            </a>
            <a href="MainController?action=logout" style="color: #ff4d4d; text-decoration: none; font-weight: bold;">Đăng xuất</a>
        </div>
    </div>

    <div class="wrapper" style="display: block;">
        <div class="data-board" style="max-width: 900px; margin: 0 auto; padding: 30px;">
            <h2 style="margin-top: 0; border-bottom: 2px solid #eee; padding-bottom: 15px;">GIỎ HÀNG CỦA BẠN</h2>

            <c:if test="${empty sessionScope.CART}">
                <div style="text-align: center; padding: 50px 0;">
                    <h3 style="color: #888;">Giỏ hàng đang trống</h3>
                    <a href="MainController" class="btn-primary" style="padding: 10px 20px; margin-top: 20px; display: inline-block;">TIẾP TỤC MUA SẮM</a>
                </div>
            </c:if>

            <c:if test="${not empty sessionScope.CART}">
                <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
                    <thead>
                        <tr style="background: #f4f7f6; text-align: left;">
                            <th style="padding: 15px;">Hình ảnh</th>
                            <th style="padding: 15px;">Tên sản phẩm</th>
                            <th style="padding: 15px;">Giá</th>
                            <th style="padding: 15px;">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="item" items="${sessionScope.CART}">
                            <tr style="border-bottom: 1px solid #eee;">
                                <td style="padding: 15px;">
                                    <img src="images/${item.imageURL}" style="width: 60px; height: 60px; object-fit: cover; border-radius: 4px;">
                                </td>
                                <td style="padding: 15px; font-weight: bold;">${item.productName}</td>
                                <td style="padding: 15px; color: #ff4d4d; font-weight: bold;">${item.basePrice} VNĐ</td>
                                <td style="padding: 15px;">
                                    <a href="MainController?action=remove-from-cart&id=${item.productID}" style="color: #ff4d4d; text-decoration: none; font-weight: bold;" onclick="return confirm('Bạn muốn xóa sản phẩm này khỏi giỏ hàng?');">❌ Xóa</a>
                                </td>
                            </tr>
                            <c:set var="total" value="${total + item.basePrice}" />
                        </c:forEach>
                    </tbody>
                </table>

                <div style="text-align: right; margin-top: 30px; font-size: 20px;">
                    Tổng tiền: <span style="color: #ff4d4d; font-weight: bold; font-size: 24px;">${total} VNĐ</span>
                </div>
                <div style="text-align: right; margin-top: 20px;">
                    <a href="MainController" style="text-decoration: none; color: #000; font-weight: bold; margin-right: 20px;">← Tiếp tục mua sắm</a>
                    <a href="#" class="btn-primary" style="padding: 15px 30px; font-size: 16px;">THANH TOÁN (Comming soon)</a>
                </div>
            </c:if>
        </div>
    </div>
</body>
</html>