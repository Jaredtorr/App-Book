import 'package:flutter/material.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';

class AuthProvider extends ChangeNotifier {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;

  AuthProvider({
    required this.loginUseCase,
    required this.registerUseCase,
  });

  String? _token;
  String? _name;
  bool _isLoading = false;
  String? _error;

  String? get token => _token;
  String? get name => _name;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isAuthenticated => _token != null;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      print(' Intentando login con: $email');
      final result = await loginUseCase.call(LoginParams(email: email, password: password));
      print(' Resultado: $result');
      final parts = result.split('|');
      _token = parts[0];
      _name = parts.length > 1 ? parts[1] : 'Usuario';
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      print(' Error: $e');
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await registerUseCase.call(RegisterParams(name: name, email: email, password: password));
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _token = null;
    _name = null;
    notifyListeners();
  }
}