<%-- 
    Document   : manage_product
    Created on : Mar 24, 2026, 1:12:52 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <title>Quản lý Sản Phẩm - FA SHOP</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="wrapper">
        <nav class="sidebar">
            <div class="sidebar-header">
                <h2>ICONDENIM</h2>
                <p>Mã số: ${sessionScope.LOGIN_USER.userID}</p>
            </div>
            <ul class="sidebar-menu">
                <li><a href="MainController?action=dashboard">Dashboard Overview</a></li>
                <li class="active"><a href="MainController?action=manage-product">Quản lý Sản Phẩm</a></li>
                <li><a href="MainController?action=manage-category">Quản lý Danh Mục</a></li>
                <li><a href="MainController?action=manage-order">Đơn Hàng</a></li>
                <li><a href="MainController?action=manage-customer">Khách Hàng</a></li>
                <li><a href="MainController?action=logout">Đăng Xuất</a></li>
            </ul>
        </nav>

        <main class="main-content">
            <div class="page-header">
                <h1 class="dashboard-title">Quản lý Sản Phẩm</h1>
                <a href="MainController?action=add-product-page" class="btn-primary">+ Thêm Sản Phẩm Mới</a>
            </div>

            <div class="data-board">
                <div class="data-board-header">
                    <h3>Danh sách sản phẩm</h3>
                    <div class="search-box">
                        <form action="MainController" method="GET">
                            <input type="hidden" name="action" value="search-admin-product">
                            <input type="text" name="txtSearch" placeholder="Tìm kiếm sản phẩm...">
                        </form>
                    </div>
                </div>

                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#ID</th>
                            <th>HÌNH ẢNH</th>
                            <th>TÊN SẢN PHẨM</th>
                            <th>GIÁ (VNĐ)</th>
                            <th>DANH MỤC</th>
                            <th>TRẠNG THÁI</th>
                            <th>HÀNH ĐỘNG</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="p" items="${requestScope.LIST_PRODUCT}">
                            <tr>
                                <td>SP00${p.productID}</td>
                                
                                <td>
                                    <img src="${pageContext.request.contextPath}/images/${p.imageURL}" 
                                         class="table-img" 
                                         alt="${p.productName}">
                                </td>
                                
                                <td>${p.productName}</td>
                                <td>${p.basePrice}đ</td>
                                
                                <td>DM00${p.categoryID}</td> 
                                
                                <td>
                                    <c:choose>
                                        <c:when test="${p.status == true}">
                                            <span class="status in-stock">Còn hàng</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status out-of-stock">Hết hàng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <td class="action-cell">
                                    <a href="MainController?action=edit-product&id=${p.productID}" 
                                       class="btn-edit" title="Sửa">
                                        <i class="fas fa-pen"></i>
                                    </a>
                                    
                                    <a href="MainController?action=delete-product&id=${p.productID}" 
                                       class="btn-delete" title="Xóa" 
                                       onclick="return confirm('Xác nhận xóa sản phẩm: ${p.productName}?');">
                                        <i class="fas fa-trash"></i>
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </main>
    </div>
</body>
</html>
