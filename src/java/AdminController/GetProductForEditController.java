/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminController;

import DAO.ProductDAO;
import DTO.ProductDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author FPT
 */
@WebServlet(name = "GetProductForEditController", urlPatterns = {"/GetProductForEditController"})
public class GetProductForEditController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            // 1. Lấy ID sản phẩm từ request
            String productID = request.getParameter("id");

            // 2. Lấy thông tin chi tiết của sản phẩm (Dùng ProductDAO)
            ProductDAO dao = new ProductDAO();
            ProductDTO product = dao.getProductByID(productID);

            // 3. Lấy danh sách toàn bộ danh mục để đổ vào dropdown (Dùng CategoryDAO)
            DAO.CategoryDAO catDao = new DAO.CategoryDAO();

            // 4. Đẩy TẤT CẢ dữ liệu vào request (Quan trọng: Phải setAttribute trước khi forward)
            request.setAttribute("PRODUCT_INFO", product);
            request.setAttribute("LIST_CATEGORY", catDao.getAllCategories());

            // 5. CHỈ THỰC HIỆN chuyển hướng khi đã chuẩn bị xong đầy đủ dữ liệu
            request.getRequestDispatcher("admin/edit_product.jsp").forward(request, response);

        } catch (Exception e) {
            log("Error at GetProductForEditController: " + e.toString());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
