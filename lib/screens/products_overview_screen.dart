import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/Product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/products_grid.dart';

enum FilterOptions {
  FILTER,
  ALL,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _showOnlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Shop"),
        actions: <Widget>[
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onSelected: (selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.FILTER) {
                  _showOnlyFavorites = true;
                }else{
                  _showOnlyFavorites = false;
                }
              });

            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("only Favorites"),
                value: FilterOptions.FILTER,
              ),
              PopupMenuItem(
                child: Text("Show All"),
                value: FilterOptions.ALL,
              )
            ],
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}
