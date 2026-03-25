/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.OrderDAO;
import DTO.CartDTO;
import DTO.OrderDTO;
import DTO.OrderDetailDTO;
import DTO.ProductDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
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
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

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
        String url = "MainController?action=view-cart"; // Mặc định quay lại giỏ hàng nếu lỗi

        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");

            // 1. Kiểm tra đăng nhập
            if (loginUser == null) {
                url = "login.jsp";
            } else {
                CartDTO cart = (CartDTO) session.getAttribute("CART");
                if (cart != null && !cart.getCart().isEmpty()) {

                    // 2. Lấy thông tin từ Form (Phone và Address)
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("shippingAddress");
                    double total = Double.parseDouble(request.getParameter("totalMoney"));

                    // 3. Đóng gói OrderDTO
                    OrderDTO order = new OrderDTO();
                    order.setUserID(loginUser.getUserID());
                    order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
                    order.setTotalMoney(total);
                    order.setShippingAddress(address);
                    order.setPhone(phone);
                    order.setStatus("Processing");

                    // 4. Chuyển giỏ hàng sang List<OrderDetailDTO>
                    List<OrderDetailDTO> listDetail = new ArrayList<>();
                    for (ProductDTO p : cart.getCart().values()) {
                        // Sửa p.getPrice() thành p.getBasePrice() cho khớp với DTO của bạn
                        listDetail.add(new OrderDetailDTO(0, 0, p.getProductID(), p.getQuantity(), p.getBasePrice()));
                    }
                    // 5. Gọi DAO thực hiện chèn dữ liệu
                    OrderDAO dao = new OrderDAO();
                    boolean check = dao.insertOrder(order, listDetail);

                    if (check) {
                        session.removeAttribute("CART"); // Xóa giỏ hàng sau khi mua thành công
                        request.setAttribute("SUCCESS_MSG", "Đơn hàng của bạn đã được tiếp nhận!");
                        url = "success.jsp";
                    }
                }
            }
        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
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
