class Product {
  List<dynamic> sellingPoints;
  List<dynamic> images;
  String name;
  Map shop;
  String id;
  String createdAt;
  String updatedAt;

  Product({
    required this.sellingPoints,
    required this.images,
    required this.name,
    required this.shop,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json)
      : sellingPoints = json['sellingPoints'],
        images = json['images'],
        name = json['name'],
        shop = json['shop'],
        id = json['id'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
