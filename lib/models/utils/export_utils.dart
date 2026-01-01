import 'dart:io';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rechoice_app/models/model/users_model.dart';

class ExportUtils {
  /// Export users list to CSV file
  static Future<String> exportUsersToCSV(List<Users> users) async {
    try {
      // Prepare CSV headers
      List<List<dynamic>> csvData = [
        [
          'User ID',
          'Name',
          'Email',
          'Status',
          'Role',
          'Reputation Score',
          'Total Listings',
          'Total Purchases',
          'Total Sales',
          'Join Date',
          'Last Login',
          'Phone',
          'Address',
        ],
      ];

      // Add user data rows
      for (var user in users) {
        csvData.add([
          user.userID,
          user.name,
          user.email,
          user.status.toString().split('.').last,
          user.role.toString().split('.').last,
          user.reputationScore.toStringAsFixed(2),
          user.totalListings,
          user.totalPurchases,
          user.totalSales,
          user.joinDate.toString().split(' ')[0],
          user.lastLogin.toString().split(' ')[0],
          user.phoneNumber ?? 'N/A',
          user.address ?? 'N/A',
        ]);
      }

      // Convert to CSV string
      String csv = const ListToCsvConverter().convert(csvData);

      // Get downloads directory
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory.path}/users_export_$timestamp.csv';

      // Write to file
      final file = File(filePath);
      await file.writeAsString(csv);

      return filePath;
    } catch (e) {
      throw Exception('Failed to export users: $e');
    }
  }

  /// Export listings to CSV file
  static Future<String> exportListingsToCSV(List<Map<String, dynamic>> listings) async {
    try {
      // Prepare CSV headers
      List<List<dynamic>> csvData = [
        [
          'Listing ID',
          'Title',
          'Category',
          'Price',
          'Status',
          'Seller',
          'Created Date',
          'Views',
          'Description',
        ],
      ];

      // Add listing data rows
      for (var listing in listings) {
        csvData.add([
          listing['id'] ?? 'N/A',
          listing['title'] ?? 'N/A',
          listing['category'] ?? 'N/A',
          '\$${(listing['price'] ?? 0).toStringAsFixed(2)}',
          listing['status'] ?? 'N/A',
          listing['sellerName'] ?? 'N/A',
          (listing['createdAt'] as DateTime?)?.toString().split(' ')[0] ?? 'N/A',
          listing['views'] ?? 0,
          (listing['description'] ?? 'N/A').toString().replaceAll('\n', ' '),
        ]);
      }

      // Convert to CSV string
      String csv = const ListToCsvConverter().convert(csvData);

      // Get downloads directory
      final directory = await getApplicationDocumentsDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final filePath = '${directory.path}/listings_export_$timestamp.csv';

      // Write to file
      final file = File(filePath);
      await file.writeAsString(csv);

      return filePath;
    } catch (e) {
      throw Exception('Failed to export listings: $e');
    }
  }

  /// Format file size for display
  static String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(2)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }
}
