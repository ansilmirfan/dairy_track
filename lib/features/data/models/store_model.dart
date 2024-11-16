import 'package:cloud_firestore/cloud_firestore.dart';

class ShopModel {
  String id;
  String name;
  int phoneNumber;
  String place;
  String route;
  GeoPoint location;
  ShopModel(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.location,
      required this.place,
      required this.route});
  factory ShopModel.fromMap(Map<String, dynamic> map) {
    return ShopModel(
        id: map['id'],
        name: map['name'],
        phoneNumber: map['phone number'],
        location: map['location'],
        place: map['place'],
        route: map['route']);
  }
  static Map<String, dynamic> toMap(ShopModel storeModel) {
    return {
      'id': storeModel.id,
      'name': storeModel.name,
      'phone number': storeModel.phoneNumber,
      'place': storeModel.place,
      'route': storeModel.route,
      'location': storeModel.location
    };
  }
}
