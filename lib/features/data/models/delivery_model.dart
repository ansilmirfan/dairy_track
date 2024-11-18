import 'package:dairy_track/core/utils/utils.dart';
import 'package:dairy_track/features/data/models/driver_model.dart';
import 'package:dairy_track/features/data/models/store_model.dart';

class DeliveryModel {
  final String id;
  final DriverModel driver;
  final DateTime date;
  final String route;
  final List<ShopDeliveryModel> shops;
  final double initialStock;
  double remainingStock;
  double deliveredStock;
  DeliveryModel({
    required this.id,
    required this.driver,
    required this.date,
    required this.route,
    required this.initialStock,
    required this.shops,
    this.remainingStock = 0,
    this.deliveredStock = 0,
  });
  factory DeliveryModel.fromMap(
      {required Map<String, dynamic> map,
      required DriverModel driverModel,
      required List<ShopDeliveryModel> shops}) {
    return DeliveryModel(
      id: map['id'],
      driver: driverModel,
      date: Utils.parseDate(map['date']),
      route: map['route'],
      initialStock: map['initial stock'],
      deliveredStock: map['delivered stock'],
      remainingStock: map['remaining stock'],
      shops: shops,
    );
  }

  static Map<String, dynamic> toMap(DeliveryModel model) {
    return {
      'id': model.id,
      'date': Utils.formatDate(model.date),
      'route': model.route,
      'driver': model.driver.id,
      'initial stock': model.initialStock,
      'delivered stock': model.deliveredStock,
      'remaining stock': model.remainingStock,
      'shops': model.shops
          .map((e) => {
                'shop id': e.shopModel.id,
                'status': e.status,
                'delivered quantity': e.deliveredQuantity,
                'date': e.dateTime.toString()
              })
          .toList(),
    };
  }
}

class ShopDeliveryModel {
  ShopModel shopModel;
  double deliveredQuantity;
  String status;
  DateTime? dateTime;
  ShopDeliveryModel({
    required this.shopModel,
    this.deliveredQuantity = 0,
    this.status = 'unknown',
    this.dateTime,
  });
}
