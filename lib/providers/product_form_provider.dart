import 'package:flutter/cupertino.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{

  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

 updateAvailibylity(bool value){
    print(value);
    this.product.available = value;
    notifyListeners();

  }

  ProductFormProvider(this.product);

  bool isValidForm(){

    print(product.name);
    print(product.price);
    print(product.available);

    return formKey.currentState?.validate() ?? false;
  }


}