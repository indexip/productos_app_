import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ProductImage extends StatelessWidget {

final String? url;

  const ProductImage({super.key, this.url});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
      ),
      child: Container(
          decoration: _buildBoxDecoration(),
          width: double.infinity,
          height: 400,
          child:  Opacity(
            opacity: 0.8,
            child: ClipRRect(
              borderRadius:const  BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              child:this.url== null? const Image(image: AssetImage('assets/no-image.png')) : FadeInImage(
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(this.url!),
                fit: BoxFit.cover,
              ),
            ),
          )),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          boxShadow: [
            BoxShadow(color: Colors.black, blurRadius: 10, offset: Offset(0, 5))
          ]);
}
