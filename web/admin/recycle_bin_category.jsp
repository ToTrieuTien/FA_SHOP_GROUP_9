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
    <title>Thùng Rác Danh Mục - FA SHOP</title>
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
                <h1>Thùng Rác Danh Mục</h1>
                <%-- Nút quay lại trang danh sách chính --%>
                <a href="AdminMainController?action=manage-category" class="btn-primary">
                    <i class="fas fa-arrow-left"></i> Quay lại Danh sách
                </a>
            </div>

            <div class="data-board">
                <div class="data-board-header">
                    <h3>Danh mục đã bị ẩn</h3>
                </div>

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
                        <%-- Đổ dữ liệu từ RecycleBinCategoryController gửi sang --%>
                        <c:forEach var="cat" items="${requestScope.LIST_DELETED_CATEGORY}">
                            <tr>
                                <td>DM${cat.categoryID}</td>
                                <td><strong>${cat.categoryName}</strong></td>
                                <td>${cat.productCount}</td>
                                <td>
                                    <%-- Trạng thái luôn là Đã ẩn (out-of-stock) vì đang trong thùng rác --%>
                                    <span class="status out-of-stock">Đã ẩn</span>
                                </td>
                                <td>
                                    <div class="action-cell">
                                        <%-- Nút Khôi Phục (Màu Xanh lá) --%>
                                        <a href="AdminMainController?action=restore-category&id=${cat.categoryID}" 
                                           class="btn-edit" style="background-color: #e6fff0; color: #00b050;" title="Khôi phục">
                                            <i class="fas fa-trash-restore"></i>
                                        </a>
                                        
                                        <%-- Nút Xóa Cứng (Màu Đỏ) --%>
                                        <a href="AdminMainController?action=hard-delete-category&id=${cat.categoryID}" 
                                           class="btn-delete" style="background-color: #ffe6e6; color: #ff4d4d;" title="Xóa vĩnh viễn"
                                           onclick="return confirm('CẢNH BÁO: Hành động này sẽ xóa vĩnh viễn danh mục khỏi hệ thống. Bạn chắc chắn chứ?')">
                                            <i class="fas fa-times-circle"></i>
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>

                        <%-- Hiển thị thông báo nếu thùng rác trống --%>
                        <c:if test="${empty requestScope.LIST_DELETED_CATEGORY}">
                            <tr>
                                <td colspan="5" style="text-align: center; padding: 30px; color: #888;">
                                    <i class="fas fa-box-open" style="font-size: 30px; margin-bottom: 10px; display: block;"></i>
                                    Thùng rác đang trống.
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
