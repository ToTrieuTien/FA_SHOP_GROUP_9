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
import java.util.List;

/**
 *
 * @author FPT
 */
public class OrderDAO {

    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> listDetail) {
        boolean check = false;
        Connection conn = null;

        try {
            conn = Utils.DBUtils.getConnection();

            if (conn != null) {
                // Tắt AutoCommit để quản lý Transaction (Đảm bảo chèn đủ Order và Details)
                conn.setAutoCommit(false);

                // 1. SQL cho bảng Orders: Khớp thứ tự và tên cột theo ERD image_c22806.png
                // Cột: UserID, OrderDate, TotalAmount, Status, ShippingAddress
                String sqlOrder = "INSERT INTO Orders(UserID, OrderDate, TotalAmount, Status, ShippingAddress) VALUES(?,?,?,?,?)";

                PreparedStatement stmOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);

                //UserID là kiểu String OrderID là INT
                stmOrder.setString(1, order.getUserID());
                stmOrder.setTimestamp(2, order.getOrderDate());
                stmOrder.setDouble(3, order.getTotalMoney()); // Map vào cột TotalAmount
                stmOrder.setString(4, order.getStatus());
                // Sử dụng setNString để hỗ trợ tiếng Việt có dấu cho địa chỉ
                stmOrder.setNString(5, order.getShippingAddress());

                int checkOrder = stmOrder.executeUpdate();

                if (checkOrder > 0) {
                    ResultSet rs = stmOrder.getGeneratedKeys();

                    if (rs.next()) {
                        int orderID = rs.getInt(1);

                        // 2. SQL cho bảng OrderDetails: Đổi sang VariantID và UnitPrice theo đúng ERD
                        String sqlDetail = "INSERT INTO OrderDetails(OrderID, VariantID, UnitPrice, Quantity) VALUES(?,?,?,?)";
                        PreparedStatement stmDetail = conn.prepareStatement(sqlDetail);

                        for (OrderDetailDTO d : listDetail) {
                            stmDetail.setInt(1, orderID);
                            // QUAN TRỌNG: d.getProductID() phải là VariantID từ bảng ProductVariants
                            stmDetail.setInt(2, d.getVariantID());
                            stmDetail.setDouble(3, d.getPrice()); // Map vào UnitPrice
                            stmDetail.setInt(4, d.getQuantity());
                            stmDetail.addBatch();
                        }

                        int[] results = stmDetail.executeBatch();

                        // Kiểm tra xem tất cả các dòng trong Batch có được chèn thành công không
                        boolean allInserted = true;
                        for (int r : results) {
                            if (r == Statement.EXECUTE_FAILED) {
                                allInserted = false;
                                break;
                            }
                        }

                        if (allInserted) {
                            conn.commit(); // Xác nhận lưu dữ liệu vào DB
                            check = true;
                        } else {
                            conn.rollback(); // Hủy bỏ nếu có lỗi ở phần Details
                        }
                    }
                }
                // Reset lại trạng thái AutoCommit
                conn.setAutoCommit(true);
            }

        } catch (Exception e) {
            System.out.println("LỖI TẠI ORDERDAO: " + e.getMessage()); // Dòng này sẽ hiện lỗi chi tiết trong NetBeans
            e.printStackTrace();
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return check;
    }
}
