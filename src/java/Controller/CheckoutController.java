package Controller;

import DAO.OrderDAO;
import DTO.CartDTO;
import DTO.OrderDTO;
import DTO.OrderDetailDTO;
import DTO.ProductDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8"); 
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

            // 3. Lấy thông tin từ Form
            String phone = request.getParameter("phone");
            String address = request.getParameter("shippingAddress");
            String paymentMethod = request.getParameter("paymentMethod");
            double total = cart.getTotalPrice();

            // 4. Validation
            if (phone == null || phone.trim().isEmpty() || address == null || address.trim().isEmpty()) {
                request.setAttribute("ERROR", "Vui lòng cung cấp đầy đủ thông tin giao hàng!");
                request.setAttribute("SAVED_PHONE", phone);
                request.setAttribute("SAVED_ADDRESS", address);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
                return;
            }

            // 5. Khởi tạo OrderDTO
            OrderDTO order = new OrderDTO();
            order.setUserID(loginUser.getUserID());
            order.setOrderDate(new java.sql.Timestamp(System.currentTimeMillis()));
            order.setTotalMoney(total);
            order.setShippingAddress(address);
            order.setPhone(phone);
            order.setStatus("QR".equals(paymentMethod) ? "Awaiting Payment" : "Processing");

            // 6. CHUYỂN ĐỔI SANG CHI TIẾT ĐƠN HÀNG (ĐÃ FIX VARIANTID)
            List<OrderDetailDTO> listDetail = new ArrayList<>();
            for (ProductDTO item : cart.getCart().values()) {
                OrderDetailDTO detail = new OrderDetailDTO();
                
                // Lấy VariantID từ item giỏ hàng
                // Nếu item chưa có VariantID, ta lấy tạm ProductID (với điều kiện DB đã có Variant tương ứng)
                int vID = (item.getVariantID() != 0) ? item.getVariantID() : item.getProductID();

                detail.setVariantID(vID); // SỬA: Dùng setVariantID thay cho setProductID
                detail.setProductName(item.getProductName()); // Lưu tên để hiện chi tiết sau này
                detail.setQuantity(item.getQuantity());
                detail.setPrice(item.getBasePrice());
                listDetail.add(detail);
            }

            // 7. Gọi DAO lưu vào Database
            OrderDAO dao = new OrderDAO();
            boolean isSuccess = dao.insertOrder(order, listDetail); // Hàm này giờ sẽ dùng VariantID để lưu

            if (isSuccess) {
                if ("QR".equals(paymentMethod)) {
                    // --- LUỒNG THANH TOÁN QR ---
                    String bankId = "tpbank";
                    String accountNo = "0366449758";
                    String accountName = "TH TrueShop";
                    String description = "THANH TOAN DON HANG " + loginUser.getUserID();

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
                request.setAttribute("ERROR", "Lỗi hệ thống: Không thể lưu đơn hàng!");
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }
}