import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechoice_app/models/viewmodels/auth_view_model.dart';
import 'package:rechoice_app/models/services/firestore_service.dart';
import 'package:rechoice_app/pages/auth/loading_page.dart';
import 'package:rechoice_app/pages/auth/login_or_register.dart';
import 'package:rechoice_app/pages/auth/landing.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    return StreamBuilder(
      stream: authViewModel.authStateChanges,
      builder: (context, snapshot) {
        Widget widget;

        if (snapshot.connectionState == ConnectionState.waiting) {
          widget = LoadingPage();
        } else if (snapshot.hasData) {
          // User is logged in via Firebase Auth, but we still need to check their Firestore status
          widget = _UserStatusChecker();
        } else {
          widget = LoginOrRegister();
        }
        return widget;
      },
    );
  }
}

class _UserStatusChecker extends StatefulWidget {
  @override
  State<_UserStatusChecker> createState() => _UserStatusCheckerState();
}

class _UserStatusCheckerState extends State<_UserStatusChecker> {
  late Future<Widget> _statusCheckFuture;

  @override
  void initState() {
    super.initState();
    _statusCheckFuture = _checkUserStatusAndGetWidget();
  }

  Future<Widget> _checkUserStatusAndGetWidget() async {
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final firestore = FirestoreService();
      final currentUser = firebaseAuth.currentUser;

      if (currentUser != null) {
        print('DEBUG AuthGate: Checking status for user ${currentUser.uid}');
        
        final userDoc = await firestore.getUser(currentUser.uid);
        final userData = userDoc.data() as Map<String, dynamic>?;

        if (userData != null) {
          final status = userData['status'] as String?;
          print('DEBUG AuthGate: User status is $status');

          if (status == 'suspended') {
            print('DEBUG AuthGate: User is suspended, signing out');
            await firebaseAuth.signOut();
            
            // Show error dialog and return to login
            if (mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Account Suspended'),
                    content: const Text(
                      '⛔ Account Suspended - Your account has been suspended by admin. Please contact support to restore access.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
            return LoginOrRegister();
          }

          if (status == 'deleted') {
            print('DEBUG AuthGate: User is deleted, signing out');
            await firebaseAuth.signOut();
            
            if (mounted) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Account Deleted'),
                    content: const Text(
                      '🗑️ Account Deleted - This account has been permanently deleted.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
            return LoginOrRegister();
          }
        }
      }

      // User is active or status check passed, show landing page
      print('DEBUG AuthGate: User status is active, showing landing page');
      return LandingPage();
    } catch (e) {
      print('DEBUG AuthGate: Error checking user status: $e');
      // On error, allow user to proceed to landing page
      return LandingPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: _statusCheckFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingPage();
        } else if (snapshot.hasData) {
          return snapshot.data!;
        } else {
          return LoginOrRegister();
        }
      },
    );
  }
}
