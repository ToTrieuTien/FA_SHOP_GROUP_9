<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard - FA SHOP</title>
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
                    <li class="active"><a href="AdminMainController?action=dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <h1 class="dashboard-title">Chào mừng trở lại, ${sessionScope.LOGIN_USER.fullName}!</h1>

                <div class="stats-grid">
                    <div class="stat-card">
                        <h4>TỔNG ĐƠN HÀNG</h4>
                        <div class="value">${requestScope.TOTAL_ORDERS}</div>
                    </div>
                    <div class="stat-card">
                        <h4>DOANH THU</h4>
                        <div class="value"><fmt:formatNumber value="${requestScope.TOTAL_REVENUE}" type="number"/>đ</div>
                    </div>
                    <div class="stat-card">
                        <h4>SẢN PHẨM</h4>
                        <div class="value">${requestScope.TOTAL_PRODUCTS}</div>
                    </div>
                    <div class="stat-card">
                        <h4>KHÁCH HÀNG</h4>
                        <div class="value">${requestScope.TOTAL_CUSTOMERS}</div>
                    </div>
                </div>

                <div class="recent-products">
                    <h3>Sản phẩm gần đây</h3>
                    <table>
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>HÌNH ẢNH</th>
                                <th>TÊN SẢN PHẨM</th>
                                <th>GIÁ (VNĐ)</th>
                                <th>TRẠNG THÁI</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${requestScope.RECENT_PRODUCTS}">
                                <tr>
                                    <td>SP00${p.productID}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/images/${p.imageURL}" 
                                             alt="${p.productName}" 
                                             style="width:40px; height:40px; object-fit: cover; border-radius:4px;">
                                    </td>
                                    <td>${p.productName}</td>
                                    <td><fmt:formatNumber value="${p.basePrice}" type="number"/>đ</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${p.status}">
                                                <span class="status in-stock">Còn hàng</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="status out-of-stock" style="background: #fef2f2; color: #ef4444; padding: 4px 8px; border-radius: 4px; font-size: 0.85rem;">Hết hàng</span>
                                            </c:otherwise>
                                        </c:choose>
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