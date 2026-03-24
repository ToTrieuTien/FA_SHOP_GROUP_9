/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Utils;

/**
 *
 * @author FPT
 */
public class MyValidation {

    // 1. Kiểm tra định dạng UserID (Bắt đầu bằng SE và theo sau là đúng 6 chữ số)
    public static boolean isValidUserID(String userID) {
        if (userID == null) return false;
        // Regex: ^ (bắt đầu), SE, \\d{6} (6 chữ số), $ (kết thúc)
        String regex = "^SE\\d{6}$"; 
        return userID.matches(regex);
    }

    // 2. Kiểm tra Email (Đúng định dạng @ và tên miền)
    public static boolean isValidEmail(String email) {
        if (email == null) return false;
        String regex = "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$";
        return email.matches(regex);
    }

    // 3. Kiểm tra độ dài mật khẩu (Ví dụ: tối thiểu 1 ký tự theo dữ liệu của em)
    public static boolean isValidPassword(String password) {
        return password != null && password.length() >= 1;
    }

    // 4. Kiểm tra chuỗi trống (Dùng để check các trường bắt buộc như Address, FullName)
    public static boolean isEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }
}
