<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng nhập | TH TRUE FASHION</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #4facfe;
            --bg-dark: #0f172a;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --white: #ffffff;
            --error: #ef4444;
            --success: #10b981;
            --transition: all 0.3s ease;
        }

        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .login-card {
            background: var(--white);
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 450px;
            position: relative;
        }

        .header-section { text-align: center; margin-bottom: 30px; }
        .logo-text { font-weight: 800; font-size: 1.5rem; color: var(--bg-dark); text-decoration: none; display: block; }
        .logo-text span { color: var(--primary); }

        .tab-group {
            display: flex;
            background: #f1f5f9;
            padding: 5px;
            border-radius: 12px;
            margin-bottom: 25px;
        }

        .tab {
            flex: 1;
            text-align: center;
            padding: 10px;
            font-size: 0.85rem;
            font-weight: 700;
            border-radius: 10px;
            text-decoration: none;
            color: var(--text-muted);
            transition: var(--transition);
        }

        .tab.active { background: var(--white); color: var(--primary); box-shadow: 0 4px 10px rgba(0,0,0,0.05); }

        .input-group { margin-bottom: 20px; position: relative; }

        /* Icon bên trái (User/Lock) */
        .input-group > i:first-child {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            z-index: 2;
        }

        .input-group input {
            width: 100%;
            padding: 14px 45px 14px 45px; /* Tăng padding trái và phải để tránh icon */
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.9rem;
            outline: none;
            transition: var(--transition);
            background: var(--white);
        }

        .input-group input:focus { border-color: var(--primary); box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.1); }

        /* Icon con mắt bên phải */
        .toggle-password {
            position: absolute;
            right: 16px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: var(--text-muted);
            z-index: 2;
            padding: 5px; /* Tăng vùng bấm */
        }

        .btn-login {
            width: 100%;
            padding: 15px;
            background: var(--bg-dark);
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 700;
            cursor: pointer;
            transition: var(--transition);
        }

        .btn-login:hover { background: var(--primary); transform: translateY(-2px); }

        .message-box { padding: 12px; border-radius: 10px; font-size: 0.85rem; margin-bottom: 20px; display: flex; align-items: center; gap: 10px; }
        .error { background: #fef2f2; color: var(--error); border-left: 4px solid var(--error); }
        .success { background: #f0fdf4; color: var(--success); border-left: 4px solid var(--success); }
        
        .extra-links { display: flex; justify-content: space-between; margin-top: 20px; font-size: 0.85rem; }
        .extra-links a { color: var(--text-muted); text-decoration: none; }
    </style>
</head>
<body>

    <div class="login-card">
        <div class="header-section">
            <a href="MainController" class="logo-text">TH TRUE <span>FASHION</span></a>
            <p style="margin-top: 5px; color: var(--text-main); font-weight: 500;">Mừng bạn trở lại!</p>
        </div>

        <div class="tab-group">
            <div class="tab active">ĐĂNG NHẬP</div>
            <a href="register.jsp" class="tab">ĐĂNG KÝ</a>
        </div>

        <form action="MainController" method="POST">
            <input type="hidden" name="action" value="login">

            <c:if test="${not empty requestScope.MESSAGE}">
                <div class="message-box success"><i class="fa-solid fa-circle-check"></i> ${requestScope.MESSAGE}</div>
            </c:if>

            <c:if test="${not empty requestScope.ERROR or not empty sessionScope.LOGIN_ERROR}">
                <div class="message-box error">
                    <i class="fa-solid fa-circle-exclamation"></i> ${requestScope.ERROR} ${sessionScope.LOGIN_ERROR}
                </div>
                <c:remove var="LOGIN_ERROR" scope="session" />
            </c:if>

            <div class="input-group">
                <i class="fa-solid fa-user"></i>
                <input type="text" name="loginID" placeholder="Email hoặc Tên đăng nhập" required>
            </div>

            <div class="input-group">
                <i class="fa-solid fa-lock"></i>
                <input type="password" name="password" id="password" placeholder="Mật khẩu" required>
                <i class="fa-solid fa-eye toggle-password" id="toggleIcon"></i>
            </div>

            <button type="submit" class="btn-login">ĐĂNG NHẬP</button>

            <div class="extra-links">
                <a href="register.jsp">Tạo tài khoản mới</a>
                <a href="#">Quên mật khẩu?</a>
            </div>
        </form>
    </div>

    <script>
        const togglePassword = document.querySelector('#toggleIcon');
        const passwordField = document.querySelector('#password');

        togglePassword.addEventListener('click', function () {
            const type = passwordField.getAttribute('type') === 'password' ? 'text' : 'password';
            passwordField.setAttribute('type', type);
            
            // Đổi icon con mắt
            this.classList.toggle('fa-eye');
            this.classList.toggle('fa-eye-slash');
        });
    </script>
</body>
</html>