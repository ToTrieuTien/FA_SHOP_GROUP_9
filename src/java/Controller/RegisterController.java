package Controller;

import DAO.UserDAO;
import DTO.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @author FPT
 */
@WebServlet(name = "RegisterController", urlPatterns = {"/RegisterController"})
public class RegisterController extends HttpServlet {

    private static final String ERROR = "register.jsp";
    private static final String SUCCESS = "login.jsp";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt khi nhập liệu
        String url = ERROR;
        try {
            // 1. Lấy dữ liệu từ form register.jsp
            String userID = request.getParameter("txtUserID");
            String fullName = request.getParameter("txtFullName");
            String password = request.getParameter("txtPassword");
            String confirm = request.getParameter("txtConfirm");
            String email = request.getParameter("txtEmail");
            String address = request.getParameter("txtAddress");
            String phone = request.getParameter("txtPhone");
            int roleID = 2; // Giả sử 2 là RoleID cho khách hàng (User)
            boolean status = true;

            boolean checkValidation = true;

            // 2. Kiểm tra logic cơ bản (Validation)
            if (password != null && !password.equals(confirm)) {
                request.setAttribute("ERROR", "Mật khẩu xác nhận không khớp!");
                checkValidation = false;
            }

            if (checkValidation) {
                // 3. Tạo đối tượng DTO để truyền xuống DAO
                // Lưu ý: Thứ tự tham số phải khớp với Constructor trong UserDTO của bạn
                UserDTO user = new UserDTO();
                user.setUserID(userID);
                user.setFullName(fullName);
                user.setRoleID(roleID);
                user.setPassword(password);
                user.setAddress(address);
                user.setPhone(phone);
                user.setEmail(email);
                user.setStatus(status);

                // 4. Gọi DAO để thực hiện Insert
                UserDAO dao = new UserDAO();
                boolean checkInsert = dao.insert(user);
                
                if (checkInsert) {
                    url = SUCCESS;
                    request.setAttribute("MESSAGE", "Đăng ký thành công! Vui lòng đăng nhập.");
                } else {
                    request.setAttribute("ERROR", "Đăng ký thất bại, vui lòng thử lại!");
                }
            }
        } catch (Exception e) {
            log("Error at RegisterController: " + e.toString());
            if (e.toString().contains("duplicate")) {
                request.setAttribute("ERROR", "Tên đăng nhập (UserID) đã tồn tại!");
            } else {
                request.setAttribute("ERROR", "Hệ thống đang gặp lỗi: " + e.getMessage());
            }
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
        return "Short description";
    }
}