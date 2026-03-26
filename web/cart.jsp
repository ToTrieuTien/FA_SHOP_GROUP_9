<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thanh toán | FA SHOP Premium</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;600;800&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary: #0f172a; /* Midnight Blue */
            --accent: #be123c;  /* Rose Crimson */
            --bg: #f1f5f9;
            --card-bg: #ffffff;
            --text-main: #1e293b;
            --text-sub: #64748b;
            --border: #e2e8f0;
            --glass: rgba(255, 255, 255, 0.1);
        }

        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
            background-color: var(--bg);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            line-height: 1.6;
        }

        .checkout-layout {
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            max-width: 1250px;
            margin: 50px auto;
            gap: 40px;
            padding: 0 25px;
        }

        /* --- KHỐI BÊN TRÁI: FORM THÔNG TIN --- */
        .info-card {
            background: var(--card-bg);
            padding: 45px;
            border-radius: 30px;
            border: 1px solid var(--border);
            box-shadow: 0 20px 60px rgba(0,0,0,0.02);
        }

        .section-header {
            font-size: 1.6rem;
            font-weight: 800;
            margin-bottom: 35px;
            display: flex;
            align-items: center;
            color: var(--primary);
            letter-spacing: -0.5px;
        }

        .section-header i { margin-right: 15px; color: var(--primary); opacity: 0.8; }

        .form-group { margin-bottom: 25px; }
        .form-group label {
            display: block;
            font-weight: 700;
            font-size: 0.85rem;
            margin-bottom: 10px;
            color: var(--text-sub);
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .input-premium {
            width: 100%;
            padding: 16px 20px;
            border: 1.5px solid var(--border);
            border-radius: 14px;
            font-size: 1rem;
            transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-sizing: border-box;
            background: #f8fafc;
        }

        .input-premium:focus {
            border-color: var(--primary);
            background: #fff;
            outline: none;
            box-shadow: 0 0 0 4px rgba(15, 23, 42, 0.08);
        }

        .payment-card {
            display: flex;
            align-items: center;
            padding: 22px;
            border: 1.8px solid var(--border);
            border-radius: 18px;
            margin-bottom: 15px;
            cursor: pointer;
            transition: 0.3s;
        }

        .payment-card:hover { border-color: var(--primary); background: #fdfdfd; }
        .payment-card input { margin-right: 18px; transform: scale(1.3); accent-color: var(--primary); }
        .payment-card i { font-size: 1.5rem; margin-right: 15px; color: var(--primary); }

        /* --- KHỐI BÊN PHẢI: TÚI ĐỒ --- */
        .summary-card {
            background: var(--primary);
            color: white;
            padding: 45px;
            border-radius: 35px;
            height: fit-content;
            position: sticky;
            top: 40px;
            box-shadow: 0 30px 70px rgba(15, 23, 42, 0.25);
        }

        .cart-item {
            display: flex;
            align-items: center;
            padding: 22px 0;
            border-bottom: 1px solid rgba(255,255,255,0.12);
        }

        .product-img {
            /* --- CẬP NHẬT: Tăng kích thước ảnh từ 75px lên 90px --- */
            width: 90px;
            height: 90px;
            /* --- CẬP NHẬT: Tăng độ bo góc để phù hợp kích thước mới --- */
            border-radius: 18px;
            overflow: hidden;
            margin-right: 20px;
            flex-shrink: 0;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(255,255,255,0.1); /* Thêm viền mờ cho ảnh nổi bật */
        }

        .product-img img { 
            width: 100%; 
            height: 100%; 
            object-fit: cover; /* Giữ nguyên tỷ lệ, cắt cúp thông minh */
            transition: 0.6s cubic-bezier(0.165, 0.84, 0.44, 1); /* Hiệu ứng mượt hơn */
        }
        
        .cart-item:hover .product-img img { 
            transform: scale(1.1); /* Zoom nhẹ khi hover */
        }

        .item-detail { flex-grow: 1; margin-right: 15px; } /* Thêm margin phải */
        .item-name { font-weight: 700; font-size: 1.05rem; display: block; margin-bottom: 4px; }
        .item-price { color: rgba(255,255,255,0.6); font-size: 0.9rem; }

        .qty-box {
            display: flex;
            align-items: center;
            background: rgba(255,255,255,0.1);
            border-radius: 12px;
            padding: 6px;
            flex-shrink: 0; /* Không cho cụm số lượng bị bóp */
        }

        .btn-qty {
            width: 28px; height: 28px;
            display: flex; justify-content: center; align-items: center;
            color: white; text-decoration: none; border-radius: 8px; font-weight: bold;
        }
        .btn-qty:hover { background: rgba(255,255,255,0.2); }

        .total-box {
            margin-top: 35px;
            padding-top: 30px;
            border-top: 2px solid rgba(255,255,255,0.1);
        }

        .btn-checkout-final {
            width: 100%;
            background: white;
            color: var(--primary);
            border: none;
            padding: 22px;
            border-radius: 20px;
            font-size: 1.15rem;
            font-weight: 800;
            cursor: pointer;
            margin-top: 35px;
            transition: 0.4s;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }

        .btn-checkout-final:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 40px rgba(255,255,255,0.2);
        }

        .error-msg { color: var(--accent); font-size: 0.8rem; font-weight: 600; margin-top: 8px; }
        
        /* Responsive */
        @media (max-width: 992px) {
            .checkout-layout { grid-template-columns: 1fr; }
            .summary-card { position: static; }
        }
    </style>
</head>
<body>

<div class="checkout-layout">
    <div class="info-card">
        <form id="checkoutForm" action="MainController" method="POST" onsubmit="return validateOnSubmit()">
            <input type="hidden" name="action" value="checkout">
            
            <div class="section-header"><i class="fa-solid fa-map-location-dot"></i> Giao hàng</div>
            
            <div class="form-group">
                <label>Họ tên khách hàng</label>
                <input type="text" name="fullName" class="input-premium" 
                       value="${sessionScope.LOGIN_USER.fullName}" required placeholder="Cristiano Ronaldo">
            </div>

            <div class="form-group">
                <label>Số điện thoại</label>
                <input type="text" name="phone" id="phoneInput" class="input-premium" 
                       oninput="saveTempInfo()"
                       value="${not empty sessionScope.TEMP_PHONE ? sessionScope.TEMP_PHONE : sessionScope.LOGIN_USER.phone}" 
                       placeholder="09xx xxx xxx" required>
                <span id="phoneError" class="error-msg"></span>
            </div>

            <div class="form-group">
                <label>Địa chỉ nhận hàng</label>
                <textarea name="shippingAddress" id="addressInput" class="input-premium" rows="3" 
                          oninput="saveTempInfo()" required placeholder="Số nhà, đường, quận...">${not empty sessionScope.TEMP_ADDRESS ? sessionScope.TEMP_ADDRESS : sessionScope.LOGIN_USER.address}</textarea>
            </div>

            <div class="section-header" style="margin-top: 50px;"><i class="fa-solid fa-wallet"></i> Thanh toán</div>
            
            <label class="payment-card">
                <input type="radio" name="paymentMethod" value="COD" checked>
                <i class="fa-solid fa-truck-ramp-box"></i>
                <div>
                    <div style="font-weight: 800;">Tiền mặt (COD)</div>
                    <div style="font-size: 0.85rem; color: var(--text-sub);">Nhận hàng rồi mới trả tiền</div>
                </div>
            </label>

            <label class="payment-card">
                <input type="radio" name="paymentMethod" value="QR">
                <i class="fa-solid fa-qrcode"></i>
                <div>
                    <div style="font-weight: 800;">Chuyển khoản QR-Code</div>
                    <div style="font-size: 0.85rem; color: var(--text-sub);">Xác nhận đơn hàng tức thì</div>
                </div>
            </label>
        </form>
    </div>

    <div class="summary-card">
        <h2 style="font-weight: 800; font-size: 2.2rem; margin: 0 0 30px 0;">Giỏ hàng của bạn</h2>
        
        <c:set var="total" value="0" />
        <c:forEach var="item" items="${sessionScope.CART.cart.values()}">
            <c:set var="total" value="${total + item.totalPrice}" />
            <div class="cart-item">
                <div class="product-img">
                    <img src="${item.imageURL}" alt="${item.productName}" 
                         onerror="this.src='https://via.placeholder.com/150?text=PRODUCT'">
                </div>

                <div class="item-detail">
                    <span class="item-name">${item.productName}</span>
                    <span class="item-price">
                        <fmt:formatNumber value="${item.basePrice}" type="number"/>₫
                    </span>
                </div>

                <div class="qty-box">
                    <a href="MainController?action=update-cart&id=${item.productID}&quantity=${item.quantity - 1}" class="btn-qty">−</a>
                    <span style="padding: 0 10px; font-weight: 800;">${item.quantity}</span>
                    <a href="MainController?action=update-cart&id=${item.productID}&quantity=${item.quantity + 1}" class="btn-qty">+</a>
                </div>
            </div>
        </c:forEach>

        <div class="total-box">
            <div style="display: flex; justify-content: space-between; align-items: flex-end;">
                <span style="opacity: 0.7; font-weight: 400;">Tổng cộng</span>
                <span style="font-size: 2.5rem; font-weight: 800;">
                    <fmt:formatNumber value="${total}" type="number"/>₫
                </span>
            </div>
        </div>

        <c:choose>
            <c:when test="${total > 0}">
                <button type="submit" form="checkoutForm" class="btn-checkout-final">Xác nhận thanh toán</button>
            </c:when>
            <c:otherwise>
                <button type="button" class="btn-checkout-final" disabled style="opacity: 0.4;">Giỏ hàng trống</button>
            </c:otherwise>
        </c:choose>
        
        <div style="text-align: center; margin-top: 25px; font-size: 0.8rem; opacity: 0.5;">
            <i class="fa-solid fa-shield-halved"></i> Thanh toán an toàn và bảo mật
        </div>
    </div>
</div>

<script>
    // Kiểm tra SĐT Việt Nam chuẩn
    function validatePhone(phone) {
        return /^(03|05|07|08|09|02)[0-9]{8}$/.test(phone);
    }

    // AJAX Lưu thông tin tạm thời (Để khi bấm + - số lượng không bị mất thông tin đã nhập)
    function saveTempInfo() {
        const phone = document.getElementById("phoneInput").value;
        const address = document.getElementById("addressInput").value;
        const errorSpan = document.getElementById("phoneError");

        if (phone !== "" && !validatePhone(phone)) {
            errorSpan.innerText = "Số điện thoại không đúng định dạng!";
        } else {
            errorSpan.innerText = "";
        }
        
        // Gọi CartController để lưu vào Session
        fetch('CartController?action=save-temp&phone=' + encodeURIComponent(phone) + '&address=' + encodeURIComponent(address));
    }

    function validateOnSubmit() {
        const phone = document.getElementById("phoneInput").value;
        if (!validatePhone(phone)) {
            alert("Vui lòng nhập đúng số điện thoại để chúng mình liên lạc nhé!");
            return false;
        }
        return true;
    }
</script>

</body>
</html>