import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'presentaion/bottomBar/bottomBar.dart';
import 'package:firebase_core/firebase_core.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();

    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) => print('$value'));
  }

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

