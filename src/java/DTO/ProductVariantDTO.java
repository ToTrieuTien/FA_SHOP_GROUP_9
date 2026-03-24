package DTO;

public class ProductVariantDTO {
    private int variantID;
    private int productID;
    private String size;
    private String color;
    private int stockQuantity;

    public ProductVariantDTO() {}

    public ProductVariantDTO(int variantID, int productID, String size, String color, int stockQuantity) {
        this.variantID = variantID;
        this.productID = productID;
        this.size = size;
        this.color = color;
        this.stockQuantity = stockQuantity;
    }

    public int getVariantID() {
        return variantID;
    }

    public void setVariantID(int variantID) {
        this.variantID = variantID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }


}