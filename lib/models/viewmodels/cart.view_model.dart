import 'package:flutter/foundation.dart';
import 'package:rechoice_app/models/model/items_model.dart';
import 'package:rechoice_app/models/viewmodels/wishlist_view_model.dart';
import 'package:rechoice_app/models/model/cart_model.dart';

class CartViewModel extends ChangeNotifier {
  //add wishlist view model
  final WishlistViewModel wishlistViewModel;

  // List for holding the cart item
  final List<CartItem> _cartItems = [];

  CartViewModel({required this.wishlistViewModel});

  //Getter function for current list (read-only)
  List<CartItem> get cartItems => List.unmodifiable(_cartItems);

  //Getter for unique types of items
  int get uniqueItemCount => _cartItems.length;

  //Getter for total sum of all quantity combined

  int get totalQuantity =>
      _cartItems.fold(0, (sum, item) => sum + item.quantity);

  //Getter function for grand total price of cart
  double get grandTotalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.totalPrice);

  //CRUD operations

  //add to cart Method
  void addToCart(Items item) {
    //check if the product is already in the cart
    int index = _cartItems.indexWhere(
      (cartItem) => cartItem.items.itemID == item.itemID,
    );

    if (index != -1) {
      // If it exists, increase the quantity of the existing CartItem
      _cartItems[index].quantity++;
    } else {
      // If it's new, add a new CartItem model instance
      _cartItems.add(CartItem(items: item));
    }
    notifyListeners();
  }

  //Methods for moving all product from wishlist
  void addFromWishlist(Items item) {
    // add wishlist item to cart
    addToCart(item);
    //delete added item from wishlist
    wishlistViewModel.removeFromWishlist(item.itemID);
  }

  // remove item from cart method
  void removeFromCart(Items item) {
    _cartItems.removeWhere((cartItem) => cartItem.items.itemID == item.itemID);
    notifyListeners();
  }

  // decrease the quantity of item in cart
  void decreaseQuantity(Items item) {
    int index = _cartItems.indexWhere(
      (cartItem) => cartItem.items.itemID == item.itemID,
    );

    if (index != -1) {
      if (_cartItems[index].quantity > 1) {
        _cartItems[index].quantity--;
      } else {
        // Remove if quantity reaches 0
        _cartItems.removeAt(index);
      }
      notifyListeners();
    }
  }

  //clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
