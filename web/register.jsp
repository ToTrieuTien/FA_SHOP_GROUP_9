<%-- 
    Document   : register
    Created on : Mar 24, 2026, 10:40:50 PM
    Author     : SE193621-PhạmGiaHuy
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng ký tài khoản - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-breadcrumb">
            Trang chủ / Danh mục / Tài khoản / <span>Đăng ký</span>
        </div>
        
        <h2 class="login-title">ĐĂNG KÝ THÀNH VIÊN</h2>

        <div class="login-card">
            <div class="login-tabs">
                <a href="login.jsp" class="tab" style="text-decoration: none;">ĐĂNG NHẬP</a>
                <div class="tab active">ĐĂNG KÝ</div>               
            </div>

            <form action="RegisterController" method="POST" class="login-form">
                
                <div class="input-group">
                    <input type="text" name="txtUserID" placeholder="Tên đăng nhập (Ví dụ: SE123456)" required>
                </div>

                <div class="input-group">
                    <input type="password" name="txtPassword" placeholder="Mật khẩu" required>
                </div>
                
                <div class="input-group">
                    <input type="password" name="txtConfirm" placeholder="Xác nhận lại mật khẩu" required>
                </div>

                <div class="input-group">
                    <input type="text" name="txtFullName" placeholder="Họ và tên" required>
                </div>

                <div class="input-group">
                    <input type="email" name="txtEmail" placeholder="Email" required>
                </div>

                <div class="input-group">
                    <input type="text" name="txtAddress" placeholder="Địa chỉ">
                </div>

                <div class="input-group">
                    <input type="text" name="txtPhone" placeholder="Số điện thoại">
                </div>

                <p class="error-msg" style="color: red; text-align: left; margin-top: 5px;">${requestScope.ERROR}</p>

                <button type="submit" class="btn-login">ĐĂNG KÝ</button>
            </form>
        </div>
    </div>
</body>
</html>