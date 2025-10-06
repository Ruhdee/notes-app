import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../repositories/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repo;
  User? _user;
  bool _isLoading = false;
  String? _error;
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  AuthViewModel(this.repo) {
    repo.authStateChanges.listen((u) {
      _user = u;
      notifyListeners();
    });
    _user = repo.currentUser;
  }
  User? get user => _user;
  bool get isAuthenticated => _user != null;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> signIn(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await repo.signIn(email, password);
    } on FirebaseAuthException catch (e) {
      _error = e.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signUp(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _user = await repo.signUp(email, password);
    } on FirebaseAuthException catch (e) {
      _error = e.message;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    await repo.signOut();
    _user = null;
    _isLoading = false;
    notifyListeners();
  }
}
