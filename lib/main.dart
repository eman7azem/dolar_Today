import 'package:dolar_today/presentaion/bottomBar/bottom_bar.dart';
import 'package:dolar_today/presentaion/currencies/currencies.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.white)
      ),
      debugShowCheckedModeBanner: false,
      home:BottomBar() ,
    );
  }
}

