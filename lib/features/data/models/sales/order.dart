import 'package:my_hand/features/data/models/sales/customer.dart';
import 'package:my_hand/features/data/models/inventory-item.dart';

class Order {
  final Customer customer;
  final List<OrderItem> items; // List of ordered items and their quantities
  final DateTime date;
  final double totalAmount;
  final bool isInvoiced; // Indicates if an invoice has been generated

  // Optionally, consider adding
  // - discount
  // - notes

  Order({
    required this.customer,
    required this.items,
    required this.date,
    required this.totalAmount,
    required this.isInvoiced,
  });
}

class OrderItem {
  final InventoryItem item;
  final int quantity;
  final double packageWeight;
  final double price;
  final int numberPackage;

  OrderItem(
    this.packageWeight,
    this.price,
    this.numberPackage, {
    required this.item,
    required this.quantity,
  });
}
