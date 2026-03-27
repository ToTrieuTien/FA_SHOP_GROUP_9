<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch Sử Đơn Hàng | FA SHOP</title>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* ==========================================================================
               1. BIẾN DÙNG CHUNG & RESET
               ========================================================================== */
            :root {
                --bg-dark: #0a0e17;
                --primary-blue: #4facfe;
                --text-white: #ffffff;
                --danger: #ef4444;
                --card-bg: #ffffff;
                --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                --transition: 0.3s cubic-bezier(0.165, 0.84, 0.44, 1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
                background-color: #f1f5f9;
                color: var(--bg-dark);
                line-height: 1.6;
            }

            /* ==========================================================================
               2. TOAST MESSAGE (THÔNG BÁO)
               ========================================================================== */
            #toastMessage {
                position: fixed;
                top: 110px;
                right: 20px;
                background-color: #10b981;
                color: white;
                padding: 15px 25px;
                border-radius: 12px;
                box-shadow: var(--shadow-lg);
                z-index: 9999;
                font-weight: bold;
                display: flex;
                align-items: center;
                gap: 10px;
                transition: opacity 0.5s ease;
            }

            /* ==========================================================================
               3. HEADER & MEGA MENU
               ========================================================================== */
            .header {
                background: var(--bg-dark);
                height: 90px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 4%;
                position: sticky;
                top: 0;
                z-index: 1000;
                box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            }

            .logo a {
                color: var(--primary-blue);
                font-size: 1.4rem;
                font-weight: 800;
                text-decoration: none;
            }
            .logo span {
                color: var(--text-white);
            }

            .nav-menu {
                display: flex;
                list-style: none;
                gap: 25px;
                align-items: center;
                height: 100%;
                margin: 0;
            }
            .nav-item {
                position: relative;
                height: 100%;
                display: flex;
                align-items: center;
            }

            .nav-link {
                color: var(--text-white) !important;
                text-decoration: none;
                font-weight: 700;
                font-size: 0.85rem;
                text-transform: uppercase;
                transition: var(--transition);
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .nav-link:hover {
                color: var(--primary-blue) !important;
            }

            /* Badge NEW */
            .badge-new {
                background: var(--danger);
                color: white !important;
                font-size: 9px;
                padding: 2px 6px;
                border-radius: 4px;
                margin-left: 5px;
            }

            /* Logic Mega Menu */
            .mega-menu {
                visibility: hidden;
                opacity: 0;
                position: absolute;
                top: 90%;
                left: 0;
                transform: translateY(20px);
                background: white;
                width: 600px;
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                padding: 25px;
                border-radius: 12px;
                box-shadow: 0 20px 50px rgba(0,0,0,0.15);
                transition: var(--transition);
                border: 1px solid #e2e8f0;
            }

            .nav-item:hover .mega-menu {
                visibility: visible;
                opacity: 1;
                transform: translateY(0);
            }

            .mega-col h3 {
                color: var(--bg-dark);
                font-size: 0.9rem;
                font-weight: 800;
                margin-bottom: 12px;
                border-bottom: 2px solid #f1f5f9;
                padding-bottom: 5px;
            }

            .mega-col ul {
                list-style: none;
            }
            .mega-col a {
                color: #64748b;
                text-decoration: none;
                font-size: 0.8rem;
                display: block;
                margin-bottom: 8px;
                transition: 0.2s;
            }
            .mega-col a:hover {
                color: var(--primary-blue);
                transform: translateX(5px);
            }

            /* ==========================================================================
               4. ACTIONS (SEARCH, CART, USER)
               ========================================================================== */
            .header-actions {
                display: flex;
                align-items: center;
                gap: 20px;
            }

            .search-container {
                background: rgba(255, 255, 255, 0.1);
                border-radius: 50px;
                padding: 8px 15px;
                display: flex;
                align-items: center;
                width: 220px;
                transition: 0.4s;
                border: 1px solid rgba(255,255,255,0.1);
            }
            .search-container:focus-within {
                background: white;
                width: 280px;
            }
            .search-container input {
                background: transparent;
                border: none;
                outline: none;
                color: white;
                width: 100%;
                font-size: 0.85rem;
            }
            .search-container:focus-within input {
                color: var(--bg-dark);
            }
            .search-container button {
                background: none;
                border: none;
                color: var(--primary-blue);
                cursor: pointer;
            }

            .action-icon {
                color: var(--text-white);
                font-size: 1.2rem;
                position: relative;
                text-decoration: none;
                transition: 0.3s;
            }
            .action-icon:hover {
                color: var(--primary-blue);
            }

            .cart-badge {
                position: absolute;
                top: -8px;
                right: -12px;
                background: var(--danger);
                color: white;
                font-size: 10px;
                padding: 2px 6px;
                border-radius: 50%;
                font-weight: 800;
                border: 2px solid var(--bg-dark);
            }

            /* ==========================================================================
               5. PRODUCT GRID & SECTION TITLE
               ========================================================================== */
            .container {
                max-width: 1200px;
                margin: 50px auto;
                padding: 0 20px;
            }

            .section-title {
                text-align: center;
                margin-bottom: 40px;
            }
            .section-title h2 {
                font-size: 1.8rem;
                font-weight: 800;
                color: var(--bg-dark);
            }
            .underline {
                width: 60px;
                height: 4px;
                background: var(--primary-blue);
                margin: 10px auto;
                border-radius: 10px;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 30px;
            }

            .product-card {
                background: var(--card-bg);
                border-radius: 20px;
                padding: 15px;
                transition: 0.4s;
                border: 1px solid #e2e8f0;
                text-align: center;
            }
            .product-card:hover {
                transform: translateY(-10px);
                box-shadow: var(--shadow-lg);
                border-color: var(--primary-blue);
            }

            .img-box {
                width: 100%;
                height: 280px;
                border-radius: 15px;
                overflow: hidden;
                background: #f8fafc;
                margin-bottom: 15px;
            }
            .img-box img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: 0.6s;
            }
            .product-card:hover img {
                transform: scale(1.1);
            }

            .price {
                color: var(--danger);
                font-size: 1.2rem;
                font-weight: 800;
                display: block;
                margin-bottom: 15px;
            }

            .btn-view {
                display: block;
                background: var(--bg-dark);
                color: white !important;
                text-decoration: none;
                padding: 10px;
                border-radius: 12px;
                font-weight: 700;
                font-size: 0.8rem;
                transition: 0.3s;
            }
            .btn-view:hover {
                background: #4CAF50;
                box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .header {
                    height: auto;
                    padding: 15px;
                    flex-direction: column;
                    gap: 15px;
                }
                .nav-menu {
                    display: none;
                } /* Ẩn menu chính trên mobile */
                .search-container {
                    width: 100%;
                }
            }
        </style>

    </head>
    <body>
        <jsp:include page="header.jsp" />
        <div class="container">
            <h2 style="color: var(--primary); margin-bottom: 30px;">
                <i class="fa-solid fa-clock-rotate-left"></i> Lịch sử đơn hàng của bạn
            </h2>

            <c:if test="${empty LIST_ORDERS}">
                <div style="text-align: center; background: white; padding: 50px; border-radius: 12px;">
                    <p>Bạn chưa có đơn hàng nào. <a href="MainController">Mua sắm ngay!</a></p>
                </div>
            </c:if>

            <c:forEach var="o" items="${LIST_ORDERS}">
                <div class="order-card" style="${o.status == 'Canceled' ? 'border-left-color: var(--gray); opacity: 0.8;' : ''}">
                    <div class="order-header">
                        <strong>Mã đơn: #${o.orderID}</strong>

                        <%-- Hiển thị Label trạng thái dựa trên database --%>
                        <%-- Hiển thị Label trạng thái dựa trên database --%>
                        <c:choose>
                            <%-- TRƯỜNG HỢP 1: Đang kiểm tra giao dịch --%>
                            <c:when test="${o.status == '1' || o.status == 'Processing' || o.status == 'Awaiting Payment'}">
                                <span class="status status-processing">Đang kiểm tra giao dịch</span>
                            </c:when>

                            <%-- TRƯỜNG HỢP 2: Đã hủy - BỔ SUNG NÚT XÓA Ở ĐÂY --%>
                            <c:when test="${o.status == 'Canceled'}">
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <span class="status status-canceled">Đã hủy</span>

                                    <%-- Nút Xóa lịch sử đơn hàng --%>
                                    <a href="MainController?action=delete-order&orderID=${o.orderID}" 
                                       style="color: var(--gray); text-decoration: none; font-size: 0.8rem;"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng #${o.orderID} khỏi lịch sử không?')">
                                        <i class="fa-solid fa-trash-can"></i> Xóa
                                    </a>
                                </div>
                            </c:when>

                            <%-- TRƯỜNG HỢP 3: Đang giao hàng --%>
                            <c:when test="${o.status == 'Shipping'}">
                                <span class="status status-shipping">Đang giao hàng</span>
                            </c:when>

                            <%-- TRƯỜNG HỢP MẶC ĐỊNH --%>
                            <c:otherwise>
                                <span class="status" style="background: #eee; color: #333;">${o.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="order-body">
                        <div><i class="fa-regular fa-calendar"></i> <b>Ngày đặt:</b> ${o.orderDate}</div>
                        <div><i class="fa-regular fa-user"></i> <b>Người nhận:</b> ${o.customerName}</div>
                        <div><i class="fa-solid fa-location-dot"></i> <b>Địa chỉ:</b> ${o.shippingAddress}</div>
                        <div><i class="fa-solid fa-phone"></i> <b>SĐT:</b> ${o.phone}</div>
                    </div>

                    <div class="total-section">
                        <div>
                            <%-- CHỈ HIỆN NÚT HỦY KHI ĐƠN CHƯA GIAO/CHƯA HỦY --%>
                            <c:if test="${o.status == '1' || o.status == 'Processing'}">
                                <a href="MainController?action=cancel-order&orderID=${o.orderID}" 
                                   class="btn-cancel"
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${o.orderID} không?')">
                                    <i class="fa-solid fa-trash-can"></i> Hủy đơn hàng
                                </a>
                            </c:if>
                        </div>
                        <div>
                            Tổng thanh toán: <span class="total-price"><fmt:formatNumber value="${o.totalMoney}" type="number"/>₫</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <jsp:include page="footer.jsp" />
    </body>
</html>