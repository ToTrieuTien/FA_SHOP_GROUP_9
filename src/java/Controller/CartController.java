package Controller;

import DAO.OrderDAO;
import DAO.ProductDAO;
import DTO.CartDTO;
import DTO.ProductDTO;
import DTO.UserDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            HttpSession session = request.getSession();
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");

            // Bảo mật: Yêu cầu đăng nhập
            if (loginUser == null) {
                session.setAttribute("LOGIN_ERROR", "Vui lòng đăng nhập để tiếp tục!");
                response.sendRedirect("login.jsp");
                return;
            }

            String action = request.getParameter("action");
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO();
            }

            // 1. LƯU THÔNG TIN TẠM THỜI (AJAX)
            if ("save-temp".equals(action)) {
                session.setAttribute("TEMP_PHONE", request.getParameter("phone"));
                session.setAttribute("TEMP_ADDRESS", request.getParameter("address"));
                return;
            }

            // 2. THÊM VÀO GIỎ HÀNG HOẶC MUA NGAY
            if ("add-to-cart".equals(action) || "buy-now".equals(action)) {
                String productID = request.getParameter("productID");
                String variantID = request.getParameter("variantID");

                // Lấy số lượng và size từ giao diện người dùng nhập
                String quantityStr = request.getParameter("quantity");
                int quantity = (quantityStr != null && !quantityStr.isEmpty()) ? Integer.parseInt(quantityStr) : 1;

                if (productID != null) {
                    ProductDAO dao = new ProductDAO();
                    ProductDTO product = dao.getProductByID(productID);
                    if (product != null) {
                        product.setQuantity(quantity); // Set đúng số lượng người ta bấm dấu +
                        product.setVariantID(variantID != null ? Integer.parseInt(variantID) : 1);
                        cart.add(product);
                        session.setAttribute("CART", cart);
                    }
                }

                // NẾU LÀ MUA NGAY -> BAY THẲNG RA GIỎ HÀNG ĐỂ THANH TOÁN
                if ("buy-now".equals(action)) {
                    response.sendRedirect("MainController?action=view-cart");
                } // NẾU LÀ THÊM VÀO GIỎ -> Ở LẠI TRANG HIỆN TẠI & BÁO THÀNH CÔNG
                else {
                    // Tạo một câu thông báo lưu tạm vào Session
                    session.setAttribute("ADD_SUCCESS", "Đã thêm sản phẩm vào giỏ hàng thành công!");
                    // Chuyển hướng về lại đúng cái trang chi tiết của sản phẩm đó
                    response.sendRedirect("MainController?action=view-product&id=" + productID);
                }
                return;
            } // 3. XỬ LÝ XÁC NHẬN THANH TOÁN (LOGIC TRỌNG TÂM TIẾN CẦN)
            else if ("confirm-payment".equals(action)) {
                try {
                    String orderIDStr = request.getParameter("orderID");
                    if (orderIDStr != null) {
                        int orderID = Integer.parseInt(orderIDStr);
                        OrderDAO dao = new OrderDAO();

                        // SỬA TẠI ĐÂY: Đổi từ 'Shipping' sang 'Processing'
                        // Để hiển thị là "Đang kiểm tra giao dịch" trên giao diện
                        boolean check = dao.updateOrderStatus(orderID, "Processing");

                        if (check) {
                            session.setAttribute("SUCCESS_MSG", "Đang kiểm tra giao dịch của bạn. Vui lòng đợi Admin xác nhận!");
                        } else {
                            session.setAttribute("ERROR_MSG", "Cập nhật trạng thái thất bại!");
                        }
                    }
                } catch (Exception e) {
                    log("Error at confirm-payment: " + e.toString());
                }
                // Chuyển hướng về trang lịch sử đơn hàng để xem trạng thái mới
                response.sendRedirect("MainController?action=view-my-orders");
                return;
            } // 4. XÓA KHỎI GIỎ HÀNG
            else if ("remove-from-cart".equals(action)) {
                String removeID = request.getParameter("id");
                if (removeID != null) {
                    cart.remove(Integer.parseInt(removeID));
                }
                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
                return;
            } // 5. CẬP NHẬT GIỎ HÀNG
            else if ("update-cart".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                cart.update(id, quantity);
                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
                return;
            } // 6. XÓA SẠCH GIỎ HÀNG
            else if ("clear-cart".equals(action)) {
                cart.clear();
                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
                return;
            } else if ("delete-order".equals(action)) {
                try {
                    int orderID = Integer.parseInt(request.getParameter("orderID"));
                    OrderDAO dao = new OrderDAO();
                    boolean check = dao.deleteOrder(orderID);

                    if (check) {
                        session.setAttribute("SUCCESS_MSG", "Đã xóa đơn hàng khỏi lịch sử!");
                    } else {
                        session.setAttribute("ERROR_MSG", "Không thể xóa đơn hàng này!");
                    }
                } catch (Exception e) {
                    log("Error at delete-order: " + e.toString());
                }
                response.sendRedirect("MainController?action=view-my-orders");
                return;
            }

        } catch (Exception e) {
            log("Error at CartController: " + e.toString());
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
}
