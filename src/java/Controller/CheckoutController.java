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
        request.setCharacterEncoding("UTF-8"); // Đảm bảo tiếng Việt không bị lỗi font
        HttpSession session = request.getSession();

        try {
            // 1. Kiểm tra đăng nhập
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            // 2. Kiểm tra giỏ hàng
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null || cart.getCart().isEmpty()) {
                response.sendRedirect("MainController?action=view-cart");
                return;
            }

            // 3. Lấy thông tin giao hàng từ Form
            String phone = request.getParameter("phone");
            String address = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            String totalRaw = request.getParameter("totalMoney");
            double total = (totalRaw != null && !totalRaw.isEmpty()) ? Double.parseDouble(totalRaw) : 0;

            if (phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng cung cấp đầy đủ thông tin giao hàng!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // 4. Khởi tạo OrderDTO khớp với Database (TotalMoney, ShippingAddress)
            OrderDTO order = new OrderDTO();
            order.setUserID(loginUser.getUserID());
            order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
            order.setTotalMoney(total);
            order.setShippingAddress(address);
            order.setPhone(phone);
            order.setStatus("Pending"); // Trạng thái mặc định khi mới đặt hàng

            // 5. Chuyển đổi từ Cart sang List<OrderDetailDTO> (SỬA LỖI TẠI ĐÂY)
            List<OrderDetailDTO> listDetail = new ArrayList<>();
            for (ProductDTO item : cart.getCart().values()) {
                // Truyền đủ 6 tham số: ID, OrderID, ProductID, ProductName, Quantity, Price
                listDetail.add(new OrderDetailDTO(
                        0, // orderDetailID (DB tự tăng)
                        0, // orderID (DAO sẽ gán sau)
                        item.getProductID(), // productID
                        item.getProductName(), // productName
                        item.getQuantity(), // quantity
                        item.getBasePrice() // price (Đơn giá tại thời điểm mua)
                ));
            }

            // 6. Gọi DAO lưu vào Database
            OrderDAO dao = new OrderDAO();
            boolean isSuccess = dao.insertOrder(order, listDetail);

            if (isSuccess) {
                session.removeAttribute("CART"); // Xóa giỏ hàng sau khi đặt thành công
                response.sendRedirect("success.jsp");
            } else {
                request.setAttribute("ERROR", "Lỗi hệ thống: Không thể lưu đơn hàng!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
            response.sendRedirect("error.jsp");
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
