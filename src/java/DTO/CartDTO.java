/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DTO;

import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author TRIEUTIEN
 */
public class CartDTO {

    // Key là ProductID (int), Value là đối tượng sản phẩm
    private Map<Integer, ProductDTO> cart;

    public CartDTO() {
        this.cart = new HashMap<>();
    }

    public CartDTO(Map<Integer, ProductDTO> cart) {
        this.cart = cart;
    }

    public Map<Integer, ProductDTO> getCart() {
        return cart;
    }

    public void add(ProductDTO product) {
        if (this.cart == null) {
            this.cart = new HashMap<>();
        }

        if (this.cart.containsKey(product.getProductID())) {
            ProductDTO existing = this.cart.get(product.getProductID());
            existing.setQuantity(existing.getQuantity() + product.getQuantity());
        } else {
            this.cart.put(product.getProductID(), product);
        }
    }
    public void remove(int id) { // Đổi String thành int
        if (this.cart == null) {
            return;
        }
        if (this.cart.containsKey(id)) {
            this.cart.remove(id);
        }
    }

    public void update(int id, int quantity) {
        if (this.cart == null) {
            return;
        }

        if (this.cart.containsKey(id)) {
            if (quantity <= 0) {
                this.cart.remove(id); // xóa luôn
            } else {
                this.cart.get(id).setQuantity(quantity);
            }
        }
    }

    public void clear() {
        if (this.cart != null) {
            this.cart.clear();
        }
    }
    public int getSize() {
        if (this.cart == null) {
            return 0;
        }
        return this.cart.size();
    }
}
