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

public class OrderDAO {

    // 1. Đặt hàng (Transaction - Đã gộp Phone và VariantID theo ERD mới nhất)
    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> listDetail) {
        boolean check = false;
        Connection conn = null;
        try {
            conn = Utils.DBUtils.getConnection();
            if (conn != null) {
                conn.setAutoCommit(false); // Bắt đầu Transaction

                String sqlOrder = "INSERT INTO Orders(UserID, OrderDate, TotalMoney, ShippingAddress, Phone, Status) VALUES(?,?,?,?,?,?)";
                PreparedStatement stmOrder = conn.prepareStatement(sqlOrder, Statement.RETURN_GENERATED_KEYS);

                stmOrder.setString(1, order.getUserID());
                stmOrder.setTimestamp(2, order.getOrderDate());
                stmOrder.setDouble(3, order.getTotalMoney());
                stmOrder.setNString(4, order.getShippingAddress());
                stmOrder.setString(5, order.getPhone());
                stmOrder.setString(6, order.getStatus());

                if (stmOrder.executeUpdate() > 0) {
                    ResultSet rs = stmOrder.getGeneratedKeys();
                    if (rs.next()) {
                        int orderID = rs.getInt(1);
                        // Cấu trúc OrderDetails: OrderID, Quantity, Price, ProductID (hoặc VariantID)
                        String sqlDetail = "INSERT INTO OrderDetails(OrderID, Quantity, Price, ProductID) VALUES(?,?,?,?)";
                        PreparedStatement stmDetail = conn.prepareStatement(sqlDetail);

                        for (OrderDetailDTO d : listDetail) {
                            stmDetail.setInt(1, orderID);
                            stmDetail.setInt(2, d.getQuantity());
                            stmDetail.setDouble(3, d.getPrice());
                            stmDetail.setInt(4, d.getProductID());
                            stmDetail.addBatch();
                        }

                        int[] results = stmDetail.executeBatch();
                        boolean allInserted = true;
                        for (int r : results) {
                            if (r == Statement.EXECUTE_FAILED) {
                                allInserted = false;
                                break;
                            }
                        }

                        if (allInserted) {
                            conn.commit();
                            check = true;
                        } else {
                            conn.rollback();
                        }
                    }
                }
                conn.setAutoCommit(true);
            }
        } catch (Exception e) {
            if (conn != null) try {
                conn.rollback();
            } catch (SQLException ex) {
            }
            e.printStackTrace();
        } finally {
            if (conn != null) try {
                conn.close();
            } catch (SQLException e) {
            }
        }
        return check;
    }

    // --- CÁC HÀM QUẢN LÝ CỦA THÀNH (ADMIN) ---
    public List<OrderDTO> getAllOrders() {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "ORDER BY o.OrderDate DESC";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql);  ResultSet rs = stm.executeQuery()) {
            while (rs.next()) {
                OrderDTO order = new OrderDTO();
                order.setOrderID(rs.getInt("OrderID"));
                order.setCustomerName(rs.getNString("FullName"));
                order.setOrderDate(rs.getTimestamp("OrderDate"));
                order.setTotalMoney(rs.getDouble("TotalMoney"));
                order.setStatus(rs.getString("Status"));
                list.add(order);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

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

    public List<OrderDTO> searchOrders(String keyword) {
        List<OrderDTO> list = new ArrayList<>();
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "WHERE u.FullName LIKE ? OR CAST(o.OrderID AS VARCHAR) LIKE ? "
                + "ORDER BY o.OrderDate DESC";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
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

    public List<OrderDetailDTO> getItemsByOrderId(int orderID) {
        List<OrderDetailDTO> list = new ArrayList<>();
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
