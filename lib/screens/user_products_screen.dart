import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/user_product_item.dart';

import 'edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const String routeName = "/userProductsScreen";

  Future<void> _refreshProducts(BuildContext context) async{

   await Provider.of<Products>(context).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text("Your Products"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (ctx, i) => Column(
              children: <Widget>[
                UserProductItem(
                    id: productData.items[i].id,
                    title: productData.items[i].title,
                    imageUrl: productData.items[i].imageUrl),
                Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
