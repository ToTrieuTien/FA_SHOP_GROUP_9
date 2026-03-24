<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Admin Dashboard - FA SHOP</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <div class="wrapper">
            <nav class="sidebar">
                <div class="sidebar-header">
                    <h2>TH True Fashion Shop</h2>
                    <p>Mã số: ${sessionScope.LOGIN_USER.userID}</p>
                </div>
                <ul class="sidebar-menu">
                    <li class="active"><a href="#">Dashboard Overview</a></li>
                    <li><a href="AdminMainController?action=manage-product">Quản lý Sản Phẩm</a></li>
                    <li><a href="AdminMainController?action=manage-category">Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order">Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer">Khách Hàng</a></li>
                    <li><a href="AdminMainController?action=logout">Đăng Xuất</a></li>
                </ul>
            </nav>

            <main class="main-content">
                <h1 class="dashboard-title">Chào mừng trở lại, ${sessionScope.LOGIN_USER.fullName}!</h1>

                <div class="stats-grid">
                    <div class="stat-card"><h4>TỔNG ĐƠN HÀNG</h4><div class="value">150</div></div>
                    <div class="stat-card"><h4>DOANH THU</h4><div class="value">50.2M</div></div>
                    <div class="stat-card"><h4>SẢN PHẨM</h4><div class="value">320</div></div>
                    <div class="stat-card"><h4>KHÁCH HÀNG</h4><div class="value">85</div></div>
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
                            <tr>
                                <td>SP001</td>
                                <td><img src="${pageContext.request.contextPath}/images/polo_monogram.png" 
                                         alt="${p.productName}" 
                                         style="width:40px; height:40px; object-fit: cover; border-radius:4px;"></td>
                                <td>Áo Polo Nam Regal Monogram</td>
                                <td>429,000đ</td>
                                <td><span class="status in-stock">Còn hàng</span></td>
                            </tr>
                            <tr>
                                <td>SP002</td>
                                <td><img src="${pageContext.request.contextPath}/images/varsity_jacket.jpg" 
                                         alt="${p.productName}" 
                                         style="width:40px; height:40px; object-fit: cover; border-radius:4px;"></td>
                                <td>Áo Khoác Varsity Nam Stallion</td>
                                <td>699,000đ</td>
                                <td><span class="status in-stock">Còn hàng</span></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </main>
        </div>
    </body>
</html>