package DTO;

public class CategoryDTO {
    private int categoryID;
    private String categoryName;
    private boolean status;
    private int productCount;

    public CategoryDTO() {
    }

    public CategoryDTO(int categoryID, String categoryName, boolean status, int productCount) {
        this.categoryID = categoryID;
        this.categoryName = categoryName;
        this.status = status;
        this.productCount = productCount;
    }

    public int getCategoryID() {
        return categoryID;
    }

    public void setCategoryID(int categoryID) {
        this.categoryID = categoryID;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }
    
    

    


}