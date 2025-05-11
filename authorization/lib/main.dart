import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'home_page.dart';

void main() {
  runApp(MyApp()); // Запускаем приложение
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Data App', // Заголовок 
      theme: ThemeData.dark(), // тема приложения
      home: FutureBuilder<bool>(
        future: _isLoggedIn(), // проверяем авторизован ли пользователь
        builder: (context, snapshot) {
          // Смотримм состояние загрузки и результат проверки авторизации
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // индикатор загрузки
          } else if (snapshot.data == true) {
            return HomePage(); // Если авторизован, переходим на главную страницу
          } else {
            return LoginPage(); // Если не авторизован, переходим на страницу входа
          }
        },
      ),
    );
  }

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance(); 
    return prefs.getBool('isLoggedIn') ?? false; // Возвращаем статус авторизации (по умолчанию false)
  }
}