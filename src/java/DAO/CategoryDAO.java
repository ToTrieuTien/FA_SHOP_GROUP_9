/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.CategoryDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author FPT
 */
public class CategoryDAO {

    // 1. Lấy danh sách kèm theo số lượng sản phẩm (Dùng LEFT JOIN)
    public List<CategoryDTO> getAllCategories() {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, c.CategoryName, c.Status, COUNT(p.ProductID) AS ProductCount "
                + "FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID "
                + "GROUP BY c.CategoryID, c.CategoryName, c.Status";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new CategoryDTO(rs.getInt("CategoryID"), rs.getNString("CategoryName"), rs.getBoolean("Status"), rs.getInt("ProductCount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Thêm danh mục mới
    public boolean insertCategory(String name) {
        String sql = "INSERT INTO Categories(CategoryName, Status) VALUES(?, 1)";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {

            // Dùng setNString để ép kiểu Unicode cho SQL Server
            ps.setNString(1, name);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Xóa mềm (Ẩn danh mục)
    public boolean deleteCategory(int id) {
        String sql = "UPDATE Categories SET Status = 0 WHERE CategoryID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy 1 danh mục theo ID để hiện lên form Sửa
    public CategoryDTO getCategoryByID(int id) {
        String sql = "SELECT CategoryID, CategoryName, Status FROM Categories WHERE CategoryID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new CategoryDTO(rs.getInt("CategoryID"), rs.getNString("CategoryName"), rs.getBoolean("Status"), 0);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật tên danh mục
    public boolean updateCategory(int id, String name) {
        String sql = "UPDATE Categories SET CategoryName = ? WHERE CategoryID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setNString(1, name);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 1. Lấy danh sách danh mục đã bị xóa mềm (Status = 0)
    public List<CategoryDTO> getDeletedCategories() {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, c.CategoryName, c.Status, COUNT(p.ProductID) AS ProductCount "
                + "FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID "
                + "WHERE c.Status = 0 " // Khác biệt ở đây: Chỉ lấy những thằng đã ẩn
                + "GROUP BY c.CategoryID, c.CategoryName, c.Status";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new CategoryDTO(rs.getInt("CategoryID"), rs.getNString("CategoryName"), rs.getBoolean("Status"), rs.getInt("ProductCount")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Khôi phục danh mục (Đổi Status = 1)
    public boolean restoreCategory(int id) {
        String sql = "UPDATE Categories SET Status = 1 WHERE CategoryID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 3. Xóa cứng (Bay màu vĩnh viễn khỏi Database)
    public boolean hardDeleteCategory(int id) {
        String sql = "DELETE FROM Categories WHERE CategoryID = ?";
        try ( Connection con = DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            // Nếu bị vướng khóa ngoại (do vẫn còn sản phẩm thuộc danh mục này), nó sẽ nhảy vào đây
            e.printStackTrace();
        }
        return false;
    }

    public List<CategoryDTO> searchCategories(String keyword) {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT c.CategoryID, c.CategoryName, c.Status, COUNT(p.ProductID) AS ProductCount "
                + "FROM Categories c LEFT JOIN Products p ON c.CategoryID = p.CategoryID "
                + "WHERE c.CategoryName LIKE ? "
                + "GROUP BY c.CategoryID, c.CategoryName, c.Status";
        try ( Connection con = Utils.DBUtils.getConnection();  PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setNString(1, "%" + keyword + "%");
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(new CategoryDTO(rs.getInt("CategoryID"), rs.getNString("CategoryName"), rs.getBoolean("Status"), rs.getInt("ProductCount")));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
