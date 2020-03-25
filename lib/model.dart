final phoneRegex = RegExp(r'\(?\+[0-9]+\)?([0-9]| )*');

class CompanyModel {
  String id, name, city, address, phone, category, description, image;
  String get addressOrCity =>
      (address != null) ? address : ((city != null) ? city : '');

  CompanyModel.fromJson(Map<String, dynamic> json) {
    name = json['id'].toString();
    name = json['name'];
    city = json['place'];
    address = _parseAddress(json['address_phone']);
    phone = _parsePhone(json['address_phone']);
    category = json['category'];
    description = json['description'];
    image = json['image'];
  }

  String _parseAddress(String addressPhone) {
    if (addressPhone == null) return null;

    var address = addressPhone.replaceAll(phoneRegex, '').trim();
    return address.isEmpty ? null : address;
  }

  String _parsePhone(String addressPhone) {
    // 3991 Avenida 24 Julho +258 86 163 9134
    if (addressPhone == null) return null;

    var match = phoneRegex.firstMatch(addressPhone);
    return (match != null)
        ? addressPhone.substring(match.start, match.end)
        : null;
  }

  @override
  String toString() => this.name;
}
