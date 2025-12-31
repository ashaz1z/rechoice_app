// admin_auth_gate.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rechoice_app/pages/admin/admin_dashboard.dart';
import 'package:rechoice_app/pages/auth/login_admin.dart';

class AdminAuthGate extends StatelessWidget {
  const AdminAuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading only on connection wait
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Not logged in
        if (!snapshot.hasData) {
          return const AdminLoginPage();
        }

        // Logged in - show dashboard
        // (Role was already verified during login)
        return const AdminDashboardPage();
      },
    );
  }
}
