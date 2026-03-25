package Controller;

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
        try {
            HttpSession session = request.getSession();

            // --- CHỐT CHẶN BẢO MẬT: BẮT BUỘC ĐĂNG NHẬP MỚI ĐƯỢC DÙNG GIỎ HÀNG ---
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null) {
                // Lưu câu báo lỗi vào Session
                session.setAttribute("LOGIN_ERROR", "Bạn phải đăng nhập để thêm sản phẩm vào giỏ hàng!");
                // Đá về trang đăng nhập ngay lập tức
                response.sendRedirect("login.jsp");
                return;
            }

            String action = request.getParameter("action");

            // Thay vì dùng List, hãy dùng CartDTO để khớp với CheckoutController
            CartDTO cart = (CartDTO) session.getAttribute("CART");
            if (cart == null) {
                cart = new CartDTO();
            }

            if ("add-to-cart".equals(action)) {
                String productID = request.getParameter("productID");
                String variantID = request.getParameter("variantID");

                // Chỉ cần productID để bắt đầu xử lý
                if (productID != null && !productID.isEmpty()) {
                    ProductDAO dao = new ProductDAO();
                    ProductDTO product = dao.getProductByID(productID);

                    if (product != null) {
                        product.setQuantity(1);

                        // KIỂM TRA VARIANTID: Nếu null thì gán tạm giá trị mặc định (ví dụ: 1)
                        if (variantID != null && !variantID.isEmpty()) {
                            try {
                                product.setVariantID(Integer.parseInt(variantID));
                            } catch (NumberFormatException e) {
                                product.setVariantID(1); // Backup nếu parse lỗi
                            }
                        } else {
                            product.setVariantID(1); // Giá trị mặc định để không bị lỗi CSDL sau này
                        }

                        cart.add(product);
                        session.setAttribute("CART", cart);
                        session.setAttribute("SUCCESS_MSG", "Đã thêm vào giỏ hàng!");
                    }
                }
                // Đảm bảo lệnh redirect này nằm đúng luồng
                response.sendRedirect("MainController");
                return;
            } // Xử lý XÓA khỏi giỏ
            else if ("remove-from-cart".equals(action)) {
                String removeID = request.getParameter("id");
                if (removeID != null) {
                    try {
                        int idToRemove = Integer.parseInt(removeID);
                        cart.remove(idToRemove);
                    } catch (NumberFormatException e) {
                        log("Invalid ID: " + removeID);
                    }
                }
                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
                return;
                //Xử lý cập nhật
            } else if ("update-cart".equals(action)) {
                try {
                    int id = Integer.parseInt(request.getParameter("id"));
                    int quantity = Integer.parseInt(request.getParameter("quantity"));

                    cart.update(id, quantity);
                } catch (Exception e) {
                    log("Update error");
                }

                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
                return;
            } //Xử lý xóa hết giở hàng
            else if ("clear-cart".equals(action)) {
                cart.clear();
                session.setAttribute("CART", cart);
                response.sendRedirect("MainController?action=view-cart");
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
