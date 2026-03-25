<%-- 
    Document   : admin_category
    Created on : Mar 24, 2026, 1:23:45 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Danh Mục - FA SHOP</title>
        <%-- Sử dụng đường dẫn chuẩn để link tới file CSS em vừa gửi --%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <%-- Lớp .wrapper là lớp quan trọng nhất để chia 2 cột Sidebar và Main-content --%>
        <div class="wrapper">

            <aside class="sidebar">
                <div class="sidebar-header">
                    <h2>TH True Fashion Shop</h2>
                    <p>Admin Panel</p>
                </div>
                <%-- Cấu trúc menu phải có ul và li để khớp với CSS sidebar-menu li a --%>
                <ul class="sidebar-menu">
                    <li><a href="AdminMainController?action=dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li class="active"><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <div class="page-header" style="display: flex; gap: 10px; align-items: center;">
                    <h1>Quản lý Danh Mục</h1>
                    <div style="display: flex; gap: 10px;">
                        <a href="AdminMainController?action=recycle-bin-category" class="btn-primary" style="background-color: #ff4d4d; border: none;">
                            <i class="fas fa-trash-alt"></i> Thùng Rác
                        </a>
                        <a href="AdminMainController?action=add-category-page" class="btn-primary">+ Thêm Danh Mục</a>
                    </div>
                </div>

                <%-- Sử dụng lớp .data-board để tạo khung trắng bao quanh bảng --%>
                <div class="data-board">
                    <div class="data-board-header">
                        <h3>Danh sách danh mục</h3>
                        <div class="search-box">
                            <form action="AdminMainController" method="GET" style="display: flex; gap: 5px;">
                                <input type="hidden" name="action" value="search-category">
                                <input type="text" name="txtSearch" placeholder="Tìm kiếm danh mục..." value="${param.txtSearch}">
                                <button type="submit" class="btn-primary" style="padding: 8px 15px;"><i class="fas fa-search"></i></button>
                            </form>
                        </div>
                    </div>

                    <%-- Sử dụng lớp .data-table để căn chỉnh các cột thẳng hàng --%>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>TÊN DANH MỤC</th>
                                <th>SỐ SẢN PHẨM</th>
                                <th>TRẠNG THÁI</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="cat" items="${requestScope.LIST_CATEGORY}">
                                <tr>
                                    <td>DM${cat.categoryID}</td>
                                    <td><strong>${cat.categoryName}</strong></td>
                                    <td>${cat.productCount}</td>
                                    <td>
                                        <%-- Sử dụng lớp status để hiện nhãn màu --%>
                                        <span class="status ${cat.status ? 'in-stock' : 'out-of-stock'}">
                                            ${cat.status ? 'Hoạt động' : 'Đã ẩn'}
                                        </span>
                                    </td>
                                    <td>
                                        <%-- Lớp action-cell để căn chỉnh các nút Sửa/Xóa --%>
                                        <div class="action-cell">
                                            <a href="AdminMainController?action=edit-category&id=${cat.categoryID}" class="btn-edit" title="Sửa">
                                                <i class="fas fa-pencil-alt"></i>
                                            </a>
                                            <a href="AdminMainController?action=delete-category&id=${cat.categoryID}" 
                                               class="btn-delete" title="Xóa"
                                               onclick="return confirm('Bạn có chắc chắn muốn ẩn danh mục này?')">
                                                <i class="fas fa-trash"></i>
                                            </a>
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
