/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author FPT
 */
public class DBUtils {

    public static Connection getConnection() throws Exception {
        String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";

        String url = "jdbc:sqlserver://localhost:1433;databaseName=PRJ_FashionShop;encrypt=false";

        String user = "sa";
        String pass = "12345"; 

        Class.forName(driverName);
        return DriverManager.getConnection(url, user, pass);
    }

    public static void main(String[] args) {
        try {
            if (getConnection() != null) {
                System.out.println("Chúc mừng nhóm 9! Kết nối thành công với thư viện sqljdbc4.jar.");
            }
        } catch (Exception e) {
            System.out.println("Lỗi kết nối rồi: " + e.getMessage());
        }
    }
}
