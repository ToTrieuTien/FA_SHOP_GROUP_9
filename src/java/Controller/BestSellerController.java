package Controller;

import DAO.ProductDAO;
import DTO.ProductDTO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "BestSellerController", urlPatterns = {"/BestSellerController"})
public class BestSellerController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
try {
    ProductDAO dao = new ProductDAO();
    List<ProductDTO> list = dao.getBestSellers(12);

    // THÊM DÒNG NÀY:
    request.setAttribute("TITLE", "SẢN PHẨM BÁN CHẠY"); 

    request.setAttribute("LIST_PRODUCT", list);
    request.getRequestDispatcher("home.jsp").forward(request, response);
} catch (Exception e) {
    e.printStackTrace();
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
