<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Giỏ hàng - FA SHOP</title>
</head>
<body style="font-family: Arial, sans-serif; padding: 20px;">
    <a href="MainController?action=view-cart" style="color: #4CAF50; text-decoration: none; margin-right: 20px; font-weight: bold;">
        🛒 Giỏ hàng (<c:out value="${sessionScope.CART != null ? sessionScope.CART.size : 0}"/>)
    </a>
    <a href="MainController" style="text-decoration: none; color: blue;">Tiếp tục mua sắm</a>

    <hr>

    <c:if test="${not empty sessionScope.CART}">
        <table style="width: 100%; border-collapse: collapse; margin-top: 20px;">
            <thead>
                <tr style="background-color: #f2f2f2; text-align: left;">
                    <th style="padding: 15px;">Sản phẩm</th>
                    <th style="padding: 15px;">Giá</th>
                    <th style="padding: 15px;">Số lượng</th>
                    <th style="padding: 15px;">Thành tiền</th>
                    <th style="padding: 15px;">Thao tác</th>
                </tr>
            </thead>
            <tbody>
                <c:set var="total" value="0" />
                <c:forEach var="item" items="${sessionScope.CART.cart.values()}">
                    <tr style="border-bottom: 1px solid #eee;">
                        <td style="padding: 15px; font-weight: bold;">${item.productName}</td>
                        <td style="padding: 15px;">${item.basePrice} VNĐ</td>
                        <td style="padding: 15px;">${item.quantity}</td>
                        <td style="padding: 15px; color: #ff4d4d; font-weight: bold;">
                            ${item.basePrice * item.quantity} VNĐ
                        </td>
                        <td style="padding: 15px;">
                            <a href="CartController?action=remove-from-cart&id=${item.productID}" 
                               onclick="return confirm('Bạn chắc chắn muốn xóa sản phẩm này?');" 
                               style="text-decoration: none;">❌</a>
                        </td>
                    </tr>
                    <c:set var="total" value="${total + (item.basePrice * item.quantity)}" />
                </c:forEach>
            </tbody>
        </table>

        <div style="text-align: right; margin-top: 30px; padding: 20px; border-top: 2px solid #1a233a;">
            <h3 style="margin-bottom: 20px;">Tổng tiền thanh toán: <span style="color: #ff4d4d;">${total} VNĐ</span></h3>
            
            <form action="MainController" method="POST">
                <input type="hidden" name="action" value="checkout">
                <input type="hidden" name="totalMoney" value="${total}">
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px;">Số điện thoại nhận hàng:</label>
                    <input type="text" name="phone" required style="width: 250px; padding: 8px;">
                </div>
                
                <div style="margin-bottom: 15px;">
                    <label style="display: block; margin-bottom: 5px;">Địa chỉ giao hàng chi tiết:</label>
                    <textarea name="shippingAddress" required style="width: 250px; height: 80px; padding: 8px;"></textarea>
                </div>

                <button type="submit" style="padding: 12px 30px; background: #1a233a; color: white; border: none; cursor: pointer; font-weight: bold; border-radius: 5px;">
                    XÁC NHẬN THANH TOÁN
                </button>
            </form>
        </div>
    </c:if>

    <c:if test="${empty sessionScope.CART}">
        <div style="text-align: center; margin-top: 50px;">
            <h3>Giỏ hàng đang trống. Hãy chọn sản phẩm ngay!</h3>
            <a href="MainController" style="color: #4CAF50;">Quay lại trang chủ</a>
        </div>
    </c:if>
</body>
</html>