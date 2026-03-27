package Utils;

import java.io.InputStream;
import java.util.Properties;
import java.util.Scanner;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletContext; 

public class EmailUtils {

    // Truyền thêm ServletContext vào để đọc file từ thư mục Web Pages
    private static String readEmailTemplate(ServletContext context) {
        String content = "";
        try {
            // Đọc file verify-email.html nằm ở gốc thư mục Web Pages
            InputStream is = context.getResourceAsStream("/verify-email.html");
            if (is != null) {
                Scanner scanner = new Scanner(is, "UTF-8").useDelimiter("\\A");
                content = scanner.hasNext() ? scanner.next() : "";
                scanner.close();
            } else {
                System.out.println("LỖI: Không tìm thấy file verify-email.html");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return content;
    }

    // Thêm tham số ServletContext context
    public static void sendVerificationEmail(String toEmail, String code, ServletContext context) throws Exception {
        
        final String fromEmail = "giahuypham1234@gmail.com"; 
        
        // ĐÃ SỬA: Xóa tất cả các khoảng trắng trong mật khẩu ứng dụng
        final String password = "jdve uarr txcm hipo"; 

        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        MimeMessage message = new MimeMessage(session);
        message.setFrom(new InternetAddress(fromEmail));
        message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
        message.setSubject("Xác thực tài khoản TH TRUE FASHION SHOP", "UTF-8");

        // ĐÃ SỬA: Cập nhật đường dẫn xác thực bằng link ngrok tĩnh của bạn
        String verifyLink = "https://devorah-unreckoned-jerica.ngrok-free.dev/PRJ301_FashionShop/VerifyController?code=" + code;
        
        // Đọc HTML từ file riêng biệt
        String htmlContent = readEmailTemplate(context);
        
        // Thay thế link xác thực
        if (!htmlContent.isEmpty()) {
             htmlContent = htmlContent.replace("{{VERIFY_LINK}}", verifyLink);
        } else {
             htmlContent = "<h2>Vui lòng click vào link để xác thực:</h2><a href='" + verifyLink + "'>Xác thực ngay</a>";
        }

        message.setContent(htmlContent, "text/html; charset=UTF-8");
        Transport.send(message); 
    }
}