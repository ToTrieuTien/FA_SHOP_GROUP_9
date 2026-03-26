<%-- 
    Document   : add_product
    Created on : Mar 24, 2026, 7:33:22 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thêm Sản Phẩm Mới - FA SHOP</title>
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
                    <li><a href="AdminMainController?action=manage-product">Quay lại Quản lý</a></li>
                </ul>
            </nav>

            <main class="main-content">
                <h1 class="dashboard-title">Thêm Sản Phẩm Mới</h1>

                <div class="data-board" style="padding: 30px;">
                    <form action="${pageContext.request.contextPath}/AddProductController" method="POST" enctype="multipart/form-data">

                        <div class="input-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="txtProductName" required style="width: 100%; padding: 10px; margin-top: 5px;">
                        </div>

                        <div class="input-group">
                            <label>Giá (VNĐ):</label>
                            <input type="number" name="txtPrice" required style="width: 100%; padding: 10px; margin-top: 5px;">
                        </div>

                        <div class="input-group">
                            <label>Danh mục:</label>
                            <select name="ddlCategory" style="width: 100%; padding: 10px; margin-top: 5px;" required>
                                <option value="" disabled selected>-- Chọn danh mục sản phẩm --</option>
                                <c:forEach var="c" items="${requestScope.LIST_CATEGORY}">
                                    <option value="${c.categoryID}">${c.categoryName}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="input-group">
                            <label>Upload Hình ảnh (Tải thẳng từ máy tính):</label>
                            <input type="file" name="fileImage" accept="image/*" required style="width: 100%; padding: 10px; margin-top: 5px; background: #f9f9f9; border: 1px dashed #ccc;">
                        </div>

                        <div class="input-group" style="margin-top: 20px;">
                            <button type="submit" class="btn-primary">Lưu Sản Phẩm</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </body>
</html>
