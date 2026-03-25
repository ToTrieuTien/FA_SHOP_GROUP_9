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
import java.util.List;

/**
 *
 * @author FPT
 */
public class OrderDAO {

    public boolean insertOrder(OrderDTO order, List<OrderDetailDTO> listDetail) {
        boolean check = false;
        try ( Connection conn = Utils.DBUtils.getConnection()) {
            if (conn != null) {
                conn.setAutoCommit(false);

                // Insert Order
                String sqlOrder = "INSERT INTO tblOrders(userID, orderDate, totalMoney, shippingAddress, phone, status) VALUES(?,?,?,?,?,?)";
                try ( PreparedStatement stmOrder = conn.prepareStatement(sqlOrder, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    stmOrder.setString(1, order.getUserID());
                    stmOrder.setTimestamp(2, order.getOrderDate());
                    stmOrder.setDouble(3, order.getTotalMoney());
                    stmOrder.setString(4, order.getShippingAddress());
                    stmOrder.setString(5, order.getPhone());
                    stmOrder.setString(6, order.getStatus());

                    int checkOrder = stmOrder.executeUpdate();
                    if (checkOrder > 0) {
                        try ( ResultSet rs = stmOrder.getGeneratedKeys()) {
                            if (rs.next()) {
                                int orderID = rs.getInt(1);

                                // Insert OrderDetail
                                String sqlDetail = "INSERT INTO tblOrderDetails(orderID, productID, price, quantity) VALUES(?,?,?,?)";
                                try ( PreparedStatement stmDetail = conn.prepareStatement(sqlDetail)) {
                                    for (OrderDetailDTO d : listDetail) {
                                        stmDetail.setInt(1, orderID);
                                        stmDetail.setInt(2, d.getProductID());
                                        stmDetail.setDouble(3, d.getPrice());
                                        stmDetail.setInt(4, d.getQuantity());
                                        stmDetail.addBatch();
                                    }
                                    int[] results = stmDetail.executeBatch();
                                    boolean allInserted = true;
                                    for (int r : results) {
                                        if (r <= 0) {
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
                        }
                    }
                } catch (Exception e) {
                    conn.rollback();
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return check;
    }

}
