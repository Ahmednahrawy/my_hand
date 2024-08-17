import 'package:my_hand/features/data/models/sales/order.dart';

class Customer {
  final String name;
  final String contactInfo;
  final List<Order> orders;
  final String address;
  final String emailAddress;
  final String notes;

  Customer(
    this.address,
    this.emailAddress,
    this.notes, {
    required this.name,
    required this.contactInfo,
    this.orders = const [],
  });
}
