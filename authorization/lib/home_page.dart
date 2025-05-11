import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget { // Главная домашняя страницы
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'), // Заголовок 
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Кнопка 
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance(); //Доступ к SharedPreferences
              await prefs.setBool('isLoggedIn', false); //Статус авторизации в false
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage())); // Переходим на страницу входа
            },
          )
        ],
      ),
      body: FutureBuilder<Map<String, String?>>(
        future: _getUserData(), // получаем данные пользователя
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator()); // индикатор загрузки
          } else if (snapshot.hasData) {
            final data = snapshot.data!; // данные пользователя из snapshot
            return Padding(
              padding: const EdgeInsets.all(16.0), // Отступы
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание
                children: [
                  Text('Name: ${data['name']}', style: TextStyle(fontSize: 20)), //  имя пользователя
                  SizedBox(height: 10), 
                  Text('Email: ${data['email']}', style: TextStyle(fontSize: 20)), //  email пользователя
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found')); // если данные не найдены
          }
        },
      ),
    );
  }

  Future<Map<String, String?>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance(); //  доступ к SharedPreferences
    String? name = prefs.getString('name'); //  имя пользователя
    String? email = prefs.getString('email'); //  email пользователя
    return {'name': name, 'email': email}; // Возвращаем данные 
  }
}