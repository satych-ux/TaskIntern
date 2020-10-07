import 'package:flutter/material.dart';
import 'package:teacher_panel/screens/addplayerform.dart';
import 'package:teacher_panel/screens/home.dart';
import 'package:teacher_panel/screens/login_screen.dart';
// import 'package:shopapp_tut/pages/CategoricalProductScreen.dart';
// import 'package:shopapp_tut/pages/home.dart';

// import 'package:shopapp_tut/pages/welcome_screen.dart';
// import 'package:shopapp_tut/pages/login_screen.dart';
// import 'package:shopapp_tut/pages/registration_screen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoginScreen(),
    initialRoute: LoginScreen.id,
    routes: {
      LoginScreen.id: (context) => LoginScreen(),
      // RegistrationScreen.id: (context) => RegistrationScreen(),
      HomePage.id: (context) => HomePage(),
      UpiForm.id: (context) => UpiForm(),
      //  CategoricalProductScreen.id: (context) => CategoricalProductScreen(),
    },
  ));
}
