<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán QR - TH TrueShop</title>
    <style>
        :root {
            --dark-blue: #003366; 
            --accent-red: #d9534f;
            --bg-body: #f0f2f5;
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: var(--bg-body); margin: 0; display: flex; justify-content: center; align-items: center; min-height: 100vh; }
        .qr-container { background: white; padding: 40px; border-radius: 15px; box-shadow: 0 4px 25px rgba(0,0,0,0.1); max-width: 450px; width: 90%; text-align: center; }
        .title { color: var(--dark-blue); font-weight: 800; text-transform: uppercase; margin-bottom: 20px; }
        .qr-code { border: 2px solid #eee; padding: 15px; border-radius: 12px; margin-bottom: 20px; width: 100%; max-width: 250px; }
        .order-info { background: #f8f9fa; padding: 15px; border-radius: 10px; text-align: left; margin-bottom: 25px; }
        .order-info p { margin: 8px 0; font-size: 0.95rem; color: #555; }
        .amount { color: var(--accent-red); font-weight: 800; font-size: 1.2rem; }
        .btn-confirm { 
            width: 100%; padding: 15px; background: var(--dark-blue); color: white; border: none; 
            border-radius: 8px; font-weight: 700; cursor: pointer; text-transform: uppercase; transition: 0.3s;
        }
        .btn-confirm:hover { background: #002244; transform: translateY(-2px); }
        .note { font-size: 0.8rem; color: #888; margin-top: 15px; line-height: 1.4; }
    </style>
</head>
<body>

    <div class="qr-container">
        <h2 class="title">Thanh toán qua mã QR</h2>
        
        <img src="${requestScope.QR_LINK}" alt="VietQR" class="qr-code">
        
        <div class="order-info">
            <p><strong>Nội dung:</strong> ${requestScope.ORDER_DESC}</p>
            <p><strong>Số tiền:</strong> <span class="amount"><fmt:formatNumber value="${requestScope.TOTAL}" type="number"/>₫</span></p>
            <p><strong>Trạng thái:</strong> Chờ quét mã...</p>
        </div>

        <form action="MainController" method="POST">
            <button type="submit" name="action" value="confirm-payment" class="btn-confirm">Tôi đã chuyển khoản thành công</button>
        </form>

        <p class="note">
            <i>Hệ thống sẽ kiểm tra và xác nhận đơn hàng của bạn ngay khi nhận được thông báo từ ngân hàng.</i>
        </p>
    </div>

</body>
</html> 