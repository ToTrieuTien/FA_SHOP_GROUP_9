<%-- 
    Document   : header
    Created on : Mar 25, 2026, 9:30:37 PM
    Author     : TRIEUTIEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        .main-header {
            border-bottom: 1px solid #eee;
            padding: 15px 0;
            font-family: 'Arial', sans-serif;
        }

        .header-container {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto;
        }

        .brand a {
            font-size: 24px;
            font-weight: bold;
            text-decoration: none;
            color: #000;
            text-transform: uppercase;
        }

        .search-form {
            display: flex;
            border: 1px solid #ddd;
            border-radius: 4px;
            overflow: hidden;
        }

        .search-form input {
            border: none;
            padding: 8px 15px;
            width: 300px;
            outline: none;
        }

        .user-actions {
            display: flex;
            gap: 20px;
        }

        .action-item {
            text-decoration: none;
            color: #333;
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 12px;
            position: relative;
        }

        .action-item i {
            font-size: 20px;
            margin-bottom: 4px;
        }
    </style>

    <header class="main-header">
        <div class="header-container">
            <div class="brand">
                <a href="home">TH Trueshop</a>
            </div>

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
