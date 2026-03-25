<%-- 
    Document   : add_category
    Created on : Mar 25, 2026, 11:34:27 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Thêm Danh Mục Mới - FA SHOP</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    </head>
    <body>
        <div class="wrapper">
            <%-- Sidebar em có thể dùng c:import hoặc copy từ trang category sang --%>
            <main class="main-content">
                <div class="page-header">
                    <h1>Thêm Danh Mục Mới</h1>
                    <a href="AdminMainController?action=manage-category" class="btn-primary">Quay lại</a>
                </div>

                <div class="data-board" style="padding: 40px; max-width: 600px;">
                    <form action="AdminMainController?action=add-category" method="POST" class="login-form">
                        <div class="input-group">
                            <label>Tên danh mục:</label>
                            <input type="text" name="txtCategoryName" required placeholder="Nhập tên danh mục (VD: Áo Khoác)...">
                        </div>
                        <button type="submit" class="btn-login">XÁC NHẬN THÊM</button>
                    </form>
                </div>
            </main>
        </div>
    </body>
</html>
