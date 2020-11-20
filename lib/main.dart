
import 'package:flutter/material.dart';
import 'package:kishor/screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'package:provider/provider.dart';
import 'models/authentication.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Authentication())
      ],
      child: MaterialApp(
        title: 'Mokshya Login',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
        home:LoginScreen(),
        routes: {
        SignUpScreen.routename:(ctx)=>SignUpScreen(),
          LoginScreen.routename:(ctx)=>LoginScreen(),
          HomeScreen.routename:(ctx)=>HomeScreen(),
        },
      ),
    );
  }
}
