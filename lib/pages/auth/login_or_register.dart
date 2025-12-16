import 'package:flutter/material.dart';
import 'package:rechoice_app/pages/auth/login_page.dart';
import 'package:rechoice_app/pages/auth/register.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //show login page /* true = login, false = register */
  bool showLoginPage = true;

  //toggle between login and register pages
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onPressed: togglePages);
    } else {
      return Register(onPressed: togglePages);
    }
  }
}
