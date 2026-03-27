package Controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "MainController", urlPatterns = {"/MainController"})
public class MainController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");
        String url = "HomeController"; // Chuẩn của bạn

        try {
            String action = request.getParameter("action");

            if (action == null || action.isEmpty()) {
                url = "HomeController";
            } else {
                switch (action) {
                    case "login":
                        url = "LoginController";
                        break;
                    case "logout":
                        url = "LogoutController";
                        break;
                    case "view-product":
                        url = "ProductController";
                        break;
                    case "search":
                        url = "SearchController";
                        break;

                    case "search-admin-product":
                        url = "SearchAdminProductController";
                        break;
                    case "add-to-cart":
                        url = "CartController";
                        break;
                    case "view-cart":
                        url = "cart.jsp";
                        break;
                    case "remove-from-cart":
                        url = "CartController";
                        break;

                    // Thêm các tính năng của bạn kia vào đây
                    case "recycle-bin":
                        url = "RecycleBinController";
                        break;
                    case "restore-product":
                        url = "RestoreProductController";
                        break;
                    case "hard-delete-product":
                        url = "HardDeleteProductController";
                        break;
                    //Chuc nang thanh toan To Trieu Tien
                    case "checkout":
                        url = "CheckoutController";
                        break;
                    //Chuc nang cap nhat và xoa gio hang To Trieu Tien
                    case "update-cart":
                        url = "CartController";
                        break;
                    case "clear-cart":
                        url = "CartController";
                        break;
                    // Trả về trang success sau khi thanh toán thành công
                    case "success":
                        url = "success.jsp";
                        break;

                    // --- CÁC CHỨC NĂNG MỚI CỦA TEAMMATE (TÔ TRIỆU TIẾN) ---
                    // Theo dõi đơn hàng đã đặt
                    case "view-my-orders":
                        url = "OrderController";
                        break;
                    // Hủy đơn hàng
                    case "cancel-order":
                        url = "CancelOrderController";
                        break;
                    // Xác thực đã chuyển tiền qua QR (Dùng Controller của Tiến để xử lý Database)
                    case "confirm-payment":
                        url = "ConfirmPaymentController";
                        break;
                    // Xóa đơn hàng
                    case "delete-order":
                        url = "OrderController";
                        break;
                    default:
                        request.setAttribute("ERROR", "Hành động (Action) không được hỗ trợ!");
                        url = "error.jsp";
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at MainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
