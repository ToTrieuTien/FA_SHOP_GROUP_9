<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Lịch Sử Đơn Hàng | TH TRUE FASHION</title>
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
                --gray: #94a3b8;
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
               2. MAIN CONTAINER & TIÊU ĐỀ
               ========================================================================== */
            .container {
                max-width: 1000px;
                margin: 50px auto;
                padding: 0 20px;
                min-height: 60vh;
            }
            .page-title {
                font-size: 2rem;
                font-weight: 800;
                margin-bottom: 30px;
                color: var(--bg-dark);
                display: flex;
                align-items: center;
                gap: 15px;
            }

            /* ==========================================================================
               3. ORDER CARD (THẺ ĐƠN HÀNG)
               ========================================================================== */
            .order-card {
                background: white;
                border-radius: 16px;
                padding: 25px;
                margin-bottom: 25px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.03);
                border: 1px solid #e2e8f0;
                border-left: 5px solid var(--primary-blue);
                transition: var(--transition);
            }
            .order-card:hover {
                transform: translateY(-3px);
                box-shadow: 0 15px 35px rgba(0,0,0,0.08);
            }

            /* Header thẻ đơn hàng */
            .order-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                border-bottom: 2px dashed #f1f5f9;
                padding-bottom: 15px;
                margin-bottom: 15px;
            }
            .order-header strong {
                font-size: 1.2rem;
                font-weight: 800;
                color: var(--bg-dark);
            }

            /* Nhãn trạng thái (Status Badges) */
            .status {
                padding: 8px 16px;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: 700;
                display: inline-flex;
                align-items: center;
                gap: 6px;
            }
            .status-processing {
                background: #fef9c3;
                color: #854d0e;
            }
            .status-shipping {
                background: #e0f2fe;
                color: #0284c7;
            }
            .status-canceled {
                background: #fee2e2;
                color: #991b1b;
            }

            /* Nội dung thông tin (Body) */
            .order-body {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 15px;
                margin-bottom: 20px;
                color: #475569;
                font-size: 0.95rem;
            }
            .order-body div i {
                color: var(--primary-blue);
                width: 25px;
                font-size: 1.1rem;
            }
            .order-body div b {
                color: #1e293b;
                font-weight: 700;
            }

            /* Phần Tổng tiền & Nút bấm (Footer) */
            .total-section {
                display: flex;
                justify-content: space-between;
                align-items: center;
                background: #f8fafc;
                padding: 15px 20px;
                border-radius: 12px;
            }
            .total-price {
                font-size: 1.4rem;
                font-weight: 800;
                color: var(--danger);
                margin-left: 10px;
            }

            /* Nút Hủy đơn hàng */
            .btn-cancel {
                background: white;
                color: var(--danger);
                border: 1px solid var(--danger);
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: bold;
                text-decoration: none;
                transition: var(--transition);
                display: inline-flex;
                align-items: center;
                gap: 8px;
            }
            .btn-cancel:hover {
                background: var(--danger);
                color: white;
            }

            /* Nút Xóa lịch sử */
            .btn-delete-history {
                color: var(--gray);
                text-decoration: none;
                font-size: 0.85rem;
                font-weight: bold;
                padding: 8px 12px;
                border-radius: 6px;
                transition: 0.2s;
                background: #f1f5f9;
            }
            .btn-delete-history:hover {
                background: #e2e8f0;
                color: var(--danger);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container">
            <h2 class="page-title">
                <i class="fa-solid fa-clock-rotate-left" style="color: var(--primary-blue);"></i> Lịch sử đơn hàng của bạn
            </h2>

            <c:if test="${empty LIST_ORDERS}">
                <div style="text-align: center; background: white; padding: 60px 20px; border-radius: 16px; border: 2px dashed #cbd5e1;">
                    <i class="fa-solid fa-box-open" style="font-size: 4rem; color: #cbd5e1; margin-bottom: 20px;"></i>
                    <h3 style="color: #64748b; margin-bottom: 15px;">Bạn chưa có đơn hàng nào!</h3>
                    <a href="MainController" style="display: inline-block; padding: 12px 25px; background: var(--bg-dark); color: white; text-decoration: none; border-radius: 8px; font-weight: bold;">Mua sắm ngay</a>
                </div>
            </c:if>

            <c:forEach var="o" items="${LIST_ORDERS}">
                <div class="order-card" style="${o.status == 'Canceled' ? 'border-left-color: var(--gray); opacity: 0.85;' : ''}">

                    <div class="order-header">
                        <strong>Mã đơn: #${o.orderID}</strong>

                        <c:choose>
                            <%-- Đang kiểm tra giao dịch --%>
                            <c:when test="${o.status == '1' || o.status == 'Processing' || o.status == 'Awaiting Payment'}">
                                <span class="status status-processing"><i class="fa-solid fa-spinner fa-spin"></i> Đang kiểm tra giao dịch</span>
                            </c:when>

                            <%-- Đã hủy & Nút Xóa --%>
                            <c:when test="${o.status == 'Canceled'}">
                                <div style="display: flex; align-items: center; gap: 15px;">
                                    <span class="status status-canceled"><i class="fa-solid fa-ban"></i> Đã hủy</span>

                                    <a href="MainController?action=delete-order&orderID=${o.orderID}" 
                                       class="btn-delete-history"
                                       onclick="return confirm('Bạn có chắc chắn muốn xóa đơn hàng #${o.orderID} khỏi lịch sử không?')">
                                        <i class="fa-solid fa-trash-can"></i> Xóa
                                    </a>
                                </div>
                            </c:when>

                            <%-- Đang giao hàng --%>
                            <c:when test="${o.status == 'Shipping'}">
                                <span class="status status-shipping"><i class="fa-solid fa-truck-fast"></i> Đang giao hàng</span>
                            </c:when>

                            <%-- Hoàn thành --%>
                            <c:when test="${o.status == 'Completed'}">
                                <span class="status" style="background: #dcfce7; color: #166534;"><i class="fa-solid fa-check-double"></i> Hoàn thành</span>
                            </c:when>

                            <%-- Mặc định --%>
                            <c:otherwise>
                                <span class="status" style="background: #e2e8f0; color: #475569;">${o.status}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div class="order-body">
                        <div><i class="fa-regular fa-calendar"></i> <b>Ngày đặt:</b> ${o.orderDate}</div>
                        <div><i class="fa-regular fa-user"></i> <b>Người nhận:</b> ${o.customerName != null ? o.customerName : sessionScope.LOGIN_USER.fullName}</div>
                        <div style="grid-column: span 2;"><i class="fa-solid fa-location-dot"></i> <b>Địa chỉ:</b> ${o.shippingAddress}</div>
                        <div><i class="fa-solid fa-phone"></i> <b>SĐT:</b> ${o.phone}</div>
                    </div>

                    <div class="total-section">
                        <div>
                            <%-- Chỉ hiện nút Hủy khi đơn đang xử lý --%>
                            <c:if test="${o.status == '1' || o.status == 'Processing' || o.status == 'Awaiting Payment'}">
                                <a href="MainController?action=cancel-order&orderID=${o.orderID}" 
                                   class="btn-cancel"
                                   onclick="return confirm('Bạn có chắc chắn muốn hủy đơn hàng #${o.orderID} không?')">
                                    <i class="fa-solid fa-xmark"></i> Hủy đơn hàng
                                </a>
                            </c:if>
                        </div>
                        <div>
                            <span style="color: #64748b; font-size: 0.9rem;">Tổng thanh toán:</span> 
                            <span class="total-price"><fmt:formatNumber value="${o.totalMoney}" type="number"/>₫</span>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>