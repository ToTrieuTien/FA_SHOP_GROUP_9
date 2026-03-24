package Controller;

import DAO.ProductDAO;
import DTO.ProductDTO;
import DTO.UserDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
            
            // Lấy giỏ hàng hiện tại
            List<ProductDTO> cart = (List<ProductDTO>) session.getAttribute("CART");
            if (cart == null) {
                cart = new ArrayList<>();
            }

            // Xử lý THÊM vào giỏ
            if ("add-to-cart".equals(action)) {
                String productID = request.getParameter("productID");
                if (productID != null) {
                    ProductDAO dao = new ProductDAO();
                    ProductDTO product = dao.getProductByID(productID);
                    if (product != null) {
                        cart.add(product); 
                        // Kích hoạt thông báo Toast thành công
                        session.setAttribute("SUCCESS_MSG", "Đã thêm [" + product.getProductName() + "] vào giỏ hàng!");
                    }
                }
                session.setAttribute("CART", cart);
                // Đá về trang chủ
                response.sendRedirect("MainController"); 
                return; 
            } 
            // Xử lý XÓA khỏi giỏ
            else if ("remove-from-cart".equals(action)) {
                String removeID = request.getParameter("id");
                if (removeID != null) {
                    int idToRemove = Integer.parseInt(removeID);
                    for (int i = 0; i < cart.size(); i++) {
                        if (cart.get(i).getProductID() == idToRemove) {
                            cart.remove(i); 
                            break; 
                        }
                    }
                }
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