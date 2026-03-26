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
        :root { --primary: #003366; --danger: #dc3545; --bg: #f4f7f9; --success: #28a745; --gray: #6c757d; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); margin: 0; padding: 40px 0; }
        .container { max-width: 900px; margin: 0 auto; padding: 0 20px; }
        
        .order-card { background: white; border-radius: 12px; margin-bottom: 20px; box-shadow: 0 2px 15px rgba(0,0,0,0.05); border-left: 5px solid var(--primary); overflow: hidden; }
        .order-header { background: #fafafa; padding: 15px 20px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .order-body { padding: 20px; display: grid; grid-template-columns: 1fr 1fr; gap: 15px; }
        
        /* Màu sắc trạng thái linh hoạt */
        .status { padding: 6px 14px; border-radius: 20px; font-size: 0.8rem; font-weight: bold; }
        .status-processing { background: #fff3cd; color: #856404; } /* Chờ xác nhận */
        .status-shipping { background: #d1ecf1; color: #0c5460; }    /* Đang giao */
        .status-canceled { background: #f8d7da; color: #721c24; }    /* Đã hủy */
        
        .total-section { padding: 15px 20px; background: #fff; border-top: 1px dashed #eee; display: flex; justify-content: space-between; align-items: center; }
        .total-price { color: var(--danger); font-size: 1.4rem; font-weight: bold; }
        
        /* Style cho nút Hủy */
        .btn-cancel { 
            background: transparent; color: var(--danger); border: 1px solid var(--danger);
            padding: 8px 16px; border-radius: 6px; cursor: pointer; font-weight: 600;
            text-decoration: none; transition: 0.3s; font-size: 0.85rem;
        }
        .btn-cancel:hover { background: var(--danger); color: white; }
    </style>
</head>
<body>
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
</body>
</html>