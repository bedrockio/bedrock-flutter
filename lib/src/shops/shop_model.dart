class Shop {
  String id;
  String name;
  List<dynamic> images;
  List<dynamic> categories;
  String? owner;
  String createdAt;
  String updatedAt;

  Shop({
    required this.id,
    required this.name,
    required this.images,
    required this.categories,
    this.owner,
    required this.createdAt,
    required this.updatedAt,
  });

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        images = json['images'],
        categories = json['categories'],
        owner = json['owner'] ?? '',
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
