package AdminController;

import DAO.ProductDAO;
import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

// Annotation này BẮT BUỘC PHẢI CÓ để Servlet hiểu được file upload
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // Tối đa 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // Tổng request tối đa 50MB
@WebServlet(name = "AddProductController", urlPatterns = {"/AddProductController"})
public class AddProductController extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8"); // Sửa lỗi font tiếng Việt khi nhập tên áo

        try {
            // 1. Lấy dữ liệu chữ từ form
            String productName = request.getParameter("txtProductName");
            double price = Double.parseDouble(request.getParameter("txtPrice"));
            int categoryID = Integer.parseInt(request.getParameter("ddlCategory"));

            // 2. Lấy dữ liệu file ảnh từ form
            Part part = request.getPart("fileImage");
            String fileName = Paths.get(part.getSubmittedFileName()).getFileName().toString();

            // 3. Đường dẫn lưu file trên Server (Lưu thẳng vào thư mục images của project)
            String uploadPath = request.getServletContext().getRealPath("") + File.separator + "images";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir(); // Tự động tạo thư mục nếu chưa có

            // 4. Lưu bức ảnh thật vào Server
            part.write(uploadPath + File.separator + fileName);

            // 5. Gọi DAO để lưu chữ và tên file (fileName) vào SQL Server
            ProductDAO dao = new ProductDAO();
            boolean check = dao.insertNewProduct(productName, price, categoryID, fileName);

            if (check) {
                // Thêm thành công thì quay lại trang quản lý xem kết quả
                response.sendRedirect("AdminMainController?action=manage-product");
            } else {
                response.getWriter().println("Lỗi khi lưu vào Database!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Lỗi Upload: " + e.getMessage());
        }
    }
}