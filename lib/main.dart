import 'package:flutter/material.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';
import 'registration_screen.dart';
import 'TeamPage.dart';
import 'start.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.white,
      ),
      home: MaterialApp(
        initialRoute: WelcomeScreen
            .id, //usa assim ao invés da string pq tem menos chanches de errar na hora de chamar a route e se perder no meio do codigo
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          TeamPage.id: (context) => TeamPage(),
          StarterMenu.id: (context) => StarterMenu(),
        },
      ),
    );
  }
}
