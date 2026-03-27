package DAO;

import DTO.OrderDTO;
import DTO.OrderDetailDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    // 1. Hàm Đặt hàng (Dùng cho User - Đã fix VariantID)
    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> listDetail) {
        boolean check = false;
        Connection conn = null;
        try {
            conn = Utils.DBUtils.getConnection();
            if (conn != null) {
                conn.setAutoCommit(false);

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
                        // Sử dụng VariantID để khớp với Database mới
                        String sqlDetail = "INSERT INTO OrderDetails(OrderID, Quantity, Price, VariantID) VALUES(?,?,?,?)";
                        PreparedStatement stmDetail = conn.prepareStatement(sqlDetail);

                        for (OrderDetailDTO d : listDetail) {
                            stmDetail.setInt(1, orderID);
                            stmDetail.setInt(2, d.getQuantity());
                            stmDetail.setDouble(3, d.getPrice());
                            stmDetail.setInt(4, d.getVariantID()); // Gọi getVariantID() từ DTO đã sửa
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

    // 2. Lấy tất cả đơn hàng (Dùng cho ManageOrderController)
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

    // 3. Cập nhật trạng thái đơn hàng (Dùng cho UpdateOrderStatusController)
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

    // 4. Tìm kiếm đơn hàng (Dùng cho SearchOrderController)
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

    // 5. Lấy đơn hàng theo ID (Dùng cho OrderDetailController)
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

    // 6. Lấy danh sách sản phẩm trong đơn hàng (Fix Join với VariantID)
    public List<OrderDetailDTO> getItemsByOrderId(int orderID) {
        List<OrderDetailDTO> list = new ArrayList<>();
        String sql = "SELECT d.OrderDetailID, d.OrderID, d.VariantID, p.ProductName, d.Quantity, d.Price "
                + "FROM OrderDetails d "
                + "JOIN ProductVariants pv ON d.VariantID = pv.VariantID "
                + "JOIN Products p ON pv.ProductID = p.ProductID "
                + "WHERE d.OrderID = ?";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    OrderDetailDTO item = new OrderDetailDTO();
                    item.setOrderDetailID(rs.getInt("OrderDetailID"));
                    item.setOrderID(rs.getInt("OrderID"));
                    item.setVariantID(rs.getInt("VariantID")); // Đã đổi sang VariantID
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
    // 7. Lấy lịch sử đơn hàng của 1 User cụ thể (Dùng cho "Theo dõi đơn hàng")

    public List<OrderDTO> getOrdersByUserID(String userID) {
        List<OrderDTO> list = new ArrayList<>();
        // FIX: JOIN với bảng Users để lấy FullName làm CustomerName
        String sql = "SELECT o.OrderID, u.FullName, o.OrderDate, o.TotalMoney, o.Status, o.ShippingAddress, o.Phone "
                + "FROM Orders o JOIN Users u ON o.UserID = u.UserID "
                + "WHERE o.UserID = ? "
                + "ORDER BY o.OrderDate DESC";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {

            stm.setString(1, userID);
            try ( ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    OrderDTO order = new OrderDTO();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setUserID(userID);
                    // FIX: Lấy FullName từ câu JOIN ở trên
                    order.setCustomerName(rs.getNString("FullName"));
                    order.setOrderDate(rs.getTimestamp("OrderDate"));
                    order.setTotalMoney(rs.getDouble("TotalMoney"));
                    order.setStatus(rs.getString("Status"));
                    order.setShippingAddress(rs.getNString("ShippingAddress"));
                    order.setPhone(rs.getString("Phone"));
                    list.add(order);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    // 8. Hủy đơn hàng (Dùng cho User)

    public boolean cancelOrder(int orderID) {
        // Chỉ cho phép hủy nếu đơn đang ở trạng thái '1' (Chờ xác nhận) hoặc 'Awaiting Payment'
        String sql = "UPDATE Orders SET Status = N'Canceled' WHERE OrderID = ? AND (Status = '1' OR Status = 'Processing' OR Status = 'Awaiting Payment')";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    //9.Cập nhật trạng thái sang 'Chờ xác nhận' thay vì cho đi giao luôn
    public boolean confirmPaymentRequest(int orderID, String userID) {
        String sql = "UPDATE Orders SET Status = N'Awaiting Confirmation' "
                + "WHERE OrderID = ? AND UserID = ? AND Status = N'Awaiting Payment'";
        try ( Connection conn = Utils.DBUtils.getConnection();  PreparedStatement stm = conn.prepareStatement(sql)) {
            stm.setInt(1, orderID);
            stm.setString(2, userID);
            return stm.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteOrder(int orderID) {
        String sqlDeleteDetails = "DELETE FROM OrderDetails WHERE OrderID = ?";
        String sqlDeleteOrder = "DELETE FROM Orders WHERE OrderID = ?";
        try ( Connection conn = DBUtils.getConnection()) {
            conn.setAutoCommit(false); // Bắt đầu transaction
            try ( PreparedStatement ps1 = conn.prepareStatement(sqlDeleteDetails);  PreparedStatement ps2 = conn.prepareStatement(sqlDeleteOrder)) {

                ps1.setInt(1, orderID);
                ps1.executeUpdate();

                ps2.setInt(1, orderID);
                int row = ps2.executeUpdate();

                conn.commit(); // Hoàn tất xóa cả 2 bảng
                return row > 0;
            } catch (Exception e) {
                conn.rollback();
                e.printStackTrace();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
