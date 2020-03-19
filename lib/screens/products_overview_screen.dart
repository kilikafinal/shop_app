import 'package:flutter/material.dart';
import 'package:shopapp/providers/Product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
      ),
      body: ProductsGrid(),
    );
  }
}
