import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rechoice_app/models/services/authenticate.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel({required AuthService authService})
    : _authService = authService;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  User? get currentUser => _authService.currentUser;
  Stream<User?> get authStateChanges => _authService.authStateChanges;

  Future<void> register({
    required String email,
    required String password,
    required String name,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.register(email: email, password: password, name: name);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Registration failed';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.login(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _errorMessage = e.message ?? 'Login failed';
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _authService.logout();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
