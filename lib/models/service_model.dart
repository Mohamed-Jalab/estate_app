class ServiceModel {
  final int id;
  final String name;
  final num price;

  ServiceModel({required this.id, required this.name, required this.price});

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      ServiceModel(id: json["id"], name: json["name"], price: json["price"]);

  Map<String, dynamic> toJson() => {"name": name, "price": price};
}
