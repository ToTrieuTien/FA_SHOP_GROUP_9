<%-- 
    Document   : order_detail
    Created on : Mar 26, 2026, 8:26:00 AM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Đơn Hàng - FA SHOP</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="wrapper">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h2>TH True Fashion Shop</h2>
                    <p>Mã số: ${sessionScope.LOGIN_USER.userID}</p>
                </div>
                <ul class="sidebar-menu">
                    <li><a href="AdminMainController?action=dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li class="active"><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <h1>Chi tiết Đơn Hàng #DH00${requestScope.ORDER_INFO.orderID}</h1>
                    <a href="AdminMainController?action=manage-order" class="btn-primary" style="background:#6b7280;">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <div class="data-board" style="padding: 25px;">
                    <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
                        <div>
                            <h3 style="margin-bottom: 10px; color:#111827;">Thông tin người nhận</h3>
                            <p><strong>Khách hàng:</strong> ${requestScope.ORDER_INFO.customerName}</p>
                            <p><strong>Số điện thoại:</strong> ${requestScope.ORDER_INFO.phone}</p>
                            <p><strong>Địa chỉ giao hàng:</strong> ${requestScope.ORDER_INFO.shippingAddress}</p>
                        </div>
                        <div style="text-align: right;">
                            <h3 style="margin-bottom: 10px; color:#111827;">Thông tin đơn hàng</h3>
                            <p><strong>Ngày đặt:</strong> ${requestScope.ORDER_INFO.orderDate}</p>
                            <p><strong>Trạng thái:</strong> <span class="status-badge ${requestScope.ORDER_INFO.status.toLowerCase()}">${requestScope.ORDER_INFO.status}</span></p>
                            <p><strong>Tổng thanh toán:</strong> <span style="color:#ef4444; font-weight:bold; font-size:18px;">
                                    <fmt:formatNumber value="${requestScope.ORDER_INFO.totalMoney}" type="number"/>đ
                                </span></p>
                        </div>
                    </div>

                    <h3 style="margin: 30px 0 15px 0;">Sản phẩm đã đặt</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>TÊN SẢN PHẨM</th>
                                <th>ĐƠN GIÁ</th>
                                <th>SỐ LƯỢNG</th>
                                <th>THÀNH TIỀN</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${requestScope.ORDER_ITEMS}">
                                <tr>
                                    <td>${item.productName}</td>
                                    <td><fmt:formatNumber value="${item.price}" type="number"/>đ</td>
                                    <td>${item.quantity}</td>
                                    <td><fmt:formatNumber value="${item.price * item.quantity}" type="number"/>đ</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>
</html>
