<%-- 
    Document   : login
    Created on : Mar 16, 2026, 3:37:42 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Đăng nhập - FA SHOP</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <div class="login-container">
        <div class="login-breadcrumb">
            Trang chủ / Danh mục / Tài khoản / <span>Đăng nhập</span>
        </div>
        
        <h2 class="login-title">ĐĂNG NHẬP TÀI KHOẢN</h2>

        <div class="login-card">
            <div class="login-tabs">
                <div class="tab active">ĐĂNG NHẬP</div>               
            </div>

            <form action="MainController" method="POST" class="login-form">
                <input type="hidden" name="action" value="login">
                
                <div class="input-group">
                    <input type="email" name="email" placeholder="Nhập email của bạn" required>
                </div>

                <div class="input-group">
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                    <span class="show-password-icon">👁</span>
                </div>

                <p class="error-msg">${requestScope.ERROR}</p>

                <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
                
                <div class="forgot-password">
                    <a href="#">Quên mật khẩu?</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
