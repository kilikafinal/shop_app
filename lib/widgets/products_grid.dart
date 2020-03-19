import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';

import 'product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context).items;
    return GridView.builder(
      padding: EdgeInsets.all(10),
      itemCount: productsData.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider(

        create: (BuildContext context) { return productsData[index]; },
        child: ProductItem(
//          id: productsData[index].id,
//          title: productsData[index].title,
//          imageUrl: productsData[index].imageUrl,
        ),
      ),
    );
  }
}
