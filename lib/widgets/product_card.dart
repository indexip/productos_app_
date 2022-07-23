import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductCard extends StatelessWidget {

  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorder(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            BackgroundImage(product: product,),
            _ProductoDetails(product: product),
            Positioned(top: 0, right: 0, child: _PriceTag(price: product.price,)),

            //TODO: mostrar de forma condicional
            if(!product.available)
            Positioned(top: 0, left: 0, child: _NotAvalible())
          ],
        ),
        //color: Colors.red,
      ),
    );
  }

  BoxDecoration _cardBorder() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)
          ]);
}

class _NotAvalible extends StatelessWidget {
  

   
  _NotAvalible({super.key});
  @override
  Widget build(BuildContext context) {
  

    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('No disponible',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
          color: Colors.yellow[700],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
    );
  }
}

class _PriceTag extends StatelessWidget {

  final double price;
  const _PriceTag({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      child:  FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child:  Text('\$$price',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
          color: Colors.indigo,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20), topRight: Radius.circular(20))),
    );
  }
}

class _ProductoDetails extends StatelessWidget {

  final Product product;  

  const _ProductoDetails({super.key, required this.product});@override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 70,
        //color: Colors.indigo,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(product.name,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(product.id!,
              style:const  TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.indigo,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20), topRight: Radius.circular(20)));
}

class BackgroundImage extends StatelessWidget {
  final Product product;
  String url = "https://via.placeholder.com/400x300/f6f6f6";
   BackgroundImage({
    Key? key, required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(product.picture !=null){
      url = product.picture.toString();
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 300,
        //color: Colors.red,
        child: FadeInImage(
          placeholder: AssetImage('assets/jar-loading.gif'),
          image: NetworkImage(url),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
