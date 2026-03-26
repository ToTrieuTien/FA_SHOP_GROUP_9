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

@WebServlet(name = "NewArrivalController", urlPatterns = {"/NewArrivalController"})
public class NewArrivalController extends HttpServlet { // Đã sửa tên Class ở đây!

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            ProductDAO dao = new ProductDAO();
            // Lấy 12 sản phẩm mới nhất đưa lên đầu
            List<ProductDTO> list = dao.getNewArrivals(12);

            // Đẩy list này ra lại trang chủ
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
