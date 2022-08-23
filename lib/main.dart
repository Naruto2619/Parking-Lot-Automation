import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:parking_lot/Models/user.dart';
import 'package:parking_lot/Screens/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:parking_lot/Screens/UserScreen.dart';
import './Screens/AdminScreen.dart';
import 'Screens/ParkingScreen.dart';
import 'Screens/PaymentScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var onAuthStateChanged;
    return MaterialApp(
      routes: {
        "homepage": (ctx) => UserScreen(),
        "adminpage": (ctx) => AdminScreen(),
        'parking': (ctx) => ParkingScreen(),
        'payment': (ctx) => PaymentScreen()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthScreen(),
    );
  }
}
