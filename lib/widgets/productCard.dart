import 'package:flutter/material.dart';
import 'package:limitless/models/cart_model.dart';
import 'package:limitless/providers/product_provider.dart';
import 'package:provider/provider.dart';
import 'custom_text.dart';

Widget card(BuildContext context, index) {
  final product = Provider.of<ProductProvider>(context);

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(.5),
                offset: Offset(3, 2),
                blurRadius: 7)
          ]),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              product.products[index].image,
              scale: 7,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes
                        : null,
                  ),
                );
              },
              // width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomText(
              text: product.products[index].title,
              size: 18,
              weight: FontWeight.bold,
              fade: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            bottom: 1,
            child: CustomText(
              text: ''
              // product.products[index].title

              ,
              color: Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Positioned(
            bottom: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: CustomText(
                    text: "\$${product.products[index].price.toString()}",
                    size: 22,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                IconButton(
                    icon: Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      product.addToCart(
                        Cart(
                            id: product.products[index].id,
                            image: product.products[index].image,
                            price: product.products[index].price,
                            title: product.products[index].title),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: product.isfound
                              ? Text("Item Already Added to cart ")
                              : Text("Item  Added to cart successfully ")));
                      // img: product.products[index].image,
                      // id: product.products[index].id,
                      // price: product.products[index].price,
                      // title: product.products[index].title

                      // cartController.addProductToCart(product);
                    })
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
