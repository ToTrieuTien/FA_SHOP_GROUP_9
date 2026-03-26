<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Thanh toán QR - FA SHOP</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            :root {
                --dark-blue: #003366;
                --accent-red: #d9534f;
                --bg-body: #f4f7f9;
            }
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: var(--bg-body);
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: 100vh;
            }
            .qr-container {
                background: white;
                padding: 40px;
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                max-width: 450px;
                width: 90%;
                text-align: center;
            }
            .title {
                color: var(--dark-blue);
                font-weight: 800;
                text-transform: uppercase;
                margin-bottom: 25px;
                letter-spacing: 1px;
            }
            .qr-code {
                border: 1px solid #eee;
                padding: 15px;
                border-radius: 12px;
                margin-bottom: 20px;
                width: 100%;
                max-width: 280px;
                transition: transform 0.3s;
            }
            .qr-code:hover {
                transform: scale(1.02);
            }
            .order-info {
                background: #f8f9fa;
                padding: 20px;
                border-radius: 12px;
                text-align: left;
                margin-bottom: 25px;
                border: 1px solid #eef0f2;
            }
            .order-info p {
                margin: 10px 0;
                font-size: 0.95rem;
                color: #444;
                display: flex;
                justify-content: space-between;
            }
            .amount {
                color: var(--accent-red);
                font-weight: 800;
                font-size: 1.25rem;
            }
            .status-badge {
                background: #fff3cd;
                color: #856404;
                padding: 3px 10px;
                border-radius: 15px;
                font-size: 0.85rem;
                font-weight: 600;
            }
            .btn-confirm {
                width: 100%;
                padding: 16px;
                background: var(--dark-blue);
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 700;
                cursor: pointer;
                text-transform: uppercase;
                transition: all 0.3s ease;
                font-size: 0.95rem;
                box-shadow: 0 4px 12px rgba(0, 51, 102, 0.2);
            }
            .btn-confirm:hover {
                background: #002244;
                transform: translateY(-2px);
                box-shadow: 0 6px 15px rgba(0, 51, 102, 0.3);
            }
            .note {
                font-size: 0.85rem;
                color: #777;
                margin-top: 20px;
                line-height: 1.5;
                padding: 0 10px;
            }
        </style>
    </head>
    <body>

        <div class="qr-container">
            <h2 class="title"><i class="fa-solid fa-qrcode"></i> Thanh toán QR</h2>

            <img src="${requestScope.QR_LINK}" alt="VietQR" class="qr-code">

            <div class="order-info">
                <p><strong><i class="fa-solid fa-file-invoice"></i> Nội dung:</strong> <span>${requestScope.ORDER_DESC}</span></p>
                <p><strong><i class="fa-solid fa-money-bill-wave"></i> Số tiền:</strong> 
                    <span class="amount">
                        <fmt:formatNumber value="${requestScope.TOTAL}" type="number"/>₫
                    </span>
                </p>
                <p><strong><i class="fa-solid fa-spinner"></i> Trạng thái:</strong> <span class="status-badge">Chờ quét mã...</span></p>
            </div>

            <form action="CartController" method="POST">
                <input type="hidden" name="orderID" value="${requestScope.ORDER_ID}">

                <button type="submit" name="action" value="confirm-payment" class="btn-confirm">
                    <i class="fa-solid fa-check-circle"></i> Tôi đã chuyển khoản thành công
                </button>
            </form>

            <p class="note">
                <i class="fa-solid fa-circle-info"></i> 
                <i>Hệ thống sẽ kiểm tra và xác nhận đơn hàng ngay khi nhận được thông báo từ ngân hàng. Vui lòng không tắt trình duyệt cho đến khi nhận được thông báo thành công.</i>
            </p>
        </div>

    </body>
</html>