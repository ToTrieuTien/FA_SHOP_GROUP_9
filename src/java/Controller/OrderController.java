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
            // Nhánh 1: Theo dõi đơn hàng (Action từ MainController)
            if ("view-my-orders".equals(action)) {
                OrderDAO dao = new OrderDAO();
                List<OrderDTO> list = dao.getOrdersByUserID(loginUser.getUserID());
                request.setAttribute("LIST_ORDERS", list);
                request.getRequestDispatcher("my-orders.jsp").forward(request, response);
                return;
            }

            // Nhánh 2: Xử lý hiển thị QR (Khi Checkout gọi sang hoặc từ cart)
            String paymentMethod = request.getParameter("paymentMethod");
            CartDTO cart = (CartDTO) session.getAttribute("CART");

            if (cart != null && "QR".equals(paymentMethod)) {
                double totalAmount = cart.getTotalPrice();
                String orderId = "DH" + System.currentTimeMillis();

                String bankId = "MB"; 
                String accountNo = "0000000007"; 
                String accountName = "TO TRIEU TIEN";

                String qrUrl = String.format("https://img.vietqr.io/image/%s-%s-compact.png?amount=%.0f&addInfo=%s&accountName=%s",
                        bankId, accountNo, totalAmount, "Thanh toan " + orderId, accountName);

                request.setAttribute("QR_URL", qrUrl);
                request.setAttribute("TOTAL", totalAmount);
                request.setAttribute("ORDER_ID", orderId);
                request.getRequestDispatcher("displayQR.jsp").forward(request, response);
            }
        } catch (Exception e) {
            log("Error at OrderController: " + e.toString());
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