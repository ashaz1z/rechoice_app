import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rechoice_app/models/viewmodels/auth_view_model.dart';
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
        }
        if (snapshot.hasData) {
          widget = LandingPage();
        } else {
          widget = LoginOrRegister();
        }
        return widget;
      },
    );
  }
}
