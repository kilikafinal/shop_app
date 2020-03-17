import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({this.id, this.title, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: Image.network(imageUrl),
        footer: GridTileBar(
          backgroundColor: Colors.black12,
          leading: IconButton(
            icon: Icon(Icons.favorite, color: Theme.of(context).accentColor,),
            onPressed: () {},
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(color: Theme.of(context).textTheme.headline6.color),
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart, color: Theme.of(context).accentColor,),
            onPressed: () {},
          ),
        ),
      ),
    );
  }
}
