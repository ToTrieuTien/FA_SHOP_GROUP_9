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

@WebServlet(name = "SearchController", urlPatterns = {"/SearchController"})
public class SearchController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Set Encoding để nhận đúng tiếng Việt có dấu (Ví dụ: "Áo Thun")
        response.setContentType("text/html;charset=UTF-8");
        request.setCharacterEncoding("UTF-8");

        try {
            // 1. Lấy từ khóa người dùng gõ vào thanh search hoặc bấm từ Mega Menu
            String keyword = request.getParameter("query");

            if (keyword == null) {
                keyword = "";
            }

            // 2. Gọi DAO để tìm kiếm
            ProductDAO dao = new ProductDAO();

            // QUAN TRỌNG: Gọi hàm searchActiveProducts (Chỉ lấy sản phẩm Status = 1)
            List<ProductDTO> list = dao.searchActiveProducts(keyword);

            // 3. Đẩy danh sách kết quả lên request để trang JSP bắt được
            request.setAttribute("LIST_PRODUCT", list);

            // Giữ lại từ khóa để nếu muốn thì in ra câu "Kết quả tìm kiếm cho: ..."
            request.setAttribute("SEARCH_KEYWORD", keyword);

            // 4. Chuyển hướng về lại trang chủ để in ra lưới sản phẩm
            request.getRequestDispatcher("home.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error at SearchController: " + e.toString());
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
        return "Controller xử lý tìm kiếm sản phẩm cho Khách hàng";
    }
}
