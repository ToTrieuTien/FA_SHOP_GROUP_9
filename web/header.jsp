<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    :root {
        --bg-dark: #0a0e17;
        --primary-blue: #4facfe;
        --text-white: #f8fafc;
        --danger: #ef4444;
        --shadow-lg: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
    }

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
        font-family: 'Plus Jakarta Sans', sans-serif;
    }

    .logo a {
        color: var(--primary-blue);
        font-size: 1.5rem;
        font-weight: 800;
        text-decoration: none;
    }
    .logo span {
        color: var(--text-white);
    }

    .nav-menu {
        display: flex;
        list-style: none;
        gap: 30px;
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
        color: var(--text-white);
        text-decoration: none;
        font-weight: 700;
        font-size: 0.9rem;
        text-transform: uppercase;
        transition: 0.3s;
        display: flex;
        align-items: center;
        gap: 6px;
    }
    .nav-link:hover {
        color: var(--primary-blue);
    }

    .mega-menu {
        visibility: hidden;
        opacity: 0;
        position: absolute;
        top: 90%;
        left: 50%;
        transform: translateX(-50%) translateY(20px);
        background: white;
        width: 650px;
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 25px;
        padding: 30px;
        border-radius: 16px;
        box-shadow: 0 20px 50px rgba(0,0,0,0.15);
        transition: 0.3s;
        border: 1px solid #e2e8f0;
    }
    .nav-item::after {
        content: "";
        position: absolute;
        bottom: -20px;
        left: 0;
        width: 100%;
        height: 25px;
    }
    .nav-item:hover .mega-menu {
        visibility: visible;
        opacity: 1;
        transform: translateX(-50%) translateY(0);
    }

    .mega-col h3 {
        color: var(--bg-dark);
        font-size: 0.95rem;
        font-weight: 800;
        margin-bottom: 15px;
        padding-bottom: 8px;
        border-bottom: 2px solid #f1f5f9;
    }
    .mega-col ul {
        list-style: none;
        padding: 0;
    }
    .mega-col li {
        margin-bottom: 10px;
    }
    .mega-col a {
        color: #64748b;
        text-decoration: none;
        font-size: 0.85rem;
        font-weight: 600;
        transition: 0.2s;
        display: block;
    }
    .mega-col a:hover {
        color: var(--primary-blue);
        transform: translateX(5px);
    }
    .badge-new {
        background: var(--danger);
        color: white;
        font-size: 9px;
        padding: 2px 6px;
        border-radius: 4px;
        margin-left: 5px;
    }

    .search-container {
        background: rgba(255, 255, 255, 0.1);
        border-radius: 50px;
        padding: 8px 18px;
        display: flex;
        align-items: center;
        width: 280px;
        transition: 0.4s;
        border: 1px solid rgba(255, 255, 255, 0.1);
    }
    .search-container:focus-within {
        background: var(--text-white);
        width: 320px;
    }
    .search-container input {
        background: transparent;
        border: none;
        outline: none;
        color: var(--text-white);
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

    .header-actions {
        display: flex;
        align-items: center;
        gap: 18px;
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
        padding: 2px 7px;
        border-radius: 50px;
        font-weight: 800;
        border: 2px solid var(--bg-dark);
    }
</style>

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