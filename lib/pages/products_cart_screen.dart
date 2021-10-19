import 'package:flutter/material.dart';
import 'package:limitless/providers/product_provider.dart';
import 'package:provider/provider.dart';

class cartScreen extends StatefulWidget {
  cartScreen({Key key}) : super(key: key);

  @override
  _cartScreenState createState() => _cartScreenState();
}

class _cartScreenState extends State<cartScreen> {
  @override
  void initState() {
    final product = Provider.of<ProductProvider>(context, listen: false);
    product.getCartTotal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Products Cart"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.blueGrey)),
                height: 500.0,
                child: ListView.builder(
                  itemCount: product.cartproducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.topLeft,
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12, blurRadius: 5.0)
                                ],
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      product.cartproducts[index].image),
                                  fit: BoxFit.fill,
                                )),
                          ),
                          Expanded(
                              child: Padding(
                            padding: EdgeInsets.only(top: 10.0, left: 15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        product.cartproducts[index].title,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.bottomRight,
                                      child: InkResponse(
                                        onTap: () {
                                          product.removeCart(index);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Item removed from cart successfully")));
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: Icon(
                                            Icons.remove_shopping_cart,
                                            color: Colors.red[300],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Price: \$${product.cartproducts[index].price.toString()}"),
                              ],
                            ),
                          ))
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
                child: Container(
                    child: Text(
              'Total: \$${product.cartTotal.toString()}',
              style: TextStyle(fontSize: 25),
            ))),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueGrey)),
                child: TextButton(
                  child: Text(
                    'proceed',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
