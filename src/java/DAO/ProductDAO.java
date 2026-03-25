package DAO;

import DTO.ProductDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<ProductDTO> getAllProducts() {
        List<ProductDTO> list = new ArrayList<>();
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
                        rs.getBoolean("Status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean insertNewProduct(String name, double price, int categoryID, String fileName) {
        boolean check = false;
        String sqlProduct = "INSERT INTO Products (ProductName, Description, BasePrice, CategoryID, Status) "
                + "VALUES (?, ?, ?, ?, 1)";
        String sqlImage = "INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) "
                + "VALUES (?, ?, 1)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement psProduct = con.prepareStatement(sqlProduct, Statement.RETURN_GENERATED_KEYS)) {

            psProduct.setNString(1, name);
            psProduct.setNString(2, "Mô tả tự động");
            psProduct.setDouble(3, price);
            psProduct.setInt(4, categoryID);

            if (psProduct.executeUpdate() > 0) {
                ResultSet rsKeys = psProduct.getGeneratedKeys();
                if (rsKeys.next()) {
                    int newProductID = rsKeys.getInt(1);
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

    public ProductDTO getProductByID(String productID) {
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.BasePrice, p.CategoryID, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE p.ProductID = ? AND (i.IsPrimary = 1 OR i.ImageURL IS NULL)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(productID));
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
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
        return null;
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

            if (psProduct.executeUpdate() > 0) {
                check = true;
                if (fileName != null && !fileName.isEmpty()) {
                    String sqlImage = "UPDATE ProductImages SET ImageURL=? WHERE ProductID=?";
                    try ( PreparedStatement psImage = con.prepareStatement(sqlImage)) {
                        psImage.setString(1, fileName);
                        psImage.setInt(2, id);
                        if (psImage.executeUpdate() == 0) {
                            String sqlInsertImg = "INSERT INTO ProductImages (ProductID, ImageURL, IsPrimary) VALUES (?, ?, 1)";
                            try ( PreparedStatement psInsert = con.prepareStatement(sqlInsertImg)) {
                                psInsert.setInt(1, id);
                                psInsert.setString(2, fileName);
                                psInsert.executeUpdate();
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // --- CÁC HÀM BẠN KIA MỚI THÊM VÀO ---
    public boolean deleteProduct(String productID) {
        boolean check = false;
        String sql = "UPDATE Products SET Status = 0 WHERE ProductID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(productID));
            if (ps.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public boolean hardDeleteProduct(String productID) {
        boolean check = false;
        String sqlDeleteImages = "DELETE FROM ProductImages WHERE ProductID = ?";
        String sqlDeleteProduct = "DELETE FROM Products WHERE ProductID = ?";

        try ( Connection con = DBUtils.getConnection()) {
            con.setAutoCommit(false);
            try ( PreparedStatement psImg = con.prepareStatement(sqlDeleteImages);  PreparedStatement psProd = con.prepareStatement(sqlDeleteProduct)) {

                int id = Integer.parseInt(productID);
                psImg.setInt(1, id);
                psImg.executeUpdate();

                psProd.setInt(1, id);
                if (psProd.executeUpdate() > 0) {
                    con.commit();
                    check = true;
                }
            } catch (Exception ex) {
                con.rollback();
                ex.printStackTrace();
            } finally {
                con.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public List<ProductDTO> getDeletedProducts() {
        List<ProductDTO> list = new ArrayList<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.BasePrice, p.CategoryID, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE p.Status = 0 AND (i.IsPrimary = 1 OR i.ImageURL IS NULL)";

        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                list.add(new ProductDTO(
                        rs.getInt("ProductID"),
                        rs.getNString("ProductName"),
                        rs.getNString("Description"),
                        rs.getDouble("BasePrice"),
                        rs.getInt("CategoryID"),
                        rs.getString("ImageURL"),
                        rs.getBoolean("Status")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean restoreProduct(String productID) {
        boolean check = false;
        String sql = "UPDATE Products SET Status = 1 WHERE ProductID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(productID));
            if (ps.executeUpdate() > 0) {
                check = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    public List<ProductDTO> searchProducts(String keyword) {
        List<ProductDTO> list = new ArrayList<>();
        // Giữ nguyên câu lệnh SQL y hệt hàm getAllProducts, chỉ thêm AND p.ProductName LIKE ?
        String sql = "SELECT p.ProductID, p.ProductName, p.Description, p.BasePrice, p.CategoryID, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE (i.IsPrimary = 1 OR i.ImageURL IS NULL) AND p.ProductName LIKE ?";

        try ( Connection con = Utils.DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            // Truyền từ khóa tìm kiếm tiếng Việt vào
            ps.setNString(1, "%" + keyword + "%"); 

            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Mapping y hệt như hàm getAllProducts của em
                    list.add(new ProductDTO(
                            rs.getInt("ProductID"),
                            rs.getNString("ProductName"),
                            rs.getNString("Description"),
                            rs.getDouble("BasePrice"),
                            rs.getInt("CategoryID"),
                            rs.getString("ImageURL"),
                            rs.getBoolean("Status")
                    ));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
