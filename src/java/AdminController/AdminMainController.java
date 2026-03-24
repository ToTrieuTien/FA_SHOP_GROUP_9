/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package AdminController;

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
@WebServlet(name = "AdminMainController", urlPatterns = {"/AdminMainController"})
public class AdminMainController extends HttpServlet {

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
        String url = "admin/dashboard.jsp"; // Mặc định vào Dashboard

        try {
            String action = request.getParameter("action");

            if (action == null || action.isEmpty()) {
                url = "admin/dashboard.jsp";
            } else {
                switch (action) {
                    case "dashboard":
                        url = "admin/dashboard.jsp";
                        break;
                    case "manage-product":
                        url = "AdminProductController";
                        break;
                    case "add-product-page":
                        url = "admin/add_product.jsp";
                        break;
                    case "add-product":
                        url = "AddProductController";
                        break;
                    case "edit-product":
                        url = "GetProductForEditController";
                        break;
                    case "delete-product":
                        url = "DeleteProductController";
                        break;
                    case "recycle-bin":
                        url = "RecycleBinController";
                        break;
                    case "restore-product":
                        url = "RestoreProductController";
                        break;
                    case "hard-delete-product":
                        url = "HardDeleteProductController";
                        break;
                    case "logout": // Cho phép Admin đăng xuất từ trang quản lý
                        url = "LogoutController";
                        break;
                    default:
                        request.setAttribute("ERROR", "Hành động (Action) không được hỗ trợ trong Admin!");
                        url = "error.jsp"; // Hoặc em có thể tạo riêng 1 trang admin/error.jsp
                        break;
                }
            }
        } catch (Exception e) {
            log("Error at AdminMainController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
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
