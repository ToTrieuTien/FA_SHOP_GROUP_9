<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">

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