package DAO;

import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DashboardDAO {

    // 1. Đếm tổng số đơn hàng
    public int getTotalOrders() {
        String sql = "SELECT COUNT(*) FROM Orders";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 2. Tính tổng doanh thu (Chỉ tính các đơn đã Completed)
    public double getTotalRevenue() {
        String sql = "SELECT SUM(TotalMoney) FROM Orders WHERE Status = 'Completed'";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 3. Đếm tổng số sản phẩm đang bán
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Products WHERE Status = 1";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 4. Đếm tổng số khách hàng (RoleID = 2)
    public int getTotalCustomers() {
        String sql = "SELECT COUNT(*) FROM Users WHERE RoleID = 2";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 5. Lấy 5 sản phẩm mới nhất (sắp xếp theo ProductID giảm dần)
    public List<DTO.ProductDTO> getRecentProducts() {
        List<DTO.ProductDTO> list = new ArrayList<>();
        String sql = "SELECT TOP 5 p.ProductID, p.ProductName, p.BasePrice, p.Status, i.ImageURL "
                + "FROM Products p LEFT JOIN ProductImages i ON p.ProductID = i.ProductID "
                + "WHERE (i.IsPrimary = 1 OR i.ImageURL IS NULL) "
                + "ORDER BY p.ProductID DESC";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                DTO.ProductDTO p = new DTO.ProductDTO();
                p.setProductID(rs.getInt("ProductID"));
                p.setProductName(rs.getNString("ProductName"));
                p.setBasePrice(rs.getDouble("BasePrice"));
                p.setStatus(rs.getBoolean("Status"));
                p.setImageURL(rs.getString("ImageURL"));
                list.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
