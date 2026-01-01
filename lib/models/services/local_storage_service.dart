import 'dart:io';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class LocalStorageService {
  static const String _imageBoxName = 'item_images';
  late Box<String> _imageBox;
  bool _isInitialized = false;

  // ==================== INITIALIZATION ====================

  Future<void> init() async {
    if (_isInitialized) return;

    try {
      await Hive.initFlutter();
      _imageBox = await Hive.openBox<String>(_imageBoxName);
      _isInitialized = true;
      print('✅ Image box initialized successfully');
      // Debug: Print the path
      print('=== HIVE BOX PATH ===');
      print('Box path: ${_imageBox.path}');
      print('Box name: ${_imageBox.name}');
      print('====================');
    } catch (e) {
      print('❌ Failed to initialize image box: $e');
      rethrow;
    }
  }

  // ==================== IMAGE STORAGE ====================

  Future<String> saveItemImage(File imageFile, String itemId) async {
    if (!_isInitialized) {
      await init();
    }
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(path.join(appDir.path, 'item_images'));

      if (!await imageDir.exists()) {
        await imageDir.create(recursive: true);
      }

      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final fileName = '${itemId}_$timestamp.jpg';
      final savedPath = path.join(imageDir.path, fileName);

      await imageFile.copy(savedPath);

      // Store path in Hive synchronously
      _imageBox.put(itemId, savedPath);

      return savedPath;
    } catch (e) {
      throw Exception('Failed to save image locally: $e');
    }
  }

  String? getItemImagePath(String itemId) {
    if (!_isInitialized) return null;

    return _imageBox.get(itemId);
  }

  File? getItemImageFile(String itemId) {
    if (!_isInitialized) return null;
    try {
      final imagePath = getItemImagePath(itemId);
      if (imagePath == null) return null;

      final file = File(imagePath);
      return file.existsSync() ? file : null;
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteItemImage(String itemId) async {
    if (!_isInitialized) {
      await init();
    }
    try {
      final imagePath = getItemImagePath(itemId);
      if (imagePath != null) {
        final file = File(imagePath);
        if (await file.exists()) {
          await file.delete();
        }
        _imageBox.delete(itemId);
      }
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  Future<List<String>> saveMultipleImages(
    List<File> imageFiles,
    String itemId,
  ) async {
    if(!_isInitialized) await init();
    try {
      final savedPaths = <String>[];

      for (var i = 0; i < imageFiles.length; i++) {
        final appDir = await getApplicationDocumentsDirectory();
        final imageDir = Directory(path.join(appDir.path, 'item_images'));

        if (!await imageDir.exists()) {
          await imageDir.create(recursive: true);
        }

        final timestamp = DateTime.now().millisecondsSinceEpoch;
        final fileName = '${itemId}_${i}_$timestamp.jpg';
        final savedPath = path.join(imageDir.path, fileName);

        await imageFiles[i].copy(savedPath);
        savedPaths.add(savedPath);
      }

      // Store first image path as primary
      if (savedPaths.isNotEmpty) {
        _imageBox.put(itemId, savedPaths.first);
      }

      return savedPaths;
    } catch (e) {
      throw Exception('Failed to save multiple images: $e');
    }
  }

  // ==================== BULK OPERATIONS ====================

  List<String> getAllItemIds() {
    return _imageBox.keys.cast<String>().toList();
  }

  Map<String, String> getAllImagePaths() {
    return Map<String, String>.from(_imageBox.toMap());
  }

  int get imageCount => _imageBox.length;

  bool hasImage(String itemId) {
    return _imageBox.containsKey(itemId);
  }

  void clearAll() {
    _imageBox.clear();
  }

  // ==================== CLEANUP ====================

  Future<void> cleanupOrphanedImages(List<String> activeItemIds) async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(path.join(appDir.path, 'item_images'));

      if (!await imageDir.exists()) return;

      // Clean up Hive entries
      final allKeys = _imageBox.keys.cast<String>().toList();
      for (var key in allKeys) {
        if (!activeItemIds.contains(key)) {
          final imagePath = _imageBox.get(key);
          if (imagePath != null) {
            final file = File(imagePath);
            if (await file.exists()) {
              await file.delete();
            }
          }
          _imageBox.delete(key);
        }
      }

      // Clean up orphaned files
      final allFiles = await imageDir.list().toList();
      for (var fileEntity in allFiles) {
        if (fileEntity is File) {
          final fileName = path.basename(fileEntity.path);
          final itemId = fileName.split('_').first;

          if (!activeItemIds.contains(itemId)) {
            await fileEntity.delete();
          }
        }
      }
    } catch (e) {
      print('Failed to cleanup orphaned images: $e');
    }
  }

  Future<int> getTotalStorageSize() async {
    try {
      final appDir = await getApplicationDocumentsDirectory();
      final imageDir = Directory(path.join(appDir.path, 'item_images'));

      if (!await imageDir.exists()) return 0;

      int totalSize = 0;
      final files = await imageDir.list().toList();

      for (var fileEntity in files) {
        if (fileEntity is File) {
          totalSize += await fileEntity.length();
        }
      }

      return totalSize;
    } catch (e) {
      return 0;
    }
  }

  String formatStorageSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  // ==================== DISPOSAL ====================

  Future<void> dispose() async {
    await _imageBox.close();
  }
}
