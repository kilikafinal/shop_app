import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:shopapp/providers/products.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Products(),
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.orange,
          fontFamily: "Lato",
          textTheme: TextTheme(headline6: TextStyle(color: Colors.black)),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName:  (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}