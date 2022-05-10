import 'package:smazee_task/Models/address.dart';

class UserModel {
  String? uid;
  String? name;
  int? age;
  Address? address;
  String? email;
  int? number;

  UserModel({this.uid, this.name, this.address, this.age, this.email,this.number});

  // ignore: empty_constructor_bodies
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      age: map['age'],
      email: map['email'],
      number: map['number'],
      address: Address.fromMap(map['address'])
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'age': age,
      'email': email,
      'number': number,
      'address': address!.toMap(),
    };
  }
}
