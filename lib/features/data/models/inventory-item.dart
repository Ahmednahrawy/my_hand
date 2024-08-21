import 'package:my_hand/features/data/models/sales/customer.dart';
import 'package:my_hand/features/data/models/supply/client.dart';

class InventoryItem {
  final String name;
  final int quantity;
  final double cost;
  final Client? supplier;
  final Customer? customer;
  final int minOQ;
  // Optionally, consider adding
  // - image asset

  InventoryItem(
    this.minOQ, {
    required this.name,
    required this.quantity,
    required this.cost,
    this.supplier,
    this.customer,
  });
}
