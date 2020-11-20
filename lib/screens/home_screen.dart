import 'package:flutter/material.dart';
import 'package:kishor/components/SearchBar.dart';
import 'main_drawer.dart';

class HomeScreen extends StatelessWidget {
  static const routename='/home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text('mokshya home screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: ()
            {
              SearchBarDemoApp();
            },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: SafeArea(
        child: Center(
          child: Text(
            'This is Mokshya Home Screen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
