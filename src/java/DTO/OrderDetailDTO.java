package DTO;

public class OrderDetailDTO {
    private int orderDetailID;
    private int orderID;
    private int variantID;
    private int quantity;
    private double price;

    public OrderDetailDTO() {}

    public OrderDetailDTO(int orderDetailID, int orderID, int productID, int quantity, double price) {
        this.orderDetailID = orderDetailID;
        this.orderID = orderID;
        this.variantID = productID;
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
    }

    public void setVariantID(int productID) {
        this.variantID = productID;
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