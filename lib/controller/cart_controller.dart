import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/cart_item.dart';

class CartController extends GetxController {
  var cartItems = <CartItem>[].obs;
  final Box<CartItem> cartBox = Hive.box<CartItem>('cart');

  @override
  void onInit() {
    super.onInit();
    loadCartItems();
  }

  // Load cart items from Hive box
  void loadCartItems() {
    cartItems.assignAll(cartBox.values.toList());
  }

  // Add product to cart
  void addToCart(CartItem item) {
    final existingItem = cartItems.firstWhereOrNull((cartItem) => cartItem.productId == item.productId);

    if (existingItem != null) {
      // If item exists, update its quantity
      updateQuantity(existingItem, existingItem.quantity + 1);
    } else {
      // If item doesn't exist, add new item to the cart
      int nextKey = cartBox.length;
      cartBox.add(CartItem(
        productId: item.productId,
        title: item.title,
        price: item.price,
        quantity: item.quantity,
        key: nextKey,
         image: item.image,
      ));
      cartItems.add(item);
    }
  }

  // Update item quantity
  void updateQuantity(CartItem item, int quantity) {
    item.quantity = quantity;
    cartBox.put(item.key, item); 
    cartItems.refresh();  
  }

  // Remove item from cart
  void removeFromCart(CartItem item) {
    cartBox.delete(item.key);  
    cartItems.remove(item);   
  }

  // Calculate total amount
  double get totalAmount {
    return cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}