class Cart {
  int id;
  // int quantity;
  String image;
  String title;
  String description;
  num price;

  Cart({this.id, this.image, this.description, this.title, this.price});

  Cart.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        id = data['id'],
        description = data['description'],
        price = data['price'],
        image = data['image'];
}
