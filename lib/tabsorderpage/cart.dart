import 'package:appcatering/tabsorderpage/order.dart';

class Cart {
  List<Order> orders = [];

  void addToCart(Order order) {
    orders.add(order);
  }

  void removeFromCart(Order order) {
    orders.remove(order);
  }
}
