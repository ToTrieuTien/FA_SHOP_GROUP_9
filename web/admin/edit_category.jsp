<%-- 
    Document   : edit_category
    Created on : Mar 25, 2026, 11:43:56 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chỉnh Sửa Danh Mục - FA SHOP</title>
        <%-- Đường dẫn CSS chuẩn theo cấu trúc của em --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="wrapper">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h2>ICON DENIM</h2>
                    <p>Admin Panel</p>
                </div>
                <ul class="sidebar-menu">
                    <li><a href="AdminMainController?action=dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li class="active"><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <h1>Chỉnh Sửa Danh Mục</h1>
                    <a href="AdminMainController?action=manage-category" class="btn-primary">Quay lại danh sách</a>
                </div>

                <%-- Khung chứa form sửa --%>
                <div class="data-board" style="padding: 40px; max-width: 600px;">
                    <form action="AdminMainController?action=update-category" method="POST" class="login-form">

                        <%-- Ô input ẩn để giữ lại ID danh mục khi submit form --%>
                        <input type="hidden" name="txtID" value="${requestScope.CAT_DETAIL.categoryID}">

                        <div class="input-group">
                            <label style="display: block; margin-bottom: 10px; font-weight: bold; color: #555;">Tên danh mục hiện tại:</label>
                            <%-- Hiển thị tên cũ vào ô input để người dùng sửa --%>
                            <input type="text" name="txtCategoryName" 
                                   value="${requestScope.CAT_DETAIL.categoryName}" 
                                   required 
                                   style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 4px;">
                        </div>

                        <div style="margin-top: 30px;">
                            <button type="submit" class="btn-login" style="width: 100%;">CẬP NHẬT THAY ĐỔI</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </body>
</html>
