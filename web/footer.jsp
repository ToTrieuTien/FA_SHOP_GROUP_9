<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .footer {
        background: var(--bg-dark);
        color: #94a3b8;
        padding: 70px 4% 30px;
        margin-top: 50px;
        font-family: 'Plus Jakarta Sans', sans-serif;
        border-top: 1px solid rgba(255,255,255,0.05);
    }
    .footer-container {
        display: grid;
        grid-template-columns: 1.5fr 1fr 1fr 1.2fr;
        gap: 40px;
        max-width: 1300px;
        margin: 0 auto;
    }
    .footer-logo a {
        color: var(--primary-blue);
        font-size: 1.6rem;
        font-weight: 800;
        text-decoration: none;
        display: block;
        margin-bottom: 20px;
    }
    .footer-logo span {
        color: var(--text-white);
    }
    .footer-column h4 {
        color: var(--text-white);
        font-size: 1.1rem;
        font-weight: 700;
        margin-bottom: 25px;
        position: relative;
    }
    .footer-column h4::after {
        content: '';
        position: absolute;
        left: 0;
        bottom: -8px;
        width: 30px;
        height: 2px;
        background: var(--primary-blue);
    }
    .footer-links {
        list-style: none;
        padding: 0;
    }
    .footer-links li {
        margin-bottom: 12px;
    }
    .footer-links a {
        color: #94a3b8;
        text-decoration: none;
        transition: 0.3s;
        font-size: 0.9rem;
    }
    .footer-links a:hover {
        color: var(--primary-blue);
        padding-left: 5px;
    }
    .contact-info li {
        display: flex;
        gap: 12px;
        margin-bottom: 15px;
        font-size: 0.9rem;
    }
    .contact-info i {
        color: var(--primary-blue);
        margin-top: 3px;
    }
    .social-links {
        display: flex;
        gap: 15px;
        margin-top: 20px;
    }
    .social-icon {
        width: 40px;
        height: 40px;
        background: rgba(255,255,255,0.05);
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 10px;
        color: var(--text-white);
        text-decoration: none;
        transition: 0.3s;
    }
    .social-icon:hover {
        background: var(--primary-blue);
        transform: translateY(-5px);
    }
    .footer-bottom {
        text-align: center;
        padding-top: 40px;
        margin-top: 50px;
        border-top: 1px solid rgba(255,255,255,0.05);
        font-size: 0.85rem;
    }
    .payment-methods {
        margin-bottom: 15px;
        font-size: 1.5rem;
        display: flex;
        justify-content: center;
        gap: 20px;
        color: rgba(255,255,255,0.2);
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <div class="footer-column">
            <div class="footer-logo">
                <a href="#">TH TRUE <span>FASHION</span></a>
            </div>
            <p style="line-height: 1.6; font-size: 0.9rem;">
                Tự hào là thương hiệu thời trang dẫn đầu xu hướng cho giới trẻ. 
                Chúng tôi mang đến sự tự tin và phong cách riêng biệt qua từng sản phẩm.
            </p>
            <div class="social-links">
                <a href="#" class="social-icon"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-tiktok"></i></a>
                <a href="#" class="social-icon"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>

        <div class="footer-column">
            <h4>DANH MỤC</h4>
            <ul class="footer-links">
                <li><a href="#">Áo Nam</a></li>
                <li><a href="#">Quần Nam</a></li>
                <li><a href="#">Phụ Kiện</a></li>
                <li><a href="#">Hàng Mới Về</a></li>
                <li><a href="#">Bộ Sưu Tập</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h4>HỖ TRỢ</h4>
            <ul class="footer-links">
                <li><a href="#">Kiểm tra đơn hàng</a></li>
                <li><a href="#">Chính sách đổi trả</a></li>
                <li><a href="#">Chính sách bảo mật</a></li>
                <li><a href="#">Hướng dẫn chọn size</a></li>
                <li><a href="#">Câu hỏi thường gặp</a></li>
            </ul>
        </div>

        <div class="footer-column">
            <h4>LIÊN HỆ</h4>
            <ul class="contact-info" style="list-style: none; padding:0;">
                <li>
                    <i class="fa-solid fa-location-dot"></i>
                    <span>Lô E2a-7, Đường D1, Đ. D1, Long Thạnh Mỹ, Thành Phố Thủ Đức, Hồ Chí Minh</span>
                </li>
                <li>
                    <i class="fa-solid fa-phone"></i>
                    <span>0123 456 789</span>
                </li>
                <li>
                    <i class="fa-solid fa-envelope"></i>
                    <span>support@thtruefashion.com</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="footer-bottom">
        <div class="payment-methods">
            <i class="fa-brands fa-cc-visa"></i>
            <i class="fa-brands fa-cc-mastercard"></i>
            <i class="fa-brands fa-cc-apple-pay"></i>
            <i class="fa-solid fa-wallet"></i>
        </div>
        <p>&copy; 2026 TH TRUE FASHION SHOP. Tất cả quyền được bảo lưu.</p>
    </div>
</footer>