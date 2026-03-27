package Controller;

import DAO.OrderDAO;
import DTO.CartDTO;
import DTO.OrderDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "OrderController", urlPatterns = {"/OrderController"})
public class OrderController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    request.setCharacterEncoding("UTF-8");

    String action = request.getParameter("action");
    HttpSession session = request.getSession();
    UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");

    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    try {
        OrderDAO dao = new OrderDAO();

        // --- NHÁNH 1: XÓA ĐƠN HÀNG ---
        if ("delete-order".equals(action)) {
            String orderIDStr = request.getParameter("orderID");
            if (orderIDStr != null) {
                int orderID = Integer.parseInt(orderIDStr);
                // Gọi hàm xóa trong DAO (Xóa cả OrderDetail và Order)
                boolean check = dao.deleteOrder(orderID); 

                if (check) {
                    session.setAttribute("SUCCESS_MSG", "Đã xóa đơn hàng #" + orderID + " thành công!");
                } else {
                    session.setAttribute("ERROR_MSG", "Không thể xóa đơn hàng! Vui lòng kiểm tra lại database.");
                }
            }
            // BẮT BUỘC: Redirect để trình duyệt load lại danh sách mới và tránh lỗi F5
            response.sendRedirect("MainController?action=view-my-orders");
            return; 
        } 

        // --- NHÁNH 2: XEM LỊCH SỬ ĐƠN HÀNG ---
        else if ("view-my-orders".equals(action)) {
            List<OrderDTO> list = dao.getOrdersByUserID(loginUser.getUserID());
            request.setAttribute("LIST_ORDERS", list);
            request.getRequestDispatcher("my-orders.jsp").forward(request, response);
            return;
        }

        // --- NHÁNH 3: XỬ LÝ THANH TOÁN QR ---
        String paymentMethod = request.getParameter("paymentMethod");
        CartDTO cart = (CartDTO) session.getAttribute("CART");

        if (cart != null && "QR".equals(paymentMethod)) {
            double totalAmount = cart.getTotalPrice();
            String orderId = "DH" + System.currentTimeMillis();
            String qrUrl = String.format("https://img.vietqr.io/image/MB-0000000007-compact.png?amount=%.0f&addInfo=%s&accountName=TO TRIEU TIEN",
                    totalAmount, "Thanh toan " + orderId);

            request.setAttribute("QR_URL", qrUrl);
            request.setAttribute("TOTAL", totalAmount);
            request.setAttribute("ORDER_ID", orderId);
            request.getRequestDispatcher("displayQR.jsp").forward(request, response);
            return;
        }

    } catch (Exception e) {
        log("Error at OrderController: " + e.toString());
        response.sendRedirect("error.jsp"); // Đẩy về trang lỗi nếu có Exception
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
