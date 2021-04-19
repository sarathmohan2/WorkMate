import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:work_mate/Screens/createclassroompage.dart';
import 'package:work_mate/Screens/homepage.dart';
import 'package:work_mate/Screens/loginpage.dart';
import 'package:work_mate/Screens/signuppage.dart';
import 'package:work_mate/Screens/classroompage.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.cyan,
        accentColor: Colors.cyan,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.black,
            primary: Colors.cyan,
          ),
        ),
        primaryTextTheme: Typography.blackCupertino,
      ),
      routes: <String, WidgetBuilder>{
        '/landingpage': (BuildContext context) => new LandingPage(),
        '/loginpage': (BuildContext context) => new LoginPage(),
        '/signuppage': (BuildContext context) => new SignUp(),
        '/homepage': (BuildContext context) => new HomePage(),
        '/createclassroompage': (BuildContext context) => new CreateClassRoom(),
        '/classroompage': (BuildContext context) => new ClassRoom(),
      },
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                User user = snapshot.data;
                if (user == null) {
                  return LoginPage();
                } else {
                  return HomePage();
                }
              }
              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication..."),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connecting to the app..."),
          ),
        );
      },
    );
  }
}