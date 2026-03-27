<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng ký thành viên | TH TRUE FASHION</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --primary: #4facfe;
            --secondary: #00f2fe;
            --bg-dark: #0f172a;
            --text-main: #1e293b;
            --text-muted: #64748b;
            --white: #ffffff;
            --error: #ef4444;
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .register-container {
            width: 100%;
            max-width: 500px;
            perspective: 1000px;
        }

        .register-card {
            background: var(--white);
            padding: 40px;
            border-radius: 24px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.1);
            border: 1px solid rgba(255, 255, 255, 0.8);
            position: relative;
            overflow: hidden;
        }

        /* Hiệu ứng trang trí góc */
        .register-card::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            width: 100px;
            height: 100px;
            background: var(--primary);
            border-radius: 50%;
            opacity: 0.1;
        }

        .header-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .logo-text {
            font-weight: 800;
            font-size: 1.5rem;
            color: var(--bg-dark);
            text-decoration: none;
            letter-spacing: -1px;
            display: block;
            margin-bottom: 10px;
        }

        .logo-text span { color: var(--primary); }

        .title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-main);
        }

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
            cursor: pointer;
            border-radius: 10px;
            transition: var(--transition);
            text-decoration: none;
            color: var(--text-muted);
        }

        .tab.active {
            background: var(--white);
            color: var(--primary);
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        .input-group {
            margin-bottom: 18px;
            position: relative;
        }

        .input-group i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        .input-group input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 1.5px solid #e2e8f0;
            border-radius: 12px;
            font-size: 0.9rem;
            outline: none;
            transition: var(--transition);
        }

        .input-group input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(79, 172, 254, 0.1);
        }

        .btn-register {
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
            margin-top: 10px;
        }

        .btn-register:hover {
            background: var(--primary);
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(79, 172, 254, 0.3);
        }

        .error-msg {
            background: #fef2f2;
            color: var(--error);
            padding: 10px;
            border-radius: 8px;
            font-size: 0.8rem;
            margin-bottom: 15px;
            display: ${not empty requestScope.ERROR ? 'block' : 'none'};
            border-left: 4px solid var(--error);
        }

        .footer-text {
            text-align: center;
            margin-top: 20px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .footer-text a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>

    <div class="register-container">
        <div class="register-card">
            <div class="header-section">
                <a href="MainController" class="logo-text">TH TRUE <span>FASHION</span></a>
                <p class="title">Đăng ký thành viên</p>
            </div>

            <div class="tab-group">
                <a href="login.jsp" class="tab">ĐĂNG NHẬP</a>
                <div class="tab active">ĐĂNG KÝ</div>
            </div>

            <form action="RegisterController" method="POST">
                
                <div class="error-msg">
                    <i class="fa-solid fa-circle-exclamation"></i> ${requestScope.ERROR}
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-user-tag"></i>
                    <input type="text" name="txtUserID" placeholder="Tên đăng nhập (ví dụ: SE196703)" required>
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-signature"></i>
                    <input type="text" name="txtFullName" placeholder="Họ và tên" required>
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="txtEmail" placeholder="Email" required>
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" name="txtPassword" placeholder="Mật khẩu" required>
                </div>
                
                <div class="input-group">
                    <i class="fa-solid fa-shield-check"></i>
                    <input type="password" name="txtConfirm" placeholder="Xác nhận mật khẩu" required>
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-phone"></i>
                    <input type="text" name="txtPhone" placeholder="Số điện thoại">
                </div>

                <div class="input-group">
                    <i class="fa-solid fa-location-dot"></i>
                    <input type="text" name="txtAddress" placeholder="Địa chỉ giao hàng">
                </div>

                <button type="submit" class="btn-register">TẠO TÀI KHOẢN</button>
            </form>

            <div class="footer-text">
                Đã có tài khoản? <a href="login.jsp">Đăng nhập ngay</a>
            </div>
        </div>
    </div>

</body>
</html>