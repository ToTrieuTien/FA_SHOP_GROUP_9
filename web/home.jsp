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
            /* --- BIẾN TOÀN CỤC & RESET --- */
            :root {
                --primary-blue: #4facfe;
                --bg-dark: #0f172a;
                --text-light: #64748b;
                --danger: #ef4444;
                --card-shadow: 0 10px 25px rgba(0,0,0,0.05);
                --transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            }

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Plus Jakarta Sans', sans-serif;
                background-color: #f8fafc;
                color: var(--bg-dark);
            }

            /* --- TOAST MESSAGE --- */
            #toastMessage {
                position: fixed;
                top: 100px;
                right: 20px;
                background: #10b981;
                color: white;
                padding: 16px 24px;
                border-radius: 12px;
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
                z-index: 9999;
                display: flex;
                align-items: center;
                gap: 10px;
                font-weight: 600;
                transition: var(--transition);
            }

            /* --- HEADER --- */
            .header {
                background: var(--bg-dark);
                height: 80px;
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 5%;
                position: sticky;
                top: 0;
                z-index: 1000;
                box-shadow: 0 4px 20px rgba(0,0,0,0.2);
            }

            .logo a {
                color: var(--primary-blue);
                font-size: 1.5rem;
                font-weight: 800;
                text-decoration: none;
            }
            .logo span {
                color: white;
            }

            .nav-menu {
                display: flex;
                list-style: none;
                gap: 30px;
                height: 100%;
                align-items: center;
            }
            .nav-item {
                position: relative;
                height: 100%;
                display: flex;
                align-items: center;
            }
            .nav-link {
                color: rgba(255,255,255,0.85) !important;
                text-decoration: none;
                font-weight: 700;
                font-size: 0.85rem;
                letter-spacing: 0.5px;
            }
            .nav-link:hover {
                color: var(--primary-blue) !important;
            }

            /* MEGA MENU */
            .mega-menu {
                position: absolute;
                top: 80px;
                left: -50px;
                width: 650px;
                background: white;
                border-radius: 16px;
                padding: 30px;
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 20px;
                box-shadow: 0 20px 40px rgba(0,0,0,0.15);
                opacity: 0;
                visibility: hidden;
                transform: translateY(10px);
                transition: var(--transition);
                border: 1px solid #f1f5f9;
            }
            .nav-item:hover .mega-menu {
                opacity: 1;
                visibility: visible;
                transform: translateY(0);
            }
            .mega-col h3 {
                font-size: 0.9rem;
                color: var(--bg-dark);
                margin-bottom: 15px;
                border-bottom: 2px solid #f1f5f9;
                padding-bottom: 5px;
            }
            .mega-col ul {
                list-style: none;
            }
            .mega-col a {
                color: var(--text-light);
                text-decoration: none;
                font-size: 0.85rem;
                display: block;
                margin-bottom: 8px;
                transition: 0.2s;
            }
            .mega-col a:hover {
                color: var(--primary-blue);
                transform: translateX(5px);
            }

            .badge-new {
                background: var(--danger);
                font-size: 9px;
                padding: 2px 6px;
                border-radius: 4px;
                margin-left: 4px;
            }

            /* ACTIONS */
            .header-actions {
                display: flex;
                align-items: center;
                gap: 15px;
            }
            .search-container {
                background: rgba(255,255,255,0.1);
                border-radius: 50px;
                padding: 8px 18px;
                display: flex;
                align-items: center;
                border: 1px solid rgba(255,255,255,0.05);
            }
            .search-container input {
                background: transparent;
                border: none;
                outline: none;
                color: white;
                width: 160px;
                font-size: 0.8rem;
            }
            .search-container button {
                background: none;
                border: none;
                color: var(--primary-blue);
                cursor: pointer;
            }

            .action-icon {
                color: white;
                text-decoration: none;
                font-size: 1.2rem;
                position: relative;
                transition: 0.3s;
            }
            .action-icon:hover {
                color: var(--primary-blue);
                transform: translateY(-2px);
            }
            .cart-badge {
                position: absolute;
                top: -8px;
                right: -10px;
                background: var(--danger);
                font-size: 10px;
                padding: 2px 6px;
                border-radius: 50%;
                font-weight: 800;
                border: 2px solid var(--bg-dark);
            }

            /* --- PRODUCT GRID --- */
            .container {
                max-width: 1240px;
                margin: 60px auto;
                padding: 0 20px;
            }
            .section-title {
                text-align: center;
                margin-bottom: 50px;
            }
            .section-title h2 {
                font-size: 2rem;
                font-weight: 800;
                letter-spacing: -1px;
            }
            .underline {
                width: 60px;
                height: 4px;
                background: var(--primary-blue);
                margin: 12px auto;
                border-radius: 2px;
            }

            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
                gap: 35px;
            }

            .product-card {
                background: white;
                border-radius: 24px;
                padding: 16px;
                transition: var(--transition);
                position: relative;
                border: 1px solid #f1f5f9;
            }
            .product-card:hover {
                transform: translateY(-12px);
                box-shadow: 0 25px 50px -12px rgba(0,0,0,0.08);
                border-color: var(--primary-blue);
            }

            .img-box {
                width: 100%;
                height: 300px;
                border-radius: 18px;
                overflow: hidden;
                background: #f1f5f9;
                margin-bottom: 20px;
            }
            .img-box img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: 0.5s;
            }
            .product-card:hover img {
                transform: scale(1.08);
            }

            .price {
                color: var(--danger);
                font-size: 1.25rem;
                font-weight: 800;
                display: block;
                margin-bottom: 20px;
            }

            .btn-view {
                display: block;
                text-align: center;
                background: var(--bg-dark);
                color: white !important;
                text-decoration: none;
                padding: 12px;
                border-radius: 14px;
                font-weight: 700;
                font-size: 0.85rem;
                transition: 0.3s;
            }
            .btn-view:hover {
                background: var(--primary-blue);
                box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
            }

            /* RESPONSIVE */
            @media (max-width: 1024px) {
                .nav-menu {
                    display: none;
                }
                .mega-menu {
                    display: none;
                }
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

        <header class="header">
            <div class="logo">
                <a href="MainController">TH TRUE <span>FASHION</span></a>
            </div>

            <nav>
                <ul class="nav-menu">
                    <li class="nav-item">
                        <a href="#" class="nav-link">SẢN PHẨM <i class="fa-solid fa-chevron-down" style="font-size: 0.7rem;"></i></a>
                        <div class="mega-menu">
                            <div class="mega-col">
                                <h3>ÁO NAM</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Áo+Thun">Áo Thun</a></li>
                                    <li><a href="CategoryController?category=Áo+Sơ+Mi">Áo Sơ Mi</a></li>
                                    <li><a href="CategoryController?category=Áo+Polo">Áo Polo</a></li>
                                </ul>
                            </div>
                            <div class="mega-col">
                                <h3>QUẦN NAM</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Quần+Jean">Quần Jean</a></li>
                                    <li><a href="CategoryController?category=Quần+Short">Quần Short</a></li>
                                    <li><a href="CategoryController?category=Quần+Dài">Quần Dài</a></li>
                                </ul>
                            </div>
                            <div class="mega-col">
                                <h3>PHỤ KIỆN</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Giày+%26+Dép">Giày & Dép</a></li>
                                    <li><a href="CategoryController?category=Nón">Nón</a></li>
                                    <li><a href="CategoryController?category=Phụ+Kiện+(Ví,+Thắt+lưng...)">Phụ kiện (Ví, Thắt lưng)</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="NewArrivalController" class="nav-link">HÀNG MỚI <span class="badge-new">NEW</span></a>
                    </li>
                    <li class="nav-item">
                        <a href="BestSellerController" class="nav-link">BÁN CHẠY</a>
                    </li>
                </ul>
            </nav>

            <div class="header-actions">
                <form action="SearchController" method="GET" class="search-container">
                    <input type="text" name="query" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit"><i class="fa-solid fa-magnifying-glass"></i></button>
                </form>

                <a href="MainController?action=view-cart" class="action-icon" title="Giỏ hàng">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <span class="cart-badge">${sessionScope.CART != null ? sessionScope.CART.cart.size() : 0}</span>
                </a>

                <div class="user-info" style="display: flex; align-items: center; gap: 15px; padding-left: 15px; border-left: 1px solid rgba(255,255,255,0.1);">
                    <c:choose>
                        <c:when test="${not empty sessionScope.LOGIN_USER}">
                            <span style="color: white; font-size: 0.85rem;">Hi, <b>${sessionScope.LOGIN_USER.fullName}</b></span>

                            <a href="MainController?action=view-my-orders" class="action-icon" title="Lịch sử đơn hàng">
                                <i class="fa-solid fa-clock-rotate-left"></i>
                            </a>

                            <a href="MainController?action=logout" class="action-icon" style="color: var(--danger);" title="Đăng xuất">
                                <i class="fa-solid fa-power-off"></i>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" style="color: #4CAF50; text-decoration: none; font-weight: 800; border: 1px solid #4CAF50; padding: 8px 15px; border-radius: 8px; font-size: 0.8rem;">ĐĂNG NHẬP</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </header>

        <main class="container">
            <div class="section-title">
                <h2>SẢN PHẨM MỚI NHẤT</h2>
                <div class="underline"></div>
            </div>

            <div class="product-grid">
                <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                    <div class="product-card">
                        <div class="img-box">
                            <img src="images/${p.imageURL}" alt="${p.productName}">
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