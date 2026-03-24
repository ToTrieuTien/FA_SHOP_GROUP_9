<%-- 
    Document   : error
    Created on : Mar 24, 2026, 3:26:28 PM
    Author     : FPT
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi hệ thống</title>
        <link rel="stylesheet" type="text/css" href="css/style.css">
        <style>
            .error-container {
                text-align: center;
                margin-top: 100px;
                padding: 20px;
            }
            .error-code { font-size: 50px; color: #ff0000; }
            .error-message { font-size: 20px; color: #333; margin: 20px 0; }
            .back-home { text-decoration: none; color: #000; font-weight: bold; border: 1px solid #000; padding: 10px 20px; }
        </style>
    </head>
    <body>
        <div class="error-container">
            <div class="error-code">⚠️ Oops!</div>
            
            <div class="error-message">
                ${requestScope.ERROR != null ? requestScope.ERROR : "Đã có lỗi xảy ra ngoài ý muốn."}
            </div>

            <br><br>
            <a href="MainController" class="back-home">QUAY LẠI TRANG CHỦ</a>
        </div>
    </body>
</html>
