import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rechoice_app/models/model/items_model.dart';

class ListingNotificationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Send notification to seller when their listing status changes
  Future<void> notifyListingStatusChange({
    required String listingId,
    required String sellerUserId,
    required String listingTitle,
    required ModerationStatus status,
    String? rejectionReason,
  }) async {
    try {
      final notification = {
        'type': 'listing_status_change',
        'listingId': listingId,
        'listingTitle': listingTitle,
        'status': status.toString().split('.').last,
        'timestamp': FieldValue.serverTimestamp(),
        'read': false,
        'title': _getNotificationTitle(status),
        'message': _getNotificationMessage(status, listingTitle, rejectionReason),
      };

      // Add notification to user's notifications collection
      await _firestore
          .collection('users')
          .doc(sellerUserId)
          .collection('notifications')
          .add(notification);

      print('✅ Notification sent to $sellerUserId for listing: $listingTitle');
    } catch (e) {
      print('❌ Error sending notification: $e');
      rethrow;
    }
  }

  /// Get notification title based on status
  String _getNotificationTitle(ModerationStatus status) {
    switch (status) {
      case ModerationStatus.approved:
        return '🎉 Listing Approved!';
      case ModerationStatus.rejected:
        return '❌ Listing Rejected';
      case ModerationStatus.flagged:
        return '⚠️ Listing Flagged';
      case ModerationStatus.pending:
        return '⏳ Under Review';
    }
  }

  /// Get notification message based on status
  String _getNotificationMessage(
    ModerationStatus status,
    String listingTitle,
    String? rejectionReason,
  ) {
    switch (status) {
      case ModerationStatus.approved:
        return 'Your listing "$listingTitle" has been approved and is now visible to buyers!';
      case ModerationStatus.rejected:
        final reason = rejectionReason?.isNotEmpty == true
            ? '\n\nReason: $rejectionReason'
            : '';
        return 'Your listing "$listingTitle" was rejected by our moderation team.$reason';
      case ModerationStatus.flagged:
        return 'Your listing "$listingTitle" has been flagged for review.';
      case ModerationStatus.pending:
        return 'Your listing "$listingTitle" is under review. Please wait for approval.';
    }
  }

  /// Get user's notifications
  Future<List<Map<String, dynamic>>> getUserNotifications(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .orderBy('timestamp', descending: true)
          .limit(50)
          .get();

      return snapshot.docs
          .map((doc) => {
                'id': doc.id,
                ...doc.data(),
              })
          .toList();
    } catch (e) {
      print('❌ Error fetching notifications: $e');
      return [];
    }
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(
    String userId,
    String notificationId,
  ) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .doc(notificationId)
          .update({'read': true});

      print('✅ Notification marked as read');
    } catch (e) {
      print('❌ Error marking notification as read: $e');
      rethrow;
    }
  }

  /// Get unread notification count
  Future<int> getUnreadNotificationCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('notifications')
          .where('read', isEqualTo: false)
          .count()
          .get();

      return snapshot.count ?? 0;
    } catch (e) {
      print('❌ Error getting unread count: $e');
      return 0;
    }
  }
}
