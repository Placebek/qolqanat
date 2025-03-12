import 'package:flutter/material.dart';
import 'package:law_code_flutter/api/auth_service.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  void _login() async {
    try {
      final response = await _authService.login(
          _emailController.text, _passwordController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Вход успешен!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка входа: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Вход', style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF1E88E5),
          elevation: 4,
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Пароль'),
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    child: Text('Войти'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
