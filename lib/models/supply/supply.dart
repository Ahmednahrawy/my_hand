import 'package:my_hand/models/supply/client.dart';
import 'package:my_hand/models/inventory-item.dart';

class Supply {
  final Client client;
  final List<SupplyItem> items; // List of supplied items and their quantities
  final DateTime date;
  final double totalAmount;
  final bool isInvoiced; // Indicates if an invoice has been generated

  // Optionally, consider adding
  // - discount
  // - notes

  Supply({
    required this.client,
    required this.items,
    required this.date,
    required this.totalAmount,
    required this.isInvoiced,
  });
}

class SupplyItem {
  final InventoryItem item;
  final int quantity;
  final double packageWeight;
  final double price;
  final int numberPackage;  

  SupplyItem(
    this.packageWeight,
    this.price,
    this.numberPackage, {
    required this.item,
    required this.quantity,
  });
}
