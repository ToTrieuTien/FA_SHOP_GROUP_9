<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang chủ | TH TRUE FASHION SHOP</title>

        <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

        <style>
            :root {
                --bg-dark: #0a0e17;
                --primary-blue: #4facfe;
                --text-white: #f8fafc;
                --danger: #ef4444;
                --card-bg: #ffffff;
                --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
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
            }

            /* --- TOAST NOTIFICATION --- */
            #toastMessage {
                position: fixed;
                top: 100px;
                right: 20px;
                background-color: #10b981;
                color: white;
                padding: 15px 25px;
                border-radius: 12px;
                box-shadow: var(--shadow-lg);
                z-index: 9999;
                font-weight: bold;
                transition: 0.5s;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            /* --- PRODUCT GRID --- */
            .container {
                max-width: 1300px;
                margin: 60px auto;
                padding: 0 20px;
            }
            .section-title {
                text-align: center;
                margin-bottom: 50px;
            }
            .section-title h2 {
                font-size: 2.2rem;
                font-weight: 800;
                letter-spacing: 1px;
            }
            .underline {
                width: 70px;
                height: 5px;
                background: var(--primary-blue);
                margin: 15px auto;
                border-radius: 10px;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
                gap: 35px;
            }
            .product-card {
                background: var(--card-bg);
                border-radius: 24px;
                padding: 18px;
                transition: 0.4s;
                border: 1px solid #e2e8f0;
                position: relative;
                text-align: center;
            }
            .product-card:hover {
                transform: translateY(-12px);
                box-shadow: var(--shadow-lg);
                border-color: var(--primary-blue);
            }

            .img-box {
                width: 100%;
                height: 320px;
                border-radius: 18px;
                overflow: hidden;
                background: #f8fafc;
                margin-bottom: 20px;
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
                font-size: 1.3rem;
                font-weight: 800;
                margin-bottom: 20px;
                display: block;
            }
            .btn-view {
                display: block;
                background: var(--bg-dark);
                color: white;
                text-align: center;
                text-decoration: none;
                padding: 12px;
                border-radius: 14px;
                font-weight: 700;
                font-size: 0.85rem;
                transition: 0.3s;
            }
            .btn-view:hover {
                background: #4CAF50;
            }
        </style>
    </head>

    <body>
        <c:if test="${not empty sessionScope.SUCCESS_MSG}">
            <div id="toastMessage">
                <i class="fa-solid fa-circle-check"></i> ${sessionScope.SUCCESS_MSG}
            </div>
            <c:remove var="SUCCESS_MSG" scope="session" />
            <script>
                setTimeout(() => {
                    const toast = document.getElementById("toastMessage");
                    if (toast) {
                        toast.style.opacity = "0";
                        setTimeout(() => toast.remove(), 500);
                    }
                }, 3000);
            </script>
        </c:if>

        <jsp:include page="header.jsp" />

        <main class="container">
            <div class="section-title">
                <h2>SẢN PHẨM MỚI NHẤT</h2>
                <div class="underline"></div>
            </div>

            <div class="product-grid">
                <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                    <div class="product-card">
                        <div class="img-box">
                            <img src="${pageContext.request.contextPath}/images/${p.imageURL}" alt="${p.productName}">
                        </div>
                        <h3 style="font-size: 1rem; margin-bottom: 10px; height: 45px; overflow: hidden;">${p.productName}</h3>
                        <span class="price"><fmt:formatNumber value="${p.basePrice}" pattern="#,###"/> VNĐ</span>
                        <a href="MainController?action=view-product&id=${p.productID}" class="btn-view">XEM CHI TIẾT</a>
                    </div>
                </c:forEach>
            </div>
        </main>

        <jsp:include page="footer.jsp" />
    </body>
</html>