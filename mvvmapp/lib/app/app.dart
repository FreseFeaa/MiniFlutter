import 'package:flutter/material.dart';
import 'package:mvvmapp/features/profile/profile_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elementary Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ProfileScreen.defaultFactory(),
    );
  }
}