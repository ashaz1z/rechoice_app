import 'package:rechoice_app/models/model/items_model.dart';

class CartItem {
  final Items items;
  int quantity;

  CartItem({required this.items, this.quantity = 1});
  
  // Helper function to calculate totalPrice of cart
  double get totalPrice => (items.price) * quantity;
}
