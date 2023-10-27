import 'package:appcatering/tabsorderpage/snack_list_tile.dart';

class Order {
  final String menuName;
  final int menuPrice;
  final String menuDescription;
  final String selectedRoom;
  final List<Snack> selectedSnacks;
  final int totalHarga;
  final String orderType;

  Order({
    required this.menuName,
    required this.menuPrice,
    required this.menuDescription,
    required this.selectedRoom,
    required this.selectedSnacks,
    required this.totalHarga,
    required this.orderType,
  });

  // Konversi objek Order menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'menuName': menuName,
      'menuPrice': menuPrice,
      'menuDescription': menuDescription,
      'selectedRoom': selectedRoom,
      'selectedSnacks': selectedSnacks.map((snack) => snack.toJson()).toList(),
      'totalHarga': totalHarga,
      'orderType': orderType,
    };
  }

  // Konversi Map menjadi objek Order
  factory Order.fromJson(Map<String, dynamic> json) {
    final List<dynamic> snackListJson = json['selectedSnacks'];
    final List<Snack> snackList = snackListJson
        .map((snackJson) => Snack.fromJson(snackJson))
        .toList()
        .cast<Snack>();
    return Order(
      menuName: json['menuName'],
      menuPrice: json['menuPrice'],
      menuDescription: json['menuDescription'],
      selectedRoom: json['selectedRoom'],
      selectedSnacks: snackList,
      totalHarga: json['totalHarga'],
      orderType: json['orderType'],
    );
  }
}
