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
import java.net.URLEncoder;
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
        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận tiếng Việt từ Form
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

            // 3. Thu thập dữ liệu
            String phone = request.getParameter("phone");
            String address = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            String totalRaw = request.getParameter("totalMoney");
            double total = (totalRaw != null && !totalRaw.isEmpty()) ? Double.parseDouble(totalRaw) : 0;

            // 4. Validation
            if (phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng cung cấp đầy đủ thông tin giao hàng!");
                request.setAttribute("SAVED_PHONE", phone);
                request.setAttribute("SAVED_ADDRESS", address);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // 5. Khởi tạo Order
            OrderDTO order = new OrderDTO();
            order.setUserID(loginUser.getUserID());
            order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
            order.setTotalMoney(total);
            order.setShippingAddress(address);
            order.setPhone(phone);
            
            // Set trạng thái ban đầu
            order.setStatus("QR".equals(paymentMethod) ? "Awaiting Payment" : "Processing");

            // 6. Xử lý danh sách chi tiết đơn hàng
            List<OrderDetailDTO> listDetail = new ArrayList<>();
            for (ProductDTO item : cart.getCart().values()) {
                int vID = item.getVariantID() != 0 ? item.getVariantID() : item.getProductID();
                listDetail.add(new OrderDetailDTO(0, 0, vID, item.getQuantity(), item.getBasePrice()));
            }

            // 7. Lưu vào Database
            OrderDAO dao = new OrderDAO();
            boolean isSuccess = dao.insertOrder(order, listDetail);

            if (isSuccess) {
                // Xử lý sau khi lưu thành công
                if ("QR".equals(paymentMethod)) {
                    // --- LUỒNG THANH TOÁN QR ---
                    String bankId = "tpbank"; 
                    String accountNo = "0366449758"; 
                    String accountName = "TH TrueShop";
                    String description = "THANH TOAN DON HANG " + loginUser.getFullName();

                    // Sử dụng URLEncoder để tránh lỗi tiếng Việt và khoảng trắng trong URL
                    String encodedDesc = URLEncoder.encode(description, "UTF-8");
                    String encodedName = URLEncoder.encode(accountName, "UTF-8");

                    String qrUrl = String.format("https://img.vietqr.io/image/%s-%s-compact.png?amount=%.0f&addInfo=%s&accountName=%s",
                            bankId, accountNo, total, encodedDesc, encodedName);

                    request.setAttribute("QR_LINK", qrUrl);
                    request.setAttribute("TOTAL", total);
                    request.setAttribute("ORDER_DESC", description);

                    session.removeAttribute("CART");
                    request.getRequestDispatcher("qr-payment.jsp").forward(request, response);
                } else {
                    // --- LUỒNG THANH TOÁN COD ---
                    session.removeAttribute("CART");
                    session.setAttribute("SUCCESS_MSG", "Đơn hàng của bạn đã được ghi nhận thành công!");
                    response.sendRedirect("success.jsp");
                }
            } else {
                request.setAttribute("ERROR", "Hệ thống gặp sự cố khi lưu đơn hàng. Vui lòng thử lại!");
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
