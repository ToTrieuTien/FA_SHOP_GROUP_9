/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author TRIEUTIEN
 */
public class ConfirmPaymentController extends HttpServlet {

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
        // 1. Lấy mã đơn hàng từ thẻ hidden input ở Bước 1
        String orderIDStr = request.getParameter("orderID");
        
        if (orderIDStr != null && !orderIDStr.isEmpty()) {
            int orderID = Integer.parseInt(orderIDStr);
            
            /* 2. LOGIC QUAN TRỌNG: 
               Cập nhật trạng thái đơn hàng thành "Chờ xác nhận" (Ví dụ: Status = '1')
               Thay vì tin khách ngay, ta để Admin vào đối soát ngân hàng sau.
            */
            OrderDAO dao = new OrderDAO();
            boolean isUpdated = dao.updateOrderStatus(orderID, "1"); // Bạn cần viết hàm này ở DAO
            
            if (isUpdated) {
                // 3. Xóa giỏ hàng sau khi đã chốt đơn thành công để khách mua tiếp đơn khác
                HttpSession session = request.getSession();
                session.removeAttribute("CART");
            }
        }
    } catch (Exception e) {
        log("Lỗi tại ConfirmPaymentController: " + e.toString());
    } finally {
        // 4. Luôn điều hướng sang trang thành công để báo khách "Hệ thống đang kiểm tra"
        // Dùng sendRedirect để tránh việc khách nhấn F5 làm gửi lại yêu cầu thanh toán
        response.sendRedirect("success.jsp");
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
