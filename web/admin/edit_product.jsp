<%-- 
    Document   : edit_product
    Created on : Mar 24, 2026, 8:25:18 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Cập nhật Sản Phẩm - FA SHOP</title>
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
                <h1 class="dashboard-title">Cập nhật Sản Phẩm: ${PRODUCT_INFO.productName}</h1>

                <div class="data-board" style="padding: 30px;">
                    <form action="${pageContext.request.contextPath}/UpdateProductController" method="POST" enctype="multipart/form-data" accept-charset="UTF-8">

                        <input type="hidden" name="txtProductID" value="${PRODUCT_INFO.productID}">

                        <div class="input-group">
                            <label>Tên sản phẩm:</label>
                            <input type="text" name="txtProductName" value="${PRODUCT_INFO.productName}" required style="width: 100%; padding: 10px; margin-top: 5px;">
                        </div>

                        <div class="input-group">
                            <label>Giá (VNĐ):</label>
                            <input type="number" name="txtPrice" value="${PRODUCT_INFO.basePrice.intValue()}" required style="width: 100%; padding: 10px; margin-top: 5px;">
                        </div>

                        <div class="input-group">
                            <label>Danh mục:</label>
                            <select name="ddlCategory" style="width: 100%; padding: 10px; margin-top: 5px;">
                                <c:forEach var="c" items="${requestScope.LIST_CATEGORY}">
                                    <option value="${c.categoryID}" ${PRODUCT_INFO.categoryID == c.categoryID ? 'selected' : ''}>
                                        ${c.categoryName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="input-group">
                            <label>Trạng thái kinh doanh:</label>
                            <select name="ddlStatus" style="width: 100%; padding: 10px; margin-top: 5px;">
                                <option value="true" ${PRODUCT_INFO.status == true ? 'selected' : ''}>Còn hàng</option>
                                <option value="false" ${PRODUCT_INFO.status == false ? 'selected' : ''}>Hết hàng / Tạm ẩn</option>
                            </select>
                        </div>

                        <div class="input-group">
                            <label>Hình ảnh hiện tại:</label><br>
                            <img src="${pageContext.request.contextPath}/images/${PRODUCT_INFO.imageURL}" alt="Chưa có ảnh" style="width: 100px; height: 100px; object-fit: cover; border-radius: 4px; border: 1px solid #ccc; margin-top: 5px;">
                        </div>

                        <div class="input-group">
                            <label>Upload Hình ảnh mới (Bỏ trống nếu muốn giữ ảnh cũ):</label>
                            <input type="file" name="fileImage" accept="image/*" style="width: 100%; padding: 10px; margin-top: 5px; background: #f9f9f9; border: 1px dashed #ccc;">
                        </div>

                        <div class="input-group" style="margin-top: 20px;">
                            <button type="submit" class="btn-primary">Lưu Thay Đổi</button>
                        </div>
                    </form>
                </div>
            </main>
        </div>
    </body>
</html>
