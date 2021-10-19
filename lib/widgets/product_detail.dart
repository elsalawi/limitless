import 'package:flutter/material.dart';
import 'package:limitless/models/cart_model.dart';
import 'package:limitless/models/product_model.dart';
import 'package:limitless/providers/product_provider.dart';
import 'package:limitless/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class productDetail extends StatelessWidget {
  final ProductModel product;
  final int index;

  productDetail({Key key, this.product, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final productpro = Provider.of<ProductProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () {
          productpro.addToCart(
            Cart(
                id: productpro.products[index].id,
                image: productpro.products[index].image,
                price: productpro.products[index].price,
                title: productpro.products[index].title),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: productpro.isfound
                  ? Text("Item Already Added to cart ")
                  : Text("Item  Added to cart successfully ")));
        },
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 400,
                  child: Image.network(
                    product.image,
                    width: double.infinity,
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
                  ),
                ),
              ),
              CustomText(
                text: product.title,
                size: 18,
                weight: FontWeight.bold,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  CustomText(
                    text: "Description",
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                  Spacer(),
                  CustomText(
                    text: "\$${product.price}",
                    size: 25,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
              CustomText(
                text: product.description,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
