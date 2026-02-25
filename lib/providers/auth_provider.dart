import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/services/auth_service.dart';
import '../core/services/user_cache_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserCacheService _userCache = UserCacheService();
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;
  User? get user => _authService.currentUser;
  AuthProvider() {
    loadLoginState();
  }
  void loadLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLogin') ?? false;
    print("Loaded login state: $_isLoggedIn");
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setLogin(bool value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  Future<String?> signInWithGoogle() async {
    try {
      _setLoading(true);
      final user = await _authService.signInWithGoogle();

      if (user == null) {
        _setLoading(false);
        _setLogin(false);
        return "تم إلغاء تسجيل الدخول";
      }

      _setLoading(false);
      _setLogin(true);
      return null;
    } catch (e) {
      _setLoading(false);
      _setLogin(false);
      return "حدث خطأ غير متوقع: $e";
    }
  }

  Future<String?> signIn(String email, String password) async {
    try {
      _setLoading(true);
      final user = await _authService.signInWithEmail(email, password);
      if (user != null) {
        await _userCache.saveUserData(
          user.displayName ?? "مستخدم",
          user.email ?? email,
        );
      }

      _setLoading(false);
      _setLogin(true);
      print("Login successful $isLoggedIn");
      return null;
    } catch (e) {
      _setLoading(false);
      _setLogin(false);
      return "حدث خطأ: تأكد من صحة البريد الإلكتروني وكلمة المرور";
    }
  }

  Future<String?> signUp(String email, String password, String name) async {
    try {
      _setLoading(true);
      await _authService.signUpWithEmail(email, password, name);
      await _userCache.saveUserData(name, email);

      _setLoading(false);
      _setLogin(true);
      return null;
    } on FirebaseAuthException catch (e) {
      _setLoading(false);
      if (e.code == 'weak-password') {
        _setLogin(false);
        return 'كلمة المرور ضعيفة';
      }
      if (e.code == 'email-already-in-use') {
        _setLogin(false);
        return 'البريد الإلكتروني مسجل مسبقاً';
      }
      _setLogin(false);
      return 'حدث خطأ: ${e.message}';
    } catch (e) {
      _setLoading(false);
      _setLogin(false);
      return 'حدث خطأ غير متوقع';
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
    _setLogin(false);
    notifyListeners();
  }
}
