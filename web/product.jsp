<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>${PRODUCT_DETAIL.productName} | TH TRUE FASHION</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <jsp:include page="header.jsp" />
        <style>
            /* ==========================================================================
       CHI TIẾT SẢN PHẨM (PRODUCT DETAIL CUSTOM)
       ========================================================================== */

            /* Bao ngoài toàn bộ nội dung */
            .product-wrapper {
                max-width: 1200px;
                margin: 40px auto;
                padding: 0 4%;
                min-height: 60vh;
            }

            /* Thanh điều hướng nhỏ */
            .breadcrumb {
                margin-bottom: 30px;
                font-size: 0.9rem;
                color: #64748b;
            }
            .breadcrumb a {
                color: var(--primary-blue);
                font-weight: 600;
                transition: 0.3s;
            }
            .breadcrumb a:hover {
                text-decoration: underline;
            }
            .breadcrumb span {
                color: #94a3b8;
            }

            /* Container chính chia 2 cột */
            .detail-container {
                display: grid;
                grid-template-columns: 1fr 1.2fr; /* Cột thông tin rộng hơn chút */
                gap: 60px;
                background: #ffffff;
                padding: 40px;
                border-radius: 24px;
                box-shadow: var(--shadow-lg);
                align-items: start;
            }

            /* Cột trái: Hình ảnh */
            .detail-image {
                width: 100%;
                border-radius: 18px;
                overflow: hidden;
                background: #f8fafc;
                border: 1px solid #f1f5f9;
            }
            .detail-image img {
                width: 100%;
                height: auto;
                display: block;
                transition: 0.5s ease;
            }
            .detail-image img:hover {
                transform: scale(1.05);
            }

            /* Cột phải: Thông tin */
            .detail-info h1 {
                font-size: 2.2rem;
                font-weight: 800;
                color: var(--bg-dark);
                margin-bottom: 15px;
                line-height: 1.2;
            }

            .detail-price {
                font-size: 1.8rem;
                color: var(--danger);
                font-weight: 800;
                margin-bottom: 25px;
            }

            .detail-divider {
                border: none;
                border-top: 1px solid #e2e8f0;
                margin: 25px 0;
            }

            .detail-description {
                font-size: 1rem;
                color: #475569;
                line-height: 1.8;
                margin-bottom: 25px;
            }
            .detail-description strong {
                color: var(--bg-dark);
                display: block;
                margin-bottom: 8px;
                font-size: 1.1rem;
            }

            /* Badge trạng thái */
            .status {
                padding: 5px 15px;
                border-radius: 50px;
                font-size: 0.85rem;
                font-weight: 700;
                text-transform: uppercase;
                display: inline-block;
                margin-left: 10px;
            }
            .in-stock {
                background: #dcfce7;
                color: #16a34a;
            }
            .out-of-stock {
                background: #fee2e2;
                color: #ef4444;
            }

            /* Nút Thêm vào giỏ hàng lớn */
            .btn-add-cart-large {
                width: 100%;
                margin-top: 30px;
                background: var(--bg-dark);
                color: white !important;
                border: none;
                padding: 18px;
                border-radius: 16px;
                font-size: 1.1rem;
                font-weight: 800;
                cursor: pointer;
                transition: 0.3s;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 12px;
            }

            .btn-add-cart-large:hover {
                background: var(--primary-blue);
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(79, 172, 254, 0.3);
            }

            .btn-add-cart-large i {
                font-size: 1.3rem;
            }

            /* Responsive */
            @media (max-width: 992px) {
                .detail-container {
                    grid-template-columns: 1fr;
                    gap: 30px;
                    padding: 25px;
                }
            }
        </style>
        <div class="product-wrapper">
            <div class="breadcrumb">
                <a href="MainController">Trang chủ</a> / <span>Chi tiết sản phẩm</span>
            </div>

            <div class="detail-container">
                <div class="detail-image">
                    <img src="images/${PRODUCT_DETAIL.imageURL}" alt="${PRODUCT_DETAIL.productName}">
                </div>

                <div class="detail-info">
                    <h1>${PRODUCT_DETAIL.productName}</h1>
                    <div class="detail-price">
                        <fmt:formatNumber value="${PRODUCT_DETAIL.basePrice}" pattern="#,###"/> VNĐ
                    </div>

                    <hr class="detail-divider">

                    <div class="detail-description">
                        <strong>Mô tả:</strong> ${PRODUCT_DETAIL.description}
                    </div>

                    <p><strong>Tình trạng:</strong> 
                        <c:choose>
                            <c:when test="${PRODUCT_DETAIL.status == true}">
                                <span class="status in-stock">Còn hàng</span>
                            </c:when>
                            <c:otherwise>
                                <span class="status out-of-stock">Tạm hết hàng</span>
                            </c:otherwise>
                        </c:choose>
                    </p>

                    <form action="MainController" method="POST">
                        <input type="hidden" name="action" value="add-to-cart">
                        <input type="hidden" name="productID" value="${PRODUCT_DETAIL.productID}">

                        <c:if test="${PRODUCT_DETAIL.status == true}">
                            <button type="submit" class="btn-add-cart-large">
                                <i class="fa-solid fa-cart-plus"></i> &nbsp; THÊM VÀO GIỎ HÀNG
                            </button>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>
</html>