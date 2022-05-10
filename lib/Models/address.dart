class Address {
  String? streetName;
  String? houseNo;
  int? postalCode;
  String? city;
  String? country;

  Address(
      {this.city,
      this.country,
      this.houseNo,
      this.postalCode,
      this.streetName});

  factory Address.fromMap(map) {
    return Address(
        streetName: map['streetName'],
        houseNo: map['houseNo'],
        city: map['city'],
        country: map['country'],
        postalCode: map['postalCode']);
  }

  Map<String, dynamic> toMap() {
    return {
      'streetName': streetName,
      'houseNo': houseNo,
      'postalCode': postalCode,
      'city': city,
      'country': country,
    };
  }
}
