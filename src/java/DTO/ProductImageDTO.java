package DTO;

public class ProductImageDTO {
    private int imageID;
    private int productID;
    private String imageURL;
    private boolean isPrimary;

    public ProductImageDTO() {}

    public ProductImageDTO(int imageID, int productID, String imageURL, boolean isPrimary) {
        this.imageID = imageID;
        this.productID = productID;
        this.imageURL = imageURL;
        this.isPrimary = isPrimary;
    }

    public int getImageID() {
        return imageID;
    }

    public void setImageID(int imageID) {
        this.imageID = imageID;
    }

    public int getProductID() {
        return productID;
    }

    public void setProductID(int productID) {
        this.productID = productID;
    }

    public String getImageURL() {
        return imageURL;
    }

    public void setImageURL(String imageURL) {
        this.imageURL = imageURL;
    }

    public boolean isIsPrimary() {
        return isPrimary;
    }

    public void setIsPrimary(boolean isPrimary) {
        this.isPrimary = isPrimary;
    }


}