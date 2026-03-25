<%-- 
    Document   : success
    Created on : Mar 25, 2026, 10:09:24 PM
    Author     : TRIEUTIEN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Thanh toán thành công | TH Trueshop</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body style="text-align: center; padding: 100px 20px;">
        <div class="success-box">
            <h1 style="color: #000; letter-spacing: 2px;">TH TRUESHOP</h1>
            <hr style="width: 50px; border: 1px solid #000; margin: 20px auto;">
            <h2 style="font-weight: 300;">CẢM ƠN BẠN ĐÃ ĐẶT HÀNG!</h2>
            <p>${requestScope.SUCCESS_MSG}</p>
            <p style="color: #666; font-size: 14px;">Chúng tôi sẽ liên hệ với bạn sớm nhất để xác nhận đơn hàng.</p>
            <br>
            <a href="MainController?action=HomeController" 
               style="background: #000; color: #fff; padding: 12px 30px; text-decoration: none; display: inline-block; margin-top: 20px;">
                TIẾP TỤC MUA SẮM
            </a>
        </div>
    </body>
</html>
