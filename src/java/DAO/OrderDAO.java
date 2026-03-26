/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTO.OrderDTO;
import DTO.OrderDetailDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author FPT
 */
public class OrderDAO {

    // 1. Đặt hàng (Cho khách hàng - Transaction)
    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> listDetail) {
        boolean check = false;
        String sqlOrder = "INSERT INTO Orders(UserID, OrderDate, TotalMoney, ShippingAddress, Phone, Status) VALUES(?,?,?,?,?,?)";
        String sqlDetail = "INSERT INTO OrderDetails(OrderID, ProductID, Quantity, Price) VALUES(?,?,?,?)";

        try ( Connection conn = Utils.DBUtils.getConnection()) {
            if (conn != null) {
                conn.setAutoCommit(false); // Quản lý Transaction

                try ( PreparedStatement stmOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS)) {
                    stmOrder.setString(1, order.getUserID());
                    stmOrder.setTimestamp(2, order.getOrderDate());
                    stmOrder.setDouble(3, order.getTotalMoney()); // Khớp cột TotalMoney
                    stmOrder.setNString(4, order.getShippingAddress());
                    stmOrder.setString(5, order.getPhone());
                    stmOrder.setString(6, order.getStatus());

                    if (stmOrder.executeUpdate() > 0) {
                        ResultSet rs = stmOrder.getGeneratedKeys();
                        if (rs.next()) {
                            int orderID = rs.getInt(1);
                            try ( PreparedStatement stmDetail = conn.prepareStatement(sqlDetail)) {
                                for (OrderDetailDTO d : listDetail) {
                                    stmDetail.setInt(1, orderID);
                                    stmDetail.setInt(2, d.getProductID()); // Dùng ProductID thay vì VariantID
                                    stmDetail.setInt(3, d.getQuantity());
                                    stmDetail.setDouble(4, d.getPrice());
                                    stmDetail.addBatch();
                                }
                                stmDetail.executeBatch();
                                conn.commit(); // Thành công thì commit
                                check = true;
                            }
                        }
                    }
                } catch (Exception e) {
                    conn.rollback(); // Lỗi thì rollback ngay
                    e.printStackTrace();
                }
                conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

    // 2. Lấy danh sách đơn hàng cho Admin
    public List<OrderDTO> getAllOrders() {
        List<OrderDTO> list = new ArrayList<>();
        // JOIN với bảng Users để lấy FullName
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "ORDER BY o.OrderDate DESC";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(rs.getInt("OrderID"));
                order.setCustomerName(rs.getNString("FullName"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalMoney(rs.getDouble("TotalMoney")); // Khớp TotalMoney
                order.setStatus(rs.getString("Status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3. Cập nhật trạng thái đơn hàng cho Admin
    public boolean updateOrderStatus(int orderID, String status) {
        String sql = "UPDATE Orders SET Status = ? WHERE OrderID = ?";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setNString(1, status);
            stm.setInt(2, orderID);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 4. Tìm kiếm đơn hàng theo mã đơn hoặc tên khách hàng
    public List<OrderDTO> searchOrders(String keyword) {
        List<OrderDTO> list = new ArrayList<>();
        // Kết hợp tìm theo tên khách (FullName) và mã đơn hàng (OrderID)
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "WHERE u.FullName LIKE ? OR CAST(o.OrderID AS VARCHAR) LIKE ? "
                + "ORDER BY o.OrderDate DESC";

        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {

            // Set từ khóa cho cả 2 dấu chấm hỏi (?)
            stm.setNString(1, "%" + keyword + "%");
            stm.setString(2, "%" + keyword + "%");

            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setCustomerName(rs.getNString("FullName"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalMoney(rs.getDouble("TotalMoney"));
                    order.setStatus(rs.getString("Status"));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 5. Lấy chi tiết thông tin chung của 1 đơn hàng (Dành cho trang Chi tiết)
    public OrderDTO getOrderById(int orderID) {
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status, o.ShippingAddress, o.Phone "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "WHERE o.OrderID = ?";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            try ( ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setCustomerName(rs.getNString("FullName"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalMoney(rs.getDouble("TotalMoney"));
                    order.setStatus(rs.getString("Status"));
                    order.setShippingAddress(rs.getNString("ShippingAddress"));
                    order.setPhone(rs.getString("Phone"));
                    return order;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // 6. Lấy danh sách các món đồ nằm trong đơn hàng đó
    public List<OrderDetailDTO> getItemsByOrderId(int orderID) {
        List<OrderDetailDTO> list = new ArrayList<>();
        // Kết nối bảng OrderDetails và Products để lấy được ProductName
        String sql = "SELECT d.OrderDetailID, d.OrderID, d.ProductID, p.ProductName, d.Quantity, d.Price "
                + "FROM OrderDetails d JOIN Products p ON d.ProductID = p.ProductID "
                + "WHERE d.OrderID = ?";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO item = new OrderDetailDTO();
                    item.setOrderDetailID(rs.getInt("OrderDetailID"));
                    item.setOrderID(rs.getInt("OrderID"));
                    item.setProductID(rs.getInt("ProductID"));
                    item.setProductName(rs.getNString("ProductName"));
                    item.setQuantity(rs.getInt("Quantity"));
                    item.setPrice(rs.getDouble("Price"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
