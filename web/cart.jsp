<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán - TH TrueShop</title>
    <style>
        :root {
            --dark-blue: #003366; 
            --accent-red: #d9534f;
            --border-color: #e0e0e0;
            --bg-body: #f0f2f5;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--bg-body); margin: 0; color: #333; }
        .container { display: flex; max-width: 1150px; margin: 40px auto; gap: 30px; padding: 0 15px; }
        
        /* Cột trái: Form thông tin */
        .info-section { 
            flex: 1.8; 
            background: white; 
            padding: 35px; 
            border-radius: 12px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
        }
        
        .section-title { 
            color: var(--dark-blue); 
            font-size: 1.5rem; 
            font-weight: 800; 
            text-transform: uppercase; 
            margin-bottom: 30px; 
            border-left: 6px solid var(--dark-blue);
            padding-left: 15px;
            letter-spacing: 0.5px;
        }

        .form-group { margin-bottom: 22px; }
        .form-group label { 
            display: block; 
            font-weight: 600; 
            margin-bottom: 10px; 
            font-size: 0.95rem;
            color: #444;
        }
        
        .input-control { 
            width: 100%; 
            padding: 15px; 
            border: 1.5px solid var(--border-color); 
            border-radius: 10px; 
            font-size: 1rem;
            transition: all 0.3s ease;
            box-sizing: border-box;
            background-color: #fff;
        }
        .input-control:focus { 
            outline: none; 
            border-color: var(--dark-blue); 
            box-shadow: 0 0 0 4px rgba(0, 51, 102, 0.1); 
        }

        .payment-option {
            display: flex;
            align-items: center;
            padding: 18px;
            border: 1.5px solid var(--border-color);
            border-radius: 10px;
            margin-bottom: 15px;
            cursor: pointer;
            font-weight: 600;
            transition: 0.2s;
        }
        .payment-option input { margin-right: 15px; transform: scale(1.3); }
        .payment-option:hover { background-color: #f8f9fa; }
        
        /* Cột phải: Tóm tắt giỏ hàng */
        .cart-summary { 
            flex: 1.2; 
            background: white; 
            padding: 25px; 
            border-radius: 12px; 
            box-shadow: 0 4px 20px rgba(0,0,0,0.08); 
            height: fit-content;
            position: sticky;
            top: 20px;
        }
        
        .summary-title { font-size: 1.3rem; font-weight: 700; margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .cart-item { padding: 15px 0; border-bottom: 1px solid #f1f1f1; }
        .item-info { display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 8px; }
        .item-name { font-weight: 600; font-size: 0.95rem; margin: 0; flex: 1; padding-right: 10px; }
        
        .quantity-box {
            display: flex;
            align-items: center;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: fit-content;
            margin: 10px 0;
            overflow: hidden;
        }
        .btn-qty {
            background: #f8f9fa;
            border: none;
            padding: 5px 12px;
            cursor: pointer;
            font-size: 1.1rem;
            font-weight: bold;
            color: var(--dark-blue);
            text-decoration: none;
        }
        .btn-qty:hover { background: #e9ecef; }
        .qty-value { padding: 0 12px; font-weight: 600; border-left: 1px solid #ddd; border-right: 1px solid #ddd; }

        .item-price { color: var(--accent-red); font-weight: 700; font-size: 1rem; }

        .total-section { 
            margin-top: 25px; 
            padding-top: 20px; 
            border-top: 2px dashed #ddd; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }
        .total-label { font-size: 1.1rem; font-weight: 700; }
        .total-amount { color: var(--accent-red); font-size: 1.6rem; font-weight: 800; }

        .btn-order { 
            width: 100%; 
            padding: 20px; 
            background: var(--dark-blue); 
            color: white; 
            border: none; 
            border-radius: 10px; 
            font-size: 1.2rem; 
            font-weight: 700; 
            cursor: pointer; 
            margin-top: 30px;
            transition: 0.3s;
            text-transform: uppercase;
        }
        .btn-order:hover { background: #002244; box-shadow: 0 5px 15px rgba(0, 51, 102, 0.3); }
        .error-msg { color: var(--accent-red); background: #fdf2f2; padding: 10px; border-radius: 5px; margin-bottom: 20px; font-weight: 600; }
        
        @media (max-width: 850px) { .container { flex-direction: column; } }
    </style>
</head>
<body>

    <div class="container">
        <div class="info-section">
            <h2 class="section-title">Thông tin đơn hàng</h2>
            
            <c:if test="${not empty requestScope.ERROR}">
                <div class="error-msg">${requestScope.ERROR}</div>
            </c:if>

            <form id="checkoutForm" action="MainController" method="POST">
                <input type="hidden" name="action" value="checkout">
                
                <div class="form-group">
                    <label>Họ và tên người nhận</label>
                    <input type="text" name="fullName" class="input-control" 
                           value="${sessionScope.LOGIN_USER.fullName}" placeholder="Ví dụ: Nguyễn Văn A">
                </div>

                <div class="form-group">
                    <label>Số điện thoại liên hệ</label>
                    <input type="text" name="phone" class="input-control" 
                           value="${not empty requestScope.SAVED_PHONE ? requestScope.SAVED_PHONE : sessionScope.LOGIN_USER.phone}" 
                           placeholder="Nhập số điện thoại để shop gọi xác nhận" required>
                </div>

                <div class="form-group">
                    <label>Địa chỉ nhận hàng (chi tiết)</label>
                    <textarea name="shippingAddress" class="input-control" rows="3" 
                              placeholder="Số nhà, tên đường, Phường/Xã, Quận/Huyện..." 
                              required>${not empty requestScope.SAVED_ADDRESS ? requestScope.SAVED_ADDRESS : sessionScope.LOGIN_USER.address}</textarea>
                </div>

                <h2 class="section-title" style="margin-top: 45px;">Hình thức thanh toán</h2>
                <div class="payment-methods">
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="COD" checked>
                        <span>🏠 Thanh toán khi nhận hàng (COD)</span>
                    </label>
                    <label class="payment-option">
                        <input type="radio" name="paymentMethod" value="QR">
                        <span>📱 Chuyển khoản qua mã QR-Code</span>
                    </label>
                </div>
            </form>
        </div>

        <div class="cart-summary">
            <h2 class="summary-title">Giỏ hàng (${sessionScope.CART.cart.size()} sản phẩm)</h2>
            
            <c:set var="total" value="0" />
            <c:forEach var="item" items="${sessionScope.CART.cart.values()}">
                <c:set var="total" value="${total + item.totalPrice}" />
                <div class="cart-item">
                    <div class="item-info">
                        <p class="item-name">${item.productName}</p>
                    </div>
                    
                    <div class="quantity-box">
                        <a href="MainController?action=update-cart&id=${item.productID}&quantity=${item.quantity - 1}" class="btn-qty">-</a>
                        <span class="qty-value">${item.quantity}</span>
                        <a href="MainController?action=update-cart&id=${item.productID}&quantity=${item.quantity + 1}" class="btn-qty">+</a>
                    </div>
                    
                    <div class="item-price">
                        <fmt:formatNumber value="${item.totalPrice}" type="number"/>₫
                    </div>
                </div>
            </c:forEach>

            <div class="total-section">
                <span class="total-label">Tổng tiền:</span>
                <span class="total-amount">
                    <fmt:formatNumber value="${total}" type="number"/>₫
                </span>
            </div>
            
            <input type="hidden" name="totalMoney" form="checkoutForm" value="${total}">
            <button type="submit" form="checkoutForm" class="btn-order">ĐẶT HÀNG NGAY</button>
            
            <p style="text-align: center; margin-top: 15px;">
                <a href="MainController" style="color: #888; text-decoration: none; font-size: 0.9rem;">← Tiếp tục mua sắm</a>
            </p>
        </div>
    </div>

</body>
</html>