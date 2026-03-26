/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminController;

import DAO.CustomerDAO;
import DTO.CustomerDTO;
import DTO.OrderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author FPT
 */
@WebServlet(name = "CustomerDetailController", urlPatterns = {"/CustomerDetailController"})
public class CustomerDetailController extends HttpServlet {

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
        try {
            // Lấy ID của khách hàng khi bấm nút Con mắt
            String id = request.getParameter("id"); 
            
            CustomerDAO dao = new CustomerDAO();
            
            // Gọi 2 hàm DAO để lấy Hồ sơ và Lịch sử đơn hàng
            CustomerDTO customerInfo = dao.getCustomerById(id);
            List<OrderDTO> customerOrders = dao.getCustomerOrders(id);
            
            // Đẩy sang trang JSP tôi đã viết sẵn cho em lúc nãy
            request.setAttribute("CUSTOMER_INFO", customerInfo);
            request.setAttribute("CUSTOMER_ORDERS", customerOrders);
            
        } catch (Exception e) {
            log("Lỗi tại CustomerDetailController: " + e.toString());
        } finally {
            request.getRequestDispatcher("admin/customer_detail.jsp").forward(request, response);
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
