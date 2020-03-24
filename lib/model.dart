class CompanyModel {
  String addressPhone;
  String category;
  String description;
  int id;
  String image;
  String latitude;
  String longitude;
  String name;
  String place;

  CompanyModel(
      {this.addressPhone,
      this.category,
      this.description,
      this.id,
      this.image,
      this.latitude,
      this.longitude,
      this.name,
      this.place});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    addressPhone = json['address_phone'];
    category = json['category'];
    description = json['description'];
    id = json['id'];
    image = json['image'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    name = json['name'];
    place = json['place'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_phone'] = this.addressPhone;
    data['category'] = this.category;
    data['description'] = this.description;
    data['id'] = this.id;
    data['image'] = this.image;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['name'] = this.name;
    data['place'] = this.place;
    return data;
  }
}
