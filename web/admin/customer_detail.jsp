<%-- 
    Document   : customer_detail
    Created on : Mar 26, 2026, 10:38:04 AM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết Khách Hàng - FA SHOP</title>
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
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li class="active"><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <h1>Hồ sơ Khách hàng: ${requestScope.CUSTOMER_INFO.fullName}</h1>
                    <a href="AdminMainController?action=manage-customer" class="btn-primary" style="background:#6b7280;">
                        <i class="fas fa-arrow-left"></i> Quay lại
                    </a>
                </div>

                <div class="data-board" style="padding: 25px;">
                    <div style="display: flex; gap: 50px; margin-bottom: 30px; background: #f9fafb; padding: 20px; border-radius: 8px;">
                        <div>
                            <p><strong><i class="fas fa-user"></i> Họ tên:</strong> ${requestScope.CUSTOMER_INFO.fullName}</p>
                            <p><strong><i class="fas fa-envelope"></i> Email:</strong> ${requestScope.CUSTOMER_INFO.email}</p>
                            <p><strong><i class="fas fa-phone"></i> Điện thoại:</strong> ${requestScope.CUSTOMER_INFO.phone}</p>
                        </div>
                        <div>
                            <p><strong><i class="fas fa-map-marker-alt"></i> Địa chỉ:</strong> ${requestScope.CUSTOMER_INFO.address}</p>
                            <p><strong><i class="fas fa-shopping-bag"></i> Tổng đơn hàng:</strong> ${requestScope.CUSTOMER_INFO.totalOrders}</p>
                            <p><strong><i class="fas fa-money-bill-wave"></i> Tổng chi tiêu:</strong> <span style="color:#ef4444; font-weight:bold;"><fmt:formatNumber value="${requestScope.CUSTOMER_INFO.totalSpent}" type="number"/>đ</span></p>
                        </div>
                    </div>

                    <h3>Lịch sử đơn hàng</h3>
                    <table class="data-table" style="margin-top: 15px;">
                        <thead>
                            <tr>
                                <th>MÃ ĐH</th>
                                <th>NGÀY MUA</th>
                                <th>TỔNG TIỀN</th>
                                <th>TRẠNG THÁI</th>
                                <th>CHI TIẾT</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="o" items="${requestScope.CUSTOMER_ORDERS}">
                            <tr>
                                <td><strong>DH00${o.orderID}</strong></td>
                                <td>${o.orderDate}</td>
                                <td><fmt:formatNumber value="${o.totalMoney}" type="number"/>đ</td>
                            <td><span class="status-badge ${o.status.toLowerCase()}">${o.status}</span></td>
                            <td>
                                <a href="AdminMainController?action=order-detail&id=${o.orderID}" class="btn-view"><i class="fas fa-eye"></i></a>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>
</html>
