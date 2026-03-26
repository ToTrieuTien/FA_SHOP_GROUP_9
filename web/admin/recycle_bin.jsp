<%-- 
    Document   : recycle_bin
    Created on : Mar 24, 2026, 11:13:14 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thùng Rác - FA SHOP</title>
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
                    <li class="active"><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">
                <div class="page-header">
                    <h1 class="dashboard-title">Thùng Rác Sản Phẩm</h1>
                    <a href="AdminMainController?action=manage-product" class="btn-primary" style="background-color: #6c757d;">
                        <i class="fas fa-arrow-left"></i> Quay lại Danh sách
                    </a>
                </div>

                <div class="data-board">
                    <div class="data-board-header">
                        <h3>Sản phẩm đã xóa (Đang ẩn)</h3>
                    </div>

                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>#ID</th>
                                <th>HÌNH ẢNH</th>
                                <th>TÊN SẢN PHẨM</th>
                                <th>GIÁ (VNĐ)</th>
                                <th>TRẠNG THÁI</th>
                                <th>HÀNH ĐỘNG</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="p" items="${requestScope.LIST_DELETED_PRODUCT}">
                                <tr>
                                    <td>SP00${p.productID}</td>
                                    <td>
                                        <img src="${pageContext.request.contextPath}/images/${p.imageURL}" 
                                             class="table-img" 
                                             alt="${p.productName}">
                                    </td>
                                    <td style="color: #888; text-decoration: line-through;">${p.productName}</td>
                                    <td>${p.basePrice}đ</td>
                                    <td>
                                        <span class="status out-of-stock">Đã xóa</span>
                                    </td>

                                    <td class="action-cell">
                                        <a href="AdminMainController?action=restore-product&id=${p.productID}" 
                                           class="btn-edit" 
                                           style="background-color: #10b981; color: white;" 
                                           title="Khôi phục"
                                           onclick="return confirm('Khôi phục sản phẩm này về cửa hàng?');">
                                            <i class="fas fa-undo"></i>
                                        </a>

                                        <a href="AdminMainController?action=hard-delete-product&id=${p.productID}" 
                                           class="btn-delete" 
                                           style="background-color: #dc2626; color: white;" 
                                           title="Xóa Vĩnh Viễn" 
                                           onclick="return confirm('CẢNH BÁO: Bạn có chắc chắn muốn xóa VĨNH VIỄN sản phẩm này? Hành động này không thể hoàn tác!');">
                                            <i class="fas fa-eraser"></i>
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
