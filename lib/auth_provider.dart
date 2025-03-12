import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final String name;
  User(this.name); // Простая модель пользователя
}

class AuthProvider with ChangeNotifier {
  User? _user;
  String? _token;

  bool get isAuthenticated => _token != null; // Проверка наличия токена
  User? get user => _user;

  AuthProvider() {
    _loadToken(); // Загружаем токен при инициализации
  }

  Future<void> _loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('auth_token');
    if (_token != null) {
      _user =
          User('Test User'); // Здесь должен быть реальный пользователь из API
    }
    notifyListeners(); // Уведомляем слушателей об изменении состояния
  }

  Future<void> login(String email, String password) async {
    // Пример логики входа (замени на свой API-запрос)
    try {
      // Симуляция успешного входа
      final prefs = await SharedPreferences.getInstance();
      _token = 'example_token'; // Замени на токен из API
      await prefs.setString('auth_token', _token!);
      _user = User('Test User'); // Замени на данные из API
      notifyListeners(); // Обновляем UI
    } catch (e) {
      print('Ошибка входа: $e');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    _token = null;
    _user = null;
    notifyListeners(); // Обновляем UI
  }
}
