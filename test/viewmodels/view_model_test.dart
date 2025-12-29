import 'package:flutter_test/flutter_test.dart';
import 'package:rechoice_app/models/viewmodels/wishlist_view_model.dart';
import 'package:rechoice_app/services/dummy_data.dart';

void main() {
  group('WishlistViewModel Tests', () {
    late WishlistViewModel viewModel;

    setUp(() {
      viewModel = WishlistViewModel();
    });

    test('should start with empty wishlist', () {
      expect(viewModel.itemCount, 0);
    });

    test('should add items', () {
      final items = DummyData.getFeaturedProducts();
      viewModel.addToWishlist(items[0]);
      expect(viewModel.itemCount, 1);
    });
  });
}