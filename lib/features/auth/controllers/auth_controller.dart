import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@singleton
class AuthController extends ChangeNotifier {
  AuthController() {
    init();
  }
  late final FirebaseAuth _firebaseAuth;
  User? _user;
  User? get user => _user;

  void init() {
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.authStateChanges().listen(_authChangesListener);
    _firebaseAuth.idTokenChanges().listen(_isTokenChangesListener);
    _firebaseAuth.userChanges().listen(_userChangesListener);
  }

  void _authChangesListener(User? user) {
    _user = user;
    notifyListeners();
  }

  void _isTokenChangesListener(User? user) {}
  void _userChangesListener(User? user) {
    if (user != null) {
      _user = user;
    }
  }

  Future signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final result = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (exception) {
      print(exception);
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (exception) {
      print(exception);
    }
  }
}
