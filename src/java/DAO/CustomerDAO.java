package DAO;

import DTO.CustomerDTO;
import DTO.OrderDTO;
import Utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerDAO {

    // 1. Lấy danh sách khách hàng + Thống kê chi tiêu (Khách hàng có RoleID = 2)
    public List<CustomerDTO> getAllCustomers() {
        List<CustomerDTO> list = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status, "
                + "COUNT(o.OrderID) AS TotalOrders, COALESCE(SUM(o.TotalMoney), 0) AS TotalSpent "
                + "FROM Users u LEFT JOIN Orders o ON u.UserID = o.UserID AND o.Status != 'Cancelled' "
                + "WHERE u.RoleID = 2 "
                + "GROUP BY u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status "
                + "ORDER BY TotalSpent DESC"; // Xếp VIP lên đầu
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                CustomerDTO c = new CustomerDTO();
                c.setUserID(rs.getString("UserID"));
                c.setFullName(rs.getNString("FullName"));
                c.setEmail(rs.getString("Email"));
                c.setPhone(rs.getString("Phone"));
                c.setAddress(rs.getNString("Address"));
                c.setStatus(rs.getBoolean("Status"));
                c.setTotalOrders(rs.getInt("TotalOrders"));
                c.setTotalSpent(rs.getDouble("TotalSpent"));
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 2. Tìm kiếm khách hàng (Tên, Email, SĐT)
    public List<CustomerDTO> searchCustomers(String keyword) {
        List<CustomerDTO> list = new ArrayList<>();
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status, "
                + "COUNT(o.OrderID) AS TotalOrders, COALESCE(SUM(o.TotalMoney), 0) AS TotalSpent "
                + "FROM Users u LEFT JOIN Orders o ON u.UserID = o.UserID AND o.Status != 'Cancelled' "
                + "WHERE u.RoleID = 2 AND (u.FullName LIKE ? OR u.Email LIKE ? OR u.Phone LIKE ?) "
                + "GROUP BY u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            String search = "%" + keyword + "%";
            ps.setNString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CustomerDTO c = new CustomerDTO();
                    c.setUserID(rs.getString("UserID"));
                    c.setFullName(rs.getNString("FullName"));
                    c.setEmail(rs.getString("Email"));
                    c.setPhone(rs.getString("Phone"));
                    c.setAddress(rs.getNString("Address"));
                    c.setStatus(rs.getBoolean("Status"));
                    c.setTotalOrders(rs.getInt("TotalOrders"));
                    c.setTotalSpent(rs.getDouble("TotalSpent"));
                    list.add(c);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Lấy Lịch sử mua hàng của 1 khách hàng cụ thể
    public List<OrderDTO> getCustomerOrders(String userID) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT OrderID, OrderDate, TotalMoney, Status FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        try ( Connection conn = DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userID);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDTO o = new OrderDTO();
                    o.setOrderID(rs.getInt("OrderID"));
                    o.setOrderDate(rs.getTimestamp("OrderDate"));
                    o.setTotalMoney(rs.getDouble("TotalMoney"));
                    o.setStatus(rs.getString("Status"));
                    list.add(o);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 4. Lấy thông tin chi tiết của 1 khách hàng cụ thể
    public CustomerDTO getCustomerById(String userID) {
        String sql = "SELECT u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status, "
                + "COUNT(o.OrderID) AS TotalOrders, COALESCE(SUM(o.TotalMoney), 0) AS TotalSpent "
                + "FROM Users u LEFT JOIN Orders o ON u.UserID = o.UserID AND o.Status != 'Cancelled' "
                + "WHERE u.UserID = ? "
                + "GROUP BY u.UserID, u.FullName, u.Email, u.Phone, u.Address, u.Status";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, userID);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CustomerDTO c = new CustomerDTO();
                    c.setUserID(rs.getString("UserID"));
                    c.setFullName(rs.getNString("FullName"));
                    c.setEmail(rs.getString("Email"));
                    c.setPhone(rs.getString("Phone"));
                    c.setAddress(rs.getNString("Address"));
                    c.setStatus(rs.getBoolean("Status"));
                    c.setTotalOrders(rs.getInt("TotalOrders"));
                    c.setTotalSpent(rs.getDouble("TotalSpent"));
                    return c;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
