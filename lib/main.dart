import 'package:flutter/material.dart';
import 'package:shopapp/screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
      ),
      home: ProductsOverviewScreen(),
    );
  }
}