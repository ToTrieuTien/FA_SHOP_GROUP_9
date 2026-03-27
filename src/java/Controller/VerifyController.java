package Controller;

import DAO.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "VerifyController", urlPatterns = {"/VerifyController"})
public class VerifyController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String code = request.getParameter("code");
        if (code != null && !code.isEmpty()) {
            UserDAO dao = new UserDAO();
            boolean isVerified = dao.verifyAccount(code);
            
            if (isVerified) {
                request.setAttribute("MESSAGE", "Tài khoản của bạn đã được xác thực thành công. Vui lòng đăng nhập!");
            } else {
                request.setAttribute("ERROR", "Mã xác thực không hợp lệ hoặc tài khoản đã được xác thực trước đó.");
            }
        }
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}