<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Chi tiết sản phẩm | TH TRUE FASHION SHOP</title>
        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
                background-color: #f1f5f9;
                margin: 0;
                color: #0a0e17;
            }
            .wrapper {
                display: block;
                padding-bottom: 50px;
            }
            .login-breadcrumb {
                max-width: 1200px;
                margin: 20px auto;
                padding: 0 20px;
            }
            .login-breadcrumb a {
                text-decoration: none;
                color: #64748b;
                font-weight: bold;
            }
            .login-breadcrumb span {
                color: #0a0e17;
                font-weight: bold;
            }

            .data-board {
                max-width: 1100px;
                margin: 0 auto;
                padding: 40px;
                background: white;
                border-radius: 20px;
                display: flex;
                gap: 50px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.05);
            }

            .qty-box {
                display: flex;
                align-items: center;
                border: 1px solid #cbd5e1;
                width: fit-content;
                border-radius: 8px;
                overflow: hidden;
            }
            .qty-btn {
                background: #f8f9fa;
                border: none;
                font-size: 20px;
                font-weight: bold;
                color: #ef4444;
                padding: 8px 18px;
                cursor: pointer;
                transition: 0.2s;
            }
            .qty-btn:hover {
                background: #e2e8f0;
            }
            .qty-input {
                width: 50px;
                text-align: center;
                border: none;
                font-size: 16px;
                font-weight: bold;
                outline: none;
                background: transparent;
            }

            #toastMessage {
                position: fixed;
                top: 100px;
                right: 20px;
                background-color: #10b981;
                color: white;
                padding: 15px 25px;
                border-radius: 12px;
                box-shadow: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
                z-index: 9999;
                font-weight: bold;
                transition: 0.5s;
                display: flex;
                align-items: center;
                gap: 10px;
                opacity: 0;
                visibility: hidden;
            }
            #toastMessage.show {
                opacity: 1;
                visibility: visible;
                top: 110px;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp" />

        <c:if test="${not empty sessionScope.ADD_SUCCESS}">
            <div id="toastMessage" class="show">
                <i class="fa-solid fa-circle-check"></i> ${sessionScope.ADD_SUCCESS}
            </div>
            <script>
                setTimeout(() => {
                    const toast = document.getElementById("toastMessage");
                    if (toast) {
                        toast.classList.remove("show");
                        setTimeout(() => toast.remove(), 500);
                    }
                }, 3000);
            </script>
            <c:remove var="ADD_SUCCESS" scope="session"/>
        </c:if>

        <div class="wrapper">
            <div class="login-breadcrumb">
                <a href="MainController">Trang chủ</a> / <span>Chi tiết sản phẩm</span>
            </div>

            <div class="data-board">
                <div style="flex: 1; text-align: center;">
                    <img src="${pageContext.request.contextPath}/images/${PRODUCT_DETAIL.imageURL}" 
                         alt="${PRODUCT_DETAIL.productName}" 
                         style="max-width: 100%; border-radius: 16px; box-shadow: 0 8px 25px rgba(0,0,0,0.08);">
                </div>

                <div style="flex: 1.2;">
                    <h1 style="margin-top: 0; font-size: 32px; color: #0a0e17;">${PRODUCT_DETAIL.productName}</h1>
                    <h2 style="color: #ef4444; font-size: 28px; margin: 15px 0;">
                        <fmt:formatNumber value="${PRODUCT_DETAIL.basePrice}" pattern="#,###"/> VNĐ
                    </h2>

                    <hr style="border: 0; border-top: 1px solid #e2e8f0; margin: 25px 0;">

                    <p style="font-size: 16px; line-height: 1.8; color: #475569;"><strong>Mô tả:</strong> ${PRODUCT_DETAIL.description}</p>
                    <p style="font-size: 16px; margin-top: 15px; margin-bottom: 25px;"><strong>Tình trạng:</strong> 
                        <c:choose>
                            <c:when test="${PRODUCT_DETAIL.status == true}">
                                <span style="background: #dcfce7; color: #166534; padding: 6px 15px; border-radius: 20px; font-size: 14px; font-weight: bold;">Còn hàng</span>
                            </c:when>
                            <c:otherwise>
                                <span style="background: #fee2e2; color: #991b1b; padding: 6px 15px; border-radius: 20px; font-size: 14px; font-weight: bold;">Tạm hết hàng</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <form action="MainController" method="POST">
                        <input type="hidden" name="productID" value="${PRODUCT_DETAIL.productID}">

                        <div style="margin-bottom: 20px;">
                            <label style="font-weight: bold; margin-bottom: 10px; display: block; color: #0a0e17;">Kích thước (Size):</label>
                            <div style="display: flex; gap: 15px;">
                                <label style="cursor: pointer; border: 1px solid #cbd5e1; padding: 8px 20px; border-radius: 8px;"><input type="radio" name="size" value="S" required style="margin-right: 5px;"> S</label>
                                <label style="cursor: pointer; border: 1px solid #cbd5e1; padding: 8px 20px; border-radius: 8px;"><input type="radio" name="size" value="M" style="margin-right: 5px;"> M</label>
                                <label style="cursor: pointer; border: 1px solid #cbd5e1; padding: 8px 20px; border-radius: 8px;"><input type="radio" name="size" value="L" style="margin-right: 5px;"> L</label>
                                <label style="cursor: pointer; border: 1px solid #cbd5e1; padding: 8px 20px; border-radius: 8px;"><input type="radio" name="size" value="XL" style="margin-right: 5px;"> XL</label>
                            </div>
                        </div>

                        <div style="margin-bottom: 30px;">
                            <label style="font-weight: bold; margin-bottom: 10px; display: block; color: #0a0e17;">Số lượng:</label>
                            <div class="qty-box">
                                <button type="button" class="qty-btn" onclick="document.getElementById('qty').stepDown()">−</button>
                                <input type="number" id="qty" name="quantity" class="qty-input" value="1" min="1" max="50" readonly>
                                <button type="button" class="qty-btn" onclick="document.getElementById('qty').stepUp()">+</button>
                            </div>
                        </div>

                        <c:if test="${PRODUCT_DETAIL.status == true}">
                            <div style="display: flex; gap: 15px;">
                                <button type="submit" name="action" value="add-to-cart" style="flex: 1; padding: 16px; background-color: #0a0e17; color: white; border: none; border-radius: 10px; font-weight: bold; font-size: 15px; cursor: pointer; transition: 0.3s;">
                                    THÊM VÀO GIỎ
                                </button>

                                <button type="submit" name="action" value="buy-now" style="flex: 1; padding: 16px; background-color: #ef4444; color: white; border: none; border-radius: 10px; font-weight: bold; font-size: 15px; cursor: pointer; transition: 0.3s;">
                                    MUA NGAY
                                </button>
                            </div>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>