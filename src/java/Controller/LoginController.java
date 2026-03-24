package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        try {
            // Lấy dữ liệu và cắt khoảng trắng 2 đầu
            String loginID = request.getParameter("loginID");
            if (loginID != null) {
                loginID = loginID.trim();
            }
            String password = request.getParameter("password");

            boolean isError = false;

            // Chỉ cần đảm bảo người dùng không bỏ trống ô nhập
            if (loginID == null || loginID.isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng nhập Email hoặc Tên đăng nhập!");
                isError = true;
            } else if (!Utils.MyValidation.isValidPassword(password)) {
                request.setAttribute("ERROR", "Mật khẩu không được để trống!");
                isError = true;
            }

            // Nếu có lỗi, dùng forward để giữ lại trang login và hiện chữ màu đỏ
            if (isError) {
                request.getRequestDispatcher("login.jsp").forward(request, response);
                return; // Thoát hàm ngay lập tức
            }

            // Tiến hành check DB
            DAO.UserDAO dao = new DAO.UserDAO();
            DTO.UserDTO user = dao.checkLogin(loginID, password);

            if (user != null) {
                // Đăng nhập thành công -> Lưu session
                HttpSession session = request.getSession();
                session.setAttribute("LOGIN_USER", user);

                // Phân quyền
                if (user.getRoleID() == 1) {
                    // Của bạn kia: Chuyển thẳng về Controller Admin mới tạo
                    response.sendRedirect("AdminMainController?action=dashboard");
                } else {
                    // Của bạn: Khách hàng -> Chuyển thẳng tới Trang chủ
                    response.sendRedirect("MainController"); 
                }
                return; // Chặn luồng chạy tiếp
            } else {
                // Đăng nhập thất bại -> Trả về login.jsp kèm báo lỗi
                request.setAttribute("ERROR", "Email/Tên đăng nhập hoặc mật khẩu không đúng!");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            log("Error at LoginController: " + e.toString());
            request.setAttribute("ERROR", "Hệ thống đang gặp lỗi!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

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

    @Override
    public String getServletInfo() {
        return "Login Controller";
    }
}