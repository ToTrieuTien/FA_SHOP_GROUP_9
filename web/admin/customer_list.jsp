<%-- 
    Document   : customer_list
    Created on : Mar 26, 2026, 10:37:28 AM
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
        <title>Quản lý Khách Hàng - FA SHOP</title>
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
                    <h1>Quản lý Khách Hàng</h1>
                </div>

                <div class="data-board">
                    <div class="data-board-header">
                        <h3>Danh sách khách hàng</h3>
                        <div class="search-box">
                            <form action="AdminMainController" method="POST" style="display: flex; gap: 5px;">
                                <input type="hidden" name="action" value="search-customer">
                                <input type="text" name="txtSearch" placeholder="Tìm tên, SĐT, email...">
                                <button type="submit" class="btn-primary" style="padding: 8px 15px;"><i class="fas fa-search"></i></button>
                            </form>
                        </div>
                    </div>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>KHÁCH HÀNG</th>
                                <th>LIÊN HỆ</th>
                                <th>SỐ ĐƠN</th>
                                <th>TỔNG CHI TIÊU</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${requestScope.LIST_CUSTOMER}">
                                <tr>
                                    <td>
                                        <strong>${c.fullName}</strong>
                                        <c:if test="${c.totalSpent >= 1000000}">
                                            <span style="background: #f59e0b; color: white; padding: 2px 6px; border-radius: 4px; font-size: 10px; margin-left: 5px;">VIP</span>
                                        </c:if>
                                    </td>
                                    <td>
                                        <div><i class="fas fa-phone" style="font-size: 12px; width: 15px;"></i> ${c.phone}</div>
                                        <div style="font-size: 13px; color: #666;"><i class="fas fa-envelope" style="font-size: 12px; width: 15px;"></i> ${c.email}</div>
                                    </td>
                                    <td>${c.totalOrders} đơn</td>
                                    <td style="color:#10b981; font-weight:bold;"><fmt:formatNumber value="${c.totalSpent}" type="number"/>đ</td>
                                    <td>
                                        <a href="AdminMainController?action=customer-detail&id=${c.userID}" class="btn-view" title="Xem chi tiết">
                                            <i class="fas fa-eye"></i>
                                        </a>
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
