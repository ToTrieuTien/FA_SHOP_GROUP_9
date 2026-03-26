<%-- 
    Document   : order_list
    Created on : Mar 26, 2026, 8:23:56 AM
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
        <title>Quản lý Đơn Hàng - FA SHOP</title>
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
                    <h1>Quản lý Đơn Hàng</h1>
                </div>

                <div class="data-board">
                    <div class="data-board-header">
                        <h3>Danh sách đơn hàng</h3>
                        <div class="search-box">
                            <form action="AdminMainController" method="POST" style="display: flex; gap: 5px;">
                                <input type="hidden" name="action" value="search-order">
                                <input type="text" name="txtSearch" placeholder="Tìm kiếm đơn hàng..." value="${param.txtSearch}">
                                <button type="submit" class="btn-primary" style="padding: 8px 15px;"><i class="fas fa-search"></i></button>
                            </form>
                        </div>
                    </div>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#MÃ ĐH</th>
                                <th>KHÁCH HÀNG</th>
                                <th>NGÀY ĐẶT</th>
                                <th>TỔNG TIỀN</th>
                                <th>TRẠNG THÁI</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${requestScope.LIST_ORDER}">
                                <tr>
                                    <td>DH00${o.orderID}</td>
                                    <td>${o.customerName}</td>
                                    <td>${o.orderDate}</td>
                                    <td><fmt:formatNumber value="${o.totalMoney}" type="number"/>đ</td>
                                    <td>
                                        <span class="status-badge ${o.status.toLowerCase()}">${o.status}</span>
                                    </td>
                                    <td>
                                        <div class="action-cell">
                                            <a href="AdminMainController?action=order-detail&id=${o.orderID}" class="btn-view" title="Xem chi tiết" style="margin-right: 5px;">
                                                <i class="fas fa-eye"></i>
                                            </a>

                                            <c:if test="${o.status == 'Pending'}">
                                                <a href="AdminMainController?action=update-order-status&id=${o.orderID}&status=Processing" 
                                                   class="btn-primary" style="background:#10b981; padding: 6px 12px; font-size: 13px;">Xử lý</a>
                                            </c:if>
                                            <c:if test="${o.status == 'Processing'}">
                                                <a href="AdminMainController?action=update-order-status&id=${o.orderID}&status=Completed" 
                                                   class="btn-primary" style="background:#10b981; padding: 6px 12px; font-size: 13px;">Hoàn thành</a>
                                            </c:if>
                                        </div>
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