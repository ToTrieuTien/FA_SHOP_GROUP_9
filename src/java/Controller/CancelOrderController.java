/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author TRIEUTIEN
 */
@WebServlet(name = "CancelOrderController", urlPatterns = {"/CancelOrderController"})
public class CancelOrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int orderID = Integer.parseInt(request.getParameter("orderID"));
            OrderDAO dao = new OrderDAO();
            boolean check = dao.cancelOrder(orderID);

            if (check) {
                request.setAttribute("SUCCESS_MSG", "Đã hủy đơn hàng thành công!");
            } else {
                request.setAttribute("ERROR_MSG", "Không thể hủy đơn hàng (Đơn đã được xử lý hoặc không tồn tại)!");
            }
        } catch (Exception e) {
            log("Error at CancelOrderController: " + e.toString());
        } finally {
            // Sau khi hủy xong, quay lại trang danh sách đơn hàng
            request.getRequestDispatcher("MainController?action=view-my-orders").forward(request, response);
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
