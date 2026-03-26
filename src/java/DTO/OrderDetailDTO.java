package DTO;

public class OrderDetailDTO {

    private int orderDetailID;
    private int orderID;
    private int variantID; // Đã đổi từ productID sang variantID
    private String productName;
    private int quantity;
    private double price;

    public OrderDetailDTO() {
    }

    public OrderDetailDTO(int orderDetailID, int orderID, int variantID, String productName, int quantity, double price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.variantID = variantID;
        this.productName = productName;
        this.quantity = quantity;
        this.price = price;
    }

    public int getOrderDetailID() {
        return orderDetailID;
    }

    public void setOrderDetailID(int orderDetailID) {
        this.orderDetailID = orderDetailID;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getVariantID() {
        return variantID;
    } // Đã cập nhật Getter

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    } // Đã cập nhật Setter

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
