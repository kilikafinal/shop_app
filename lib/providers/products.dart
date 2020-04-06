import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/models/http_exception.dart';
import 'package:shopapp/providers/Product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];
  String authToken;
  String userId;

  Products(this.authToken, this.userId, this._items);

  List<Product> get items {
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Future<void> fetchAndSetProducts([bool filterByUser= false]) async {
    final filterString = filterByUser? 'orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        "https://fluter-db.firebaseio.com/products.json?auth=$authToken&$filterString";
    try {
      final response = await http.get(url);
      print(json.decode(response.body));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favoriteUrl =
          'https://fluter-db.firebaseio.com/userFavorites/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(favoriteUrl);
      final favoriteData = jsonDecode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((key, value) {
        loadedProducts.add(new Product(
          id: key,
          title: value["title"],
          description: value["description"],
          price: value["price"],
          imageUrl: value["imageUrl"],
          isFavorite: favoriteData == null ? false : favoriteData[key] ?? false,
        ));
      });
      _items = loadedProducts;
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Product product) async {
    final url =
        "https://fluter-db.firebaseio.com/products.json?auth=$authToken";
    try {
      final response = await http.post(
        url,
        body: json.encode({
          "title": product.title,
          "description": product.description,
          "imageUrl": product.imageUrl,
          "price": product.price,
          "creatorId": userId,
        }),
      );

      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)["name"],
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateProduct(Product product) {
    final prodIndex = _items.indexWhere((element) => element.id == product.id);
    if (prodIndex >= 0) {
      final url =
          "https://fluter-db.firebaseio.com/products/${product.id}.json?auth=$authToken";
      http.patch(url,
          body: json.encode({
            "title": product.title,
            "description": product.description,
            "imageUrl": product.imageUrl,
            "price": product.price,
          }));
      _items[prodIndex] = product;
      notifyListeners();
    } else {
      print("Couldnt find ID for product to update");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://fluter-db.firebaseio.com/products/$id.json?auth=$authToken";
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode > 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException("Could not delete product");
    }
    existingProduct = null;
  }
}
