package DAO;

import DTO.UserDTO;
import Utils.DBUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * @author FPT
 */
public class UserDAO {

    /**
     * Hàm kiểm tra đăng nhập bằng cả Email hoặc UserID
     */
    public UserDTO checkLogin(String loginID, String password) {
        UserDTO user = null;
        // Dùng OR để kiểm tra khớp Email hoặc khớp UserID
        String sql = "SELECT UserID, FullName, Email, RoleID, Status, Phone, Address "
                   + "FROM Users "
                   + "WHERE (Email = ? OR UserID = ?) AND Password = ? AND Status = 1";

        try (Connection con = DBUtils.getConnection(); 
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, loginID);   // Dấu ? thứ 1 (dành cho Email)
            ps.setString(2, loginID);   // Dấu ? thứ 2 (dành cho UserID)
            ps.setString(3, password);  // Dấu ? thứ 3 (dành cho Password)

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    user = new UserDTO();
                    user.setUserID(rs.getString("UserID"));
                    user.setFullName(rs.getString("FullName"));
                    user.setEmail(rs.getString("Email"));
                    user.setRoleID(rs.getInt("RoleID"));
                    user.setStatus(rs.getBoolean("Status"));
                    user.setPhone(rs.getString("Phone"));
                    user.setAddress(rs.getString("Address"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    /**
     * Hàm đăng ký thành viên mới kèm lưu mã xác thực
     */
    public boolean insert(UserDTO user, String code) throws Exception {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO Users(UserID, FullName, RoleID, Password, Address, Phone, Email, Status, VerificationCode) "
                           + " VALUES(?,?,?,?,?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, user.getUserID());
                stm.setString(2, user.getFullName());
                stm.setInt(3, user.getRoleID());
                stm.setString(4, user.getPassword());
                stm.setString(5, user.getAddress());
                stm.setString(6, user.getPhone());
                stm.setString(7, user.getEmail());
                stm.setBoolean(8, false); // Ép cứng Status là false (0) vì chưa xác thực
                stm.setString(9, code);   // Lưu mã xác thực
                
                check = stm.executeUpdate() > 0;
            }
        } finally {
            if (stm != null) stm.close();
            if (conn != null) conn.close();
        }
        return check;
    }

    /**
     * Hàm xác thực tài khoản qua email
     */
    public boolean verifyAccount(String code) {
        String sql = "UPDATE Users SET Status = 1, VerificationCode = NULL WHERE VerificationCode = ?";
        try (Connection con = DBUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, code);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}