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
                conn.setAutoCommit(false);

                // 1. Thêm cột Phone vào SQL theo đúng ERD image_e12329.png
                String sqlOrder = "INSERT INTO Orders(UserID, OrderDate, TotalMoney, ShippingAddress, Phone, Status) VALUES(?,?,?,?,?,?)";
                PreparedStatement stmOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS);

                stmOrder.setString(1, order.getUserID());
                stmOrder.setTimestamp(2, order.getOrderDate());
                stmOrder.setDouble(3, order.getTotalMoney());
                stmOrder.setNString(4, order.getShippingAddress());
                stmOrder.setString(5, order.getPhone()); // Đã bổ sung Phone
                stmOrder.setString(6, order.getStatus());

                int checkOrder = stmOrder.executeUpdate();

                if (checkOrder > 0) {
                    ResultSet rs = stmOrder.getGeneratedKeys();
                    if (rs.next()) {
                        int orderID = rs.getInt(1);

                        // 2. Sửa lại SQL và thứ tự set giá trị cho OrderDetails
                        // Thứ tự chuẩn trong DB của Tiến: OrderID -> Quantity -> Price -> VariantID
                        String sqlDetail = "INSERT INTO OrderDetails(OrderID, Quantity, Price, VariantID) VALUES(?,?,?,?)";
                        PreparedStatement stmDetail = conn.prepareStatement(sqlDetail);

                        for (OrderDetailDTO d : listDetail) {
                            stmDetail.setInt(1, orderID);
                            stmDetail.setInt(2, d.getQuantity()); // Quantity đứng trước
                            stmDetail.setDouble(3, d.getPrice()); // Price tiếp theo
                            stmDetail.setInt(4, d.getVariantID()); // VariantID đứng cuối
                            stmDetail.addBatch();
                        }

                        int[] results = stmDetail.executeBatch();

                        // Kiểm tra batch
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
            System.out.println("LỖI TẠI ORDERDAO: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Close connection...
        }
        return check;
    }
}
