import 'dart:convert';
List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    required this.products,
  });
Products products;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        products: Products.fromJson(json["products"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products.toJson(),
      };
}
class Products {
  Products({
    required this.items,
  });

  List<Item> items;

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.id,
    required this.name,
    required this.sku,
    required this.price,
    required this.image,
  });

  int id;
  String name;
  String sku;
  Price price;
  Image image;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        name: json["name"],
        sku: json["sku"],
        price: Price.fromJson(json["price"]),
        image: Image.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "sku": sku,
        "price": price.toJson(),
        "image": image.toJson(),
      };
}

class Image {
  Image({
    required this.url,
  });

  String url;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}

class Price {
  Price({
    required this.regularPrice,
  });

  RegularPrice regularPrice;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
        regularPrice: RegularPrice.fromJson(json["regularPrice"]),
      );

  Map<String, dynamic> toJson() => {
        "regularPrice": regularPrice.toJson(),
      };
}

class RegularPrice {
  RegularPrice({
    required this.amount,
  });

  Amount amount;

  factory RegularPrice.fromJson(Map<String, dynamic> json) => RegularPrice(
        amount: Amount.fromJson(json["amount"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount.toJson(),
      };
}

class Amount {
  Amount({
    required this.value,
  });

  int value;

  factory Amount.fromJson(Map<String, dynamic> json) => Amount(
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "value": value,
      };
}