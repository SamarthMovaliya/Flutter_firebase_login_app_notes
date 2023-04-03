import 'package:firebase_login_pages/screens/LogInPage.dart';
import 'package:firebase_login_pages/screens/NotePage.dart';
import 'package:firebase_login_pages/screens/Update_Page.dart';
import 'package:firebase_login_pages/screens/homePage.dart';
import 'package:firebase_login_pages/screens/introScreen.dart';
import 'package:firebase_login_pages/screens/signInPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      initialRoute: 'introPage',
      routes: {
        'signInPage': (context) => SignInPage(),
        'LogInPage': (context) => LogInPage(),
        'HomePage': (context) => HomePage(),
        'introPage': (context) => IntroScreen(),
        'NotePage': (context) => NotePage(),
        'Update_Page': (context) => UpdatePage(),
      },
    );
  }
}
