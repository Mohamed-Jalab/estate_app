class EstateModel {
  int id;
  int userId;
  String title;
  String image;
  String description;
  num price;
  String address;
  double lat;
  double lon;
  num area;
  String listingType;
  String estateType;
  String status;
  int roomsCount;
  num rateAvg;
  String? username;
  String? phone;
  List<Map<String, dynamic>> comments;
  EstateModel(
      {required this.id,
      required this.userId,
      required this.title,
      required this.image,
      required this.description,
      required this.price,
      required this.address,
      required this.lat,
      required this.lon,
      required this.area,
      required this.listingType,
      required this.estateType,
      required this.status,
      required this.roomsCount,
      required this.rateAvg,
      required this.comments,
      this.username,
      this.phone});
  factory EstateModel.fromJson(Map<String, dynamic> json) => EstateModel(
        comments: [],
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        image: json["image"],
        description: json["description"],
        price: json["price"],
        address: json["address"],
        lat: json["location"]["lat"],
        lon: json["location"]["lon"],
        area: json["area"],
        listingType: json["listing_type"],
        estateType: json["estate_type"],
        status: json["status"],
        roomsCount: json["other_data"]["rooms_count"],
        rateAvg: json["rate_avg"],
        username: json["user"]?["name"],
        phone: json["user"]?["phone"],
      );
}
