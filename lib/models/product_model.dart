class ProductModel {
  // static const ID = "id";
  // static const IMAGE = "image";
  // static const NAME = "name";
  // static const BRAND = "brand";
  // static const PRICE = "price";

  int id;
  // int quantity;
  String image;
  String title;
  String description;
  num price;

  ProductModel({this.id, this.image, this.description, this.title, this.price});

  ProductModel.fromJson(Map<String, dynamic> data)
      : title = data['title'],
        id = data['id'],
        description = data['description'],
        price = data['price'],
        image = data['image'];


// void toggleDone() {
//     quantity++;
//   }

//   void decreaseDown() {
//     quantity == 0 ? 0 : quantity--;
//   }
}
