package Controller;

import DAO.ProductDAO;
import DTO.ProductDTO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // Lấy ID sản phẩm từ URL
            String productID = request.getParameter("id");
            ProductDAO dao = new ProductDAO();
            
            // Dùng hàm getProductByID có sẵn trong DAO
            ProductDTO product = dao.getProductByID(productID); 
            
            if (product != null) {
                // Đẩy dữ liệu sang trang product.jsp
                request.setAttribute("PRODUCT_DETAIL", product);
                request.getRequestDispatcher("product.jsp").forward(request, response);
            } else {
                response.sendRedirect("MainController"); 
            }
        } catch (Exception e) {
            log("Error at ProductController: " + e.toString());
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