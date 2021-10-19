import 'package:flutter/material.dart';
import 'package:limitless/models/product_model.dart';
import 'package:limitless/pages/products_cart_screen.dart';
import 'package:limitless/providers/product_provider.dart';
import 'package:limitless/widgets/productCard.dart';
import 'package:limitless/widgets/product_detail.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: new AppBar(
        actions: <Widget>[
          new Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Container(
                height: 150.0,
                width: 30.0,
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => cartScreen()));
                      },
                    ),
                    product.cartproducts.length == 0
                        ? new Container()
                        : new Positioned(
                            child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.green[800]),
                              new Positioned(
                                  top: 3.0,
                                  right: 4.0,
                                  child: new Center(
                                    child: new Text(
                                      product.cartproducts.length.toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                  ],
                )),
          )
        ],
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: product.productLoader
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 2.0,
                  crossAxisSpacing: 0,
                  childAspectRatio: .65),
              itemCount: product.products.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => productDetail(
                                index: index,
                                product: ProductModel(
                                    image: product.products[index].image,
                                    description:
                                        product.products[index].description,
                                    price: product.products[index].price,
                                    title: product.products[index].title),
                              )));
                    },
                    child: card(context, index));
              },
            ),
    );
  }
}
