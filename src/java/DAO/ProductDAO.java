/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.ProductDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author FPT
 */
public class ProductDAO {

    public List<ProductDTO> getAllProducts() {
        List<ProductDTO> list = new ArrayList<>();
        // Thêm p.Status vào câu SELECT và bỏ điều kiện WHERE p.Status = 1 để Admin thấy toàn bộ
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.BasePrice, p.CategoryID, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE (i.IsPrimary = 1 OR i.ImageURL IS NULL)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getNString("ProductName"),
                        rs.getNString("Description"),
                        rs.getDouble("BasePrice"),
                        rs.getInt("CategoryID"),
                        rs.getString("ImageURL"),
                        rs.getBoolean("Status") // Lấy thêm Status từ Database truyền vào DTO
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertNewProduct(String name, double price, int categoryID, String fileName) {
        boolean check = false;
        // Lệnh INSERT trả về khóa chính (ProductID) vừa được tạo ra
        String sqlProduct = "INSERT INTO Products (ProductName, Description, BasePrice, CategoryID, Status) "
                + "VALUES (?, ?, ?, ?, 1)";

        String sqlImage = "INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) "
                + "VALUES (?, ?, 1)";

        try ( Connection con = DBUtils.getConnection(); // Cờ RETURN_GENERATED_KEYS giúp mình lấy lại cái ProductID tự tăng
                  PreparedStatement psProduct = con.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS)) {

            // 1. Lưu thông tin Áo vào bảng Products
            psProduct.setNString(1, name);
            psProduct.setNString(2, "Mô tả tự động"); // Em có thể làm thêm form mô tả sau
            psProduct.setDouble(3, price);
            psProduct.setInt(4, categoryID);

            int affectedRows = psProduct.executeUpdate();

            if (affectedRows > 0) {
                // 2. Lấy ra ProductID vừa được cấp
                ResultSet rsKeys = psProduct.getGeneratedKeys();
                if (rsKeys.next()) {
                    int newProductID = rsKeys.getInt(1);

                    // 3. Lưu tên bức ảnh vào bảng ProductImages với cái ID vừa lấy
                    try ( PreparedStatement psImage = con.prepareStatement(sqlImage)) {
                        psImage.setInt(1, newProductID);
                        psImage.setString(2, fileName);
                        psImage.executeUpdate();
                        check = true;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // Hàm lấy thông tin 1 sản phẩm cụ thể dựa vào ID để đưa lên Form Edit
    public ProductDTO getProductByID(String productID) {
        // Câu lệnh SQL lọc đúng ID sản phẩm cần tìm
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.BasePrice, p.CategoryID, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE p.ProductID = ? AND (i.IsPrimary = 1 OR i.ImageURL IS NULL)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            // Ép kiểu String từ URL sang Int để truyền vào dấu chấm hỏi (?)
            ps.setInt(1, Integer.parseInt(productID));

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) { // Dùng if vì ID là duy nhất, chỉ có tối đa 1 kết quả
                    return new ProductDTO(
                            rs.getInt("ProductID"),
                            rs.getNString("ProductName"),
                            rs.getNString("Description"),
                            rs.getDouble("BasePrice"),
                            rs.getInt("CategoryID"),
                            rs.getString("ImageURL"),
                            rs.getBoolean("Status")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy sản phẩm
    }

    public boolean updateProduct(int id, String name, double price, int catID, boolean status, String fileName) {
        boolean check = false;
        String sqlProduct = "UPDATE Products SET ProductName=?, BasePrice=?, CategoryID=?, Status=? WHERE ProductID=?";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement psProduct = con.prepareStatement(sqlProduct)) {

            psProduct.setNString(1, name);
            psProduct.setDouble(2, price);
            psProduct.setInt(3, catID);
            psProduct.setBoolean(4, status);
            psProduct.setInt(5, id);

            int row = psProduct.executeUpdate();

            if (row > 0) {
                check = true; // Cập nhật chữ thành công

                // Nếu có file ảnh mới thì cập nhật bảng ProductImages
                if (fileName != null && !fileName.isEmpty()) {
                    String sqlImage = "UPDATE ProductImages SET ImageURL=? WHERE ProductID=?";
                    try ( PreparedStatement psImage = con.prepareStatement(sqlImage)) {
                        psImage.setString(1, fileName);
                        psImage.setInt(2, id);
                        int updatedRows = psImage.executeUpdate(); // Kiểm tra xem có dòng nào được update không

                        // THẦN CHÚ Ở ĐÂY: Nếu không có dòng nào được update (nghĩa là SP chưa có ảnh) -> Ta phải INSERT mới
                        if (updatedRows == 0) {
                            String sqlInsertImg = "INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) VALUES (?, ?, 1)";
                            try ( PreparedStatement psInsert = con.prepareStatement(sqlInsertImg)) {
                                psInsert.setInt(1, id);
                                psInsert.setString(2, fileName);
                                psInsert.executeUpdate();
                            }
                        }
                    }
                }catch (Exception e) {
            e.printStackTrace();
        }
                return check;
            }
        }
