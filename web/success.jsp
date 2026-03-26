<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Đặt hàng thành công - TH TRUESHOP</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f7f6; display: flex; align-items: center; justify-content: center; height: 100vh; margin: 0; }
        .success-card { background: white; padding: 50px; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); text-align: center; max-width: 500px; }
        .icon-circle { width: 80px; height: 80px; background: #4bb543; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 40px; margin: 0 auto 20px; }
        h1 { color: #2c3e50; margin-bottom: 10px; }
        p { color: #7f8c8d; line-height: 1.6; margin-bottom: 30px; }
        .order-id { font-weight: bold; color: #003366; background: #eef2f7; padding: 5px 15px; border-radius: 5px; }
        .btn-group { display: flex; gap: 15px; justify-content: center; }
        .btn { padding: 12px 25px; border-radius: 8px; text-decoration: none; font-weight: bold; transition: 0.3s; }
        .btn-primary { background: #003366; color: white; }
        .btn-primary:hover { background: #002244; }
        .btn-outline { border: 2px solid #003366; color: #003366; }
        .btn-outline:hover { background: #003366; color: white; }
    </style>
</head>
<body>
    <div class="success-card">
        <div class="icon-circle">✓</div>
        <h1>Tuyệt vời!</h1>
        <p>Cảm ơn bạn đã tin tưởng <strong>TH TrueShop</strong>. Đơn hàng của bạn đã được ghi nhận thành công và đang chờ xử lý.</p>
        <div class="btn-group">
            <a href="MainController" class="btn btn-primary">Tiếp tục mua sắm</a>
            <%-- Nút dẫn tới tính năng mới bạn yêu cầu --%>
            <a href="MainController?action=view-my-orders" class="btn btn-outline">Theo dõi đơn hàng</a>
        </div>
    </div>
</body>
</html>