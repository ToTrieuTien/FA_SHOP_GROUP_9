<%-- 
    Document   : header
    Created on : Mar 25, 2026, 9:30:37 PM
    Author     : TRIEUTIEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <header class="main-header">
        <div class="header-container">
            <div class="brand">
                <a href="home">TH Trueshop</a>
            </div>

            <nav class="main-nav">
                <ul class="nav-list">
                    <li class="nav-item has-mega-menu">
                        <a href="#">SẢN PHẨM <span class="arrow">v</span></a>
                        <div class="mega-menu">
                            <div class="mega-column">
                                <h3 class="mega-title">ÁO NAM</h3>
                                <ul>
                                    <li><a href="search?category=ao-thun">Áo Thun</a></li>
                                    <li><a href="search?category=ao-so-mi">Áo Sơ Mi</a></li>
                                    <li><a href="search?category=ao-polo">Áo Polo</a></li>
                                </ul>
                            </div>
                            <div class="mega-column">
                                <h3 class="mega-title">QUẦN NAM</h3>
                                <ul>
                                    <li><a href="search?category=quan-jean">Quần Jean</a></li>
                                    <li><a href="search?category=quan-short">Quần Short</a></li>
                                    <li><a href="search?category=quan-kaki">Quần Kaki</a></li>
                                </ul>
                            </div>
                            <div class="mega-column">
                                <h3 class="mega-title">PHỤ KIỆN</h3>
                                <ul>
                                    <li><a href="search?category=giay-dep">Giày & Dép</a></li>
                                    <li><a href="search?category=non">Nón</a></li>
                                    <li><a href="search?category=balo-tui-vi">Balo, Túi & Ví</a></li>
                                </ul>
                            </div>
                        </div>
                    </li>

                    <li class="nav-item">
                        <a href="#">HÀNG MỚI <span class="badge-new-nav">NEW</span></a>
                    </li>

                    <li class="nav-item">
                        <a href="#">BÁN CHẠY</a>
                    </li>
                </ul>
            </nav>

            <div class="search-section">
                <form action="search" method="GET" class="search-form">
                    <input type="text" name="query" placeholder="Tìm kiếm sản phẩm...">
                    <button type="submit"><i class="fa fa-search"></i></button>
                </form>
            </div>

            <div class="user-actions">
                <div class="action-item">
                    <i class="fa fa-bell"></i>
                    <span class="label">Thông báo</span>
                </div>
                <a href="viewCart" class="action-item">
                    <i class="fa fa-shopping-cart"></i>
                    <span class="badge">0</span>
                    <span class="label">Giỏ hàng</span>
                </a>
                <div class="action-item user-profile">
                    <i class="fa fa-user"></i>
                    <span class="label">Tài khoản</span>
                    <div class="dropdown-content">
                        <a href="logout">Đăng xuất</a>
                    </div>
                </div>
            </div>
        </div>
    </header>
</html>