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
        HttpSession session = request.getSession();

        try {
            // 1. Kiểm tra quyền truy cập (User phải đăng nhập mới được checkout)
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                response.sendRedirect("login.jsp");
                return; // Ngắt luồng xử lý
            }

            // 2. Kiểm tra giỏ hàng (Phải có hàng mới cho thanh toán)
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null || cart.getCart().isEmpty()) {
                response.sendRedirect("MainController?action=view-cart");
                return;
            }

            // 3. Thu thập dữ liệu từ Form gửi lên
            String phone = request.getParameter("phone");
            String address = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            String totalRaw = request.getParameter("totalMoney");
            double total = (totalRaw != null && !totalRaw.isEmpty()) ? Double.parseDouble(totalRaw) : 0;

            // 4. Validation (Kiểm tra dữ liệu đầu vào lần cuối)
            if (phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng cung cấp đầy đủ thông tin giao hàng!");

                // THÊM 2 DÒNG NÀY: Gửi ngược dữ liệu người dùng đã nhập về lại JSP
                request.setAttribute("SAVED_PHONE", phone);
                request.setAttribute("SAVED_ADDRESS", address);

                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // 5. Khởi tạo đối tượng Order để lưu vào Database
            OrderDTO order = new OrderDTO();
            order.setUserID(loginUser.getUserID());
            order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
            order.setTotalMoney(total);
            order.setShippingAddress(address);
            order.setPhone(phone);

            // Thiết lập trạng thái đơn hàng dựa trên phương thức thanh toán
            order.setStatus("QR".equals(paymentMethod) ? "Awaiting Payment" : "Processing");

            List<OrderDetailDTO> listDetail = new ArrayList<>();
            for (ProductDTO item : cart.getCart().values()) {
                // Kiểm tra xem variantID có bị bằng 0 không
                int vID = item.getVariantID();

                // Nếu vID = 0, tạm thời lấy ProductID để test (nếu DB của bạn cho phép) 
                // Hoặc tốt nhất là phải đảm bảo item này đã có VariantID từ lúc chọn Size/Color
                if (vID == 0) {
                    vID = item.getProductID(); // Chỉ dùng nếu bảng OrderDetails nhận ProductID
                }

                listDetail.add(new OrderDetailDTO(0, 0, vID, item.getQuantity(), item.getBasePrice()));
            }

            OrderDAO dao = new OrderDAO();
// Truyền danh sách đã xử lý vào DAO
            boolean isSuccess = dao.insertOrder(order, listDetail);

            if (isSuccess) {
                // Thanh toán thành công: Xóa giỏ hàng và chuyển hướng sang trang success
                session.removeAttribute("CART");
                session.setAttribute("SUCCESS_MSG", "Đơn hàng của bạn đã được ghi nhận!");
                response.sendRedirect("success.jsp");
            } else {
                // Lỗi Database (ví dụ: mất kết nối hoặc sai tên cột)
                request.setAttribute("ERROR", "Hệ thống gặp sự cố khi lưu đơn hàng. Vui lòng thử lại!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Ghi log lỗi để debug trong cửa sổ Output của NetBeans
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
