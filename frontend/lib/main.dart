import 'package:flutter/material.dart';
import 'package:frontend/const/size.dart';
import 'package:frontend/screen/login.dart';
import 'package:frontend/screen/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
      title: 'My App',
      // Initial route
      initialRoute: '/',
      // Define all routes
      routes: {
        '/login': (context) => Login(),
        '/register': (context) => Register(),
      },
    );
  }
}
