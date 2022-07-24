import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:productos_app/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-8ec27-default-rtdb.firebaseio.com';
  final List<Product> products = [];
  late Product selectProduct; 
  bool isLoading = true;
  bool isSalving=false;

  ProductsService() {
    this.loadProducts();
  }

  Future<List<Product>> loadProducts() async {

    this.isLoading= true;
    notifyListeners();

    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productsMap = jsonDecode(resp.body);
    //print(productsMap);

    productsMap.forEach((key, value) { 
      final tempProduct = Product.fromMap(value);
      tempProduct.id=key;
      this.products.add(tempProduct);
    });
    this.isLoading=false;
    notifyListeners();
    
    return this.products;
  }

  Future SaveOrCreateProduct(Product product)async{
    isSalving=true;
    notifyListeners();

    if(product.id== null){
      //crear producto
    }else{
      //actualizar
     await this.updateProduct(product);
    }


    isSalving = false;
    notifyListeners();
  }

  Future<String> updateProduct(Product product)async{
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url, body: product.toJson());
    final decodeData = resp.body;

    print(decodeData);

    final index = products.indexWhere((element) => element.id == product.id);
    this.products[index] = product;

    return product.id!;
  }
}
