class UserModel {
  int? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? locationText;
  String? latitude;
  String? longitude;
  bool? isActive;
  String? photo;

  UserModel(
      {this.name,
      this.email,
      this.password,
      this.locationText = "Aleppo",
      this.phone,
      this.latitude,
      this.longitude,
      this.isActive,
      this.id,
      this.photo});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json["photo"],
      // latitude: json['location']['lat'],
      // longitude: json['location']['lon'],
      // locationText: json['location_text'],
      // isActive: json['is_active'],
      phone: json['phone']);

  Map<String, String> toJson() => {
        'name': name!,
        'email': email!,
        'password': password.toString(),
        'phone': phone!,
        'location_text': locationText!,
        'location[lat]': latitude.toString(),
        'location[lon]': longitude.toString(),
      };
}

// {
//     "id": 11,
//     "name": "Mohammed",
//     "email": "mohammed123@gmail.com",
//     "photo": "https://razan-estate.mustafafares.com/storage/images/df1314268b5cc876376080daf35f07c92a04087d.png",
//     "location": {
//         "lat": "33.33",
//         "lon": "36.36"
//     },
//     "location_text": "Aleppo",
//     "is_active": null,
//     "phone": "0954802408"
// }