<%-- 
    Document   : manage_product
    Created on : Mar 24, 2026, 1:12:52 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>
<!DOCTYPE html>
<html>
    <head>
        <title>Quản lý Sản Phẩm - FA SHOP</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <div class="wrapper">
            <aside class="sidebar">
                <div class="sidebar-header">
                    <h2>TH True Fashion Shop</h2>
                    <p>Mã số: ${sessionScope.LOGIN_USER.userID}</p>
                </div>
                <ul class="sidebar-menu">
                    <li><a href="AdminMainController?action=dashboard"><i class="fas fa-th-large"></i> Dashboard</a></li>
                    <li class="active"><a href="AdminMainController?action=manage-product"><i class="fas fa-tshirt"></i> Quản lý Sản Phẩm</a></li>
                    <li><a href="AdminMainController?action=manage-category"><i class="fas fa-folder"></i> Quản lý Danh Mục</a></li>
                    <li><a href="AdminMainController?action=manage-order"><i class="fas fa-box"></i> Đơn Hàng</a></li>
                    <li><a href="AdminMainController?action=manage-customer"><i class="fas fa-users"></i> Khách Hàng</a></li>
                    <hr>
                    <li><a href="MainController?action=logout"><i class="fas fa-sign-out-alt"></i> Đăng Xuất</a></li>
                </ul>
            </aside>

            <main class="main-content">      
                <div class="page-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                    <h1>Quản lý Sản Phẩm</h1>
                    <div class="header-actions">
                        <a href="AdminMainController?action=recycle-bin" class="btn-danger" style="background-color: #ef4444; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none; font-weight: bold; font-size: 14px;">
                            <i class="fas fa-trash"></i> Thùng Rác
                        </a>
                        <a href="AdminMainController?action=add-product-page" class="btn-primary" style="background-color: #1f2937; color: white; padding: 10px 15px; border-radius: 5px; text-decoration: none; font-weight: bold; font-size: 14px; margin-left: 10px;">
                            <i class="fas fa-plus"></i> Thêm Sản Phẩm
                        </a>
                    </div>
                </div>

                <div class="data-board">
                    <div class="data-board-header">
                        <h3>Danh sách sản phẩm</h3>
                        <div class="search-box">
                            <form action="AdminMainController" method="POST">
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
                                    <td><fmt:formatNumber value="${p.basePrice}" type="number"/>đ</td>

                                    <td>${p.categoryName}</td>

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
                                        <a href="AdminMainController?action=edit-product&id=${p.productID}" 
                                           class="btn-edit" title="Sửa">
                                            <i class="fas fa-pen"></i>
                                        </a>

                                        <a href="AdminMainController?action=delete-product&id=${p.productID}" 
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
