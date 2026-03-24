<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
                <a href="register.jsp" class="tab" style="text-decoration: none;">ĐĂNG KÝ</a>
            </div>

            <form action="MainController" method="POST" class="login-form">
                <input type="hidden" name="action" value="login">
                
                <div class="input-group">
                    <input type="text" name="loginID" placeholder="Nhập Email hoặc Tên đăng nhập" required>
                </div>

                <div class="input-group">
                    <input type="password" name="password" placeholder="Mật khẩu" required>
                    <span class="show-password-icon">👁</span>
                </div>

                <p class="error-msg" style="color: red; text-align: left; margin-bottom: 15px; font-weight: bold;">
                    ${requestScope.ERROR}
                    ${sessionScope.LOGIN_ERROR}
                </p>
                <c:remove var="LOGIN_ERROR" scope="session" />

                <button type="submit" class="btn-login">ĐĂNG NHẬP</button>
                
                <div class="forgot-password" style="margin-top: 15px; text-align: center;">
                    <a href="#" style="color: #000; text-decoration: none; font-size: 14px;">Quên mật khẩu?</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>