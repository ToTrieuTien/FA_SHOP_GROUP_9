/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author FPT
 */
@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       String url = "login.jsp";
    
    try {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // --- BẮT ĐẦU VALIDATION ---
        boolean isError = false;

        if (!Utils.MyValidation.isValidEmail(email)) {
            request.setAttribute("ERROR", "Định dạng Email không hợp lệ!");
            isError = true;
        } else if (!Utils.MyValidation.isValidPassword(password)) {
            request.setAttribute("ERROR", "Mật khẩu không được để trống!");
            isError = true;
        }

        // Nếu có lỗi thì quay xe về login.jsp ngay
        if (isError) {
            request.getRequestDispatcher(url).forward(request, response);
            return;
        }
        // --- KẾT THÚC VALIDATION ---

        DAO.UserDAO dao = new DAO.UserDAO();
        DTO.UserDTO user = dao.checkLogin(email, password);

       if (user != null) {
        // 1. Lưu thông tin người dùng vào Session
        HttpSession session = request.getSession();
        session.setAttribute("LOGIN_USER", user);

        // 2. Phân quyền (RoleID 1 = Admin, 2 = Customer)
        if (user.getRoleID() == 1) {
            url = "admin/dashboard.jsp"; // Đường dẫn đến trang của nhóm Admin
        } else {
            url = "MainController?action=view-product"; // Về trang chủ cho khách hàng
        }
    } else {
        // 3. Báo lỗi nếu sai tài khoản
        request.setAttribute("ERROR", "Email hoặc mật khẩu không đúng!");
    }
        
    } catch (Exception e) {
        log("Error at LoginController: " + e.toString());
    } finally {
        request.getRequestDispatcher(url).forward(request, response);
    }
}

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
