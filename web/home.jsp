<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Trang chủ - TH TRUE FASHION SHOP</title>
        <link rel="stylesheet" href="css/style.css">
        <style>
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 40px 20px;
            }
            .product-grid {
                display: grid;
                grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
                gap: 30px;
            }
            .product-item {
                background: #fff;
                padding: 15px;
                text-align: center;
                transition: 0.3s;
                border: 1px solid #f0f0f0;
                border-radius: 8px;
            }
            .product-item:hover {
                box-shadow: 0 5px 15px rgba(0,0,0,0.1);
                transform: translateY(-5px);
            }
            .product-item img {
                max-width: 100%;
                height: 250px;
                object-fit: cover;
                margin-bottom: 15px;
                border-radius: 4px;
            }
            .product-item h3 {
                font-size: 16px;
                margin: 10px 0;
                color: #333;
                height: 40px;
            }
            .product-item p {
                font-weight: bold;
                color: #ff4d4d;
                font-size: 18px;
            }

            .btn-view {
                display: inline-block;
                margin-top: 10px;
                padding: 12px 0;
                width: 85%;
                background: #1a233a;
                color: #fff;
                text-decoration: none;
                font-size: 14px;
                font-weight: bold;
                border-radius: 4px;
                transition: 0.3s;
                white-space: nowrap;
            }
            .btn-view:hover {
                background: #4CAF50;
            }

            /* --- CSS MEGA MENU --- */
            .main-nav {
                flex: 1;
                display: flex;
                justify-content: center;
            }
            .nav-list {
                list-style: none;
                padding: 0;
                margin: 0;
                display: flex;
                align-items: center;
                gap: 35px;
            }

            .nav-item {
                position: relative;
                padding: 30px 0;
            }

            .nav-item > a {
                color: #ffffff;
                text-decoration: none;
                font-size: 15px;
                font-weight: 700;
                text-transform: uppercase;
                display: flex;
                align-items: center;
                transition: 0.2s;
            }
            .nav-item > a:hover {
                color: #f1c40f;
            }
            .arrow {
                font-size: 12px;
                margin-left: 5px;
                transform: scaleX(1.3);
            }
            .badge-new-nav {
                background-color: #ff4d4f;
                color: white;
                font-size: 10px;
                padding: 2px 6px;
                border-radius: 3px;
                margin-left: 6px;
                font-weight: bold;
                transform: translateY(-6px);
            }

            .mega-menu {
                display: none;
                position: absolute;
                top: 100%;
                left: 0;
                transform: translateX(-15%);
                background-color: #ffffff;
                width: 600px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.1);
                border: 1px solid #f0f0f0;
                border-top: 3px solid #ff4d4f;
                padding: 30px;
                border-radius: 0 0 8px 8px;
                z-index: 1000;
            }

            .mega-menu::before {
                content: "";
                position: absolute;
                top: -30px;
                left: 0;
                width: 100%;
                height: 30px;
                background: transparent;
            }

            .nav-item.has-mega-menu:hover .mega-menu {
                display: flex;
                justify-content: space-between;
            }
            .mega-column {
                flex: 1;
                border-right: 1px solid #f5f5f5;
                padding-right: 20px;
            }
            .mega-column:last-child {
                border-right: none;
                padding-right: 0;
            }
            .mega-title {
                color: #1a233a;
                font-size: 15px;
                font-weight: 800;
                margin: 0 0 15px;
                padding-bottom: 10px;
                border-bottom: 2px solid #f0f0f0;
                text-align: left;
            }
            .mega-column ul {
                list-style: none;
                padding: 0;
                margin: 0;
                text-align: left;
            }
            .mega-column li {
                margin-bottom: 12px;
            }
            .mega-column a {
                color: #666;
                font-size: 14px;
                text-decoration: none;
                transition: 0.2s;
                display: block;
            }
            .mega-column a:hover {
                color: #1a233a;
                font-weight: bold;
                transform: translateX(5px);
            }
        </style>
    </head>
    <body style="background-color: #f9f9f9; margin: 0;">

        <c:if test="${not empty sessionScope.SUCCESS_MSG}">
            <div id="toastMessage" style="position: fixed; top: 80px; right: 20px; background-color: #4CAF50; color: white; padding: 15px 25px; border-radius: 4px; box-shadow: 0 4px 12px rgba(0,0,0,0.15); z-index: 9999; font-size: 16px; font-weight: bold; transition: opacity 0.5s;">
                ✅ ${sessionScope.SUCCESS_MSG}
            </div>
            <c:remove var="SUCCESS_MSG" scope="session" />
            <script>
                setTimeout(function () {
                    var toast = document.getElementById("toastMessage");
                    if (toast) {
                        toast.style.opacity = "0";
                        setTimeout(function () {
                            toast.style.display = "none";
                        }, 500);
                    }
                }, 3000);
            </script>
        </c:if>

        <div class="user-header" style="background: #1a233a; color: white; padding: 0 50px; min-height: 80px; display: flex; align-items: center; justify-content: space-between; box-shadow: 0 2px 10px rgba(0,0,0,0.2); position: relative; z-index: 900;">

            <div style="font-size: 24px; font-weight: bold; letter-spacing: 1px; white-space: nowrap;">
                <a href="MainController" style="color: white; text-decoration: none;">TH TRUE FASHION SHOP</a>
            </div>

            <nav class="main-nav">
                <ul class="nav-list">
                    <li class="nav-item has-mega-menu">
                        <a href="#">SẢN PHẨM <span class="arrow">v</span></a>
                        <div class="mega-menu">
                            <div class="mega-column">
                                <h3 class="mega-title">ÁO NAM</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Áo+Thun">Áo Thun</a></li>
                                    <li><a href="CategoryController?category=Áo+Sơ+Mi">Áo Sơ Mi</a></li>
                                    <li><a href="CategoryController?category=Áo+Polo">Áo Polo</a></li>
                                </ul>
                            </div>
                            <div class="mega-column">
                                <h3 class="mega-title">QUẦN NAM</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Quần+Jean">Quần Jean</a></li>
                                    <li><a href="CategoryController?category=Quần+Short">Quần Short</a></li>
                                    <li><a href="CategoryController?category=Quần+Dài">Quần Dài</a></li>
                                </ul>
                            </div>
                            <div class="mega-column">
                                <h3 class="mega-title">PHỤ KIỆN</h3>
                                <ul>
                                    <li><a href="CategoryController?category=Giày+%26+Dép">Giày & Dép</a></li>
                                    <li><a href="CategoryController?category=Nón">Nón</a></li>
                                    <li><a href="CategoryController?category=Phụ+Kiện+(Ví,+Thắt+lưng...)">Phụ kiện (Ví, Thắt lưng)</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>
                    <li class="nav-item">
                        <a href="NewArrivalController">HÀNG MỚI <span class="badge-new-nav">NEW</span></a>
                    </li>
                    <li class="nav-item">
                        <a href="BestSellerController">BÁN CHẠY</a>
                    </li>
                </ul>
            </nav>

            <div style="display: flex; align-items: center; gap: 30px; white-space: nowrap;">
                <div class="search-bar">
                    <form action="SearchController" method="GET" style="display: flex; align-items: center; background: #ffffff; border-radius: 25px; padding: 6px 15px; width: 260px; box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);">
                        <input type="text" name="query" placeholder="Tìm kiếm sản phẩm..." style="border: none; outline: none; flex: 1; padding: 4px 0; font-size: 14px; color: #333; background: transparent;">
                        <button type="submit" style="border: none; background: transparent; cursor: pointer; color: #1a233a; font-size: 16px; padding: 0;">
                            🔍
                        </button>
                    </form>
                </div>

                <div style="display: flex; align-items: center;">
                    <c:choose>
                        <c:when test="${not empty sessionScope.LOGIN_USER}">
                            <span style="margin-right: 20px; font-size: 15px;">Xin chào, <b>${sessionScope.LOGIN_USER.fullName}</b>!</span>
                            <a href="MainController?action=view-cart" style="color: #4CAF50; text-decoration: none; margin-right: 20px; font-weight: bold; font-size: 15px;">
                                🛒 Giỏ hàng (<c:out value="${sessionScope.CART != null ? sessionScope.CART.cart.size() : 0}"/>)
                            </a>
                            <a href="MainController?action=logout" style="color: #ff4d4d; text-decoration: none; font-weight: bold; font-size: 15px;">Đăng xuất</a>
                        </c:when>
                        <c:otherwise>
                            <a href="login.jsp" style="color: #4CAF50; text-decoration: none; font-weight: bold; font-size: 15px; border: 1px solid #4CAF50; padding: 8px 16px; border-radius: 4px;">Đăng nhập</a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>

        <div class="container">
            <h2 style="text-align: center; margin-bottom: 40px; letter-spacing: 2px; font-size: 28px;">
                ${not empty requestScope.TITLE ? requestScope.TITLE : "SẢN PHẨM MỚI NHẤT"}
            </h2>
            
            <div class="product-grid">
                <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                    <div class="product-item">
                        <img src="images/${p.imageURL}" alt="${p.productName}">
                        <h3>${p.productName}</h3>
                        <p><fmt:formatNumber value="${p.basePrice}" pattern="#,###"/> VNĐ</p>
                        <a href="MainController?action=view-product&id=${p.productID}" class="btn-view">XEM CHI TIẾT</a>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>