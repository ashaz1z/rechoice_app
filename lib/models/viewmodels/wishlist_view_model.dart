import 'package:flutter/foundation.dart';
import 'package:rechoice_app/models/model/items_model.dart';

class WishlistViewModel extends ChangeNotifier {
  //List for holding the  list of wishlist items
  final List<Items> _wishlistItems = [];

  //Getter function for item count
  int get itemCount => _wishlistItems.length;

  //Getter function for current list (read-only)
  List<Items> get items => List.unmodifiable(_wishlistItems);

  //CRUD Operation

  //Method to add the items to the wishlist
  void addToWishlist(Items items) {
    //check if the items is already in the list
    if (!_wishlistItems.any((product) => product.itemID == items.itemID)) {
      // Create a new list with the added item to trigger notification
      _wishlistItems.add(items);
      notifyListeners();
      // print('✓ Added: ${items.title} (ID: ${items.itemID})');
      // print('  Total items: ${itemCount}');
    } 
    // else {
    //   print('✗ Already in wishlist: ${items.title}');
    // }
  }

  //Method to remove the items from the wishlist
  void removeFromWishlist(int itemsID) {
    // Filter the list to remove the specified item and update the
    _wishlistItems.removeWhere((product) => product.itemID == itemsID);
    notifyListeners();
    // print('✓ Removed item ID: $itemsID');
    // print('  Total items: ${itemCount}');
  }

  //Method to clear all items in the wishkist
  void clearAllFromWishList() {
    _wishlistItems.clear();
    notifyListeners();
  }

  // Method to check if a item is in the wishlist
  bool isItemInWishlist(int itemsID) {
    return _wishlistItems.any((product) => product.itemID == itemsID);
  }
}
