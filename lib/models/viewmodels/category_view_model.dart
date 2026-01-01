import 'package:flutter/foundation.dart';
import 'package:rechoice_app/models/model/category_model.dart';
import 'package:rechoice_app/models/services/category_service.dart';

enum CategoryLoadingState { idle, loading, loaded, error }

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _categoryService;

  CategoryLoadingState _state = CategoryLoadingState.idle;
  String? _errorMessage;
  List<ItemCategoryModel> _categories = [];
  ItemCategoryModel? _selectedCategory;

  CategoryViewModel(this._categoryService);

  // ==================== GETTERS ====================

  CategoryLoadingState get state => _state;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _state == CategoryLoadingState.loading;
  bool get hasError => _state == CategoryLoadingState.error;

  List<ItemCategoryModel> get categories => List.unmodifiable(_categories);
  ItemCategoryModel? get selectedCategory => _selectedCategory;
  int get categoryCount => _categories.length;

  // ==================== FETCH OPERATIONS ====================

  Future<void> fetchCategories() async {
    _setState(CategoryLoadingState.loading);
    try {
      _categories = await _categoryService.getAllCategories();
      _setState(CategoryLoadingState.loaded);
    } catch (e) {
      _setError('Failed to load categories: $e');
    }
  }

  Future<ItemCategoryModel?> fetchCategoryById(String categoryId) async {
    try {
      return await _categoryService.getCategoryById(categoryId);
    } catch (e) {
      _setError('Failed to load category: $e');
      return null;
    }
  }

  Future<ItemCategoryModel?> fetchCategoryByNumericId(int categoryId) async {
    try {
      return await _categoryService.getCategoryByNumericId(categoryId);
    } catch (e) {
      _setError('Failed to load category: $e');
      return null;
    }
  }

  // ==================== CRUD OPERATIONS ====================

  Future<String?> createCategory({
    required String name,
    required String iconName,
  }) async {
    try {
      // Check if category already exists
      final exists = await _categoryService.categoryExists(name);
      if (exists) {
        _setError('Category "$name" already exists');
        return null;
      }

      final categoryId = await _categoryService.createCategory(
        name: name,
        iconName: iconName,
      );

      await fetchCategories();
      return categoryId;
    } catch (e) {
      _setError('Failed to create category: $e');
      return null;
    }
  }

  Future<bool> updateCategory(
    String categoryId,
    Map<String, dynamic> updates,
  ) async {
    try {
      await _categoryService.updateCategory(categoryId, updates);
      await fetchCategories();
      return true;
    } catch (e) {
      _setError('Failed to update category: $e');
      return false;
    }
  }

  Future<bool> deleteCategory(String categoryId) async {
    try {
      await _categoryService.deleteCategory(categoryId);
      _categories.removeWhere((cat) => cat.categoryID.toString() == categoryId);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to delete category: $e');
      return false;
    }
  }

  // ==================== SELECTION ====================

  void selectCategory(ItemCategoryModel? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearSelection() {
    _selectedCategory = null;
    notifyListeners();
  }

  // ==================== SEARCH & FILTER ====================

  List<ItemCategoryModel> searchCategories(String query) {
    if (query.isEmpty) return _categories;

    final lowerQuery = query.toLowerCase();
    return _categories
        .where((cat) => cat.name.toLowerCase().contains(lowerQuery))
        .toList();
  }

  ItemCategoryModel? getCategoryByName(String name) {
    try {
      return _categories.firstWhere(
        (cat) => cat.name.toLowerCase() == name.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  ItemCategoryModel? getCategoryById(int categoryId) {
    try {
      return _categories.firstWhere((cat) => cat.categoryID == categoryId);
    } catch (e) {
      return null;
    }
  }

  // ==================== SEED DATA ====================

  Future<void> seedDefaultCategories() async {
    try {
      await _categoryService.seedDefaultCategories();
      await fetchCategories();
    } catch (e) {
      _setError('Failed to seed categories: $e');
    }
  }

  // ==================== STREAM SUPPORT ====================

  void listenToCategories() {
    _categoryService.streamCategories().listen(
      (categories) {
        _categories = categories;
        _state = CategoryLoadingState.loaded;
        notifyListeners();
      },
      onError: (error) {
        _setError('Stream error: $error');
      },
    );
  }

  // ==================== HELPER METHODS ====================

  bool hasCategory(String name) {
    return _categories.any(
      (cat) => cat.name.toLowerCase() == name.toLowerCase(),
    );
  }

  // ==================== PRIVATE HELPERS ====================

  void _setState(CategoryLoadingState newState) {
    _state = newState;
    if (newState != CategoryLoadingState.error) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  void _setError(String error) {
    _state = CategoryLoadingState.error;
    _errorMessage = error;
    notifyListeners();
    debugPrint('CategoryViewModel Error: $error');
  }

  @override
  void dispose() {
    super.dispose();
  }
}
