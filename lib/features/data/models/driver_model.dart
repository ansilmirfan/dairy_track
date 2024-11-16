class DriverModel {
  String id;
  String name;
  String userName;
  String password;
  int phoneNumber;
  String licenceNumber;

  String route;
 
  DriverModel(
      {required this.id,
      required this.name,
      required this.userName,
      required this.password,
      required this.licenceNumber,
      required this.phoneNumber,
      required this.route,
     });
  static Map<String, dynamic> toMap(DriverModel driver) {
    return {
      'id': driver.id,
      'name': driver.name,
      'user name': driver.userName,
      'password': driver.password,
      'phone number': driver.phoneNumber,
      'licence number': driver.licenceNumber,
      'route': driver.route,
     
    };
  }

  factory DriverModel.fromMap(Map<String, dynamic> map) {
    return DriverModel(
        id: map['id'],
        name: map['name'],
        userName: map['user name'],
        password: map['password'],
        licenceNumber: map['licence number'],
        phoneNumber: map['phone number'],
        route: map['route'],
       );
  }
}
