package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LogoutController", urlPatterns = {"/LogoutController"})
public class LogoutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Lấy session hiện tại
            HttpSession session = request.getSession(false);
            if (session != null) {
                // Xóa sạch toàn bộ session
                session.invalidate();
            }
        } finally {
            // Đuổi về trang chủ (không cần truyền param, MainController sẽ tự đá sang Home)
            response.sendRedirect("MainController");
        }
    }

    // --- HAI HÀM NÀY CŨNG BẮT BUỘC PHẢI CÓ ---
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
}