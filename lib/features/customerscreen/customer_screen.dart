import 'package:flutter/material.dart';
import 'package:my_hand/features/orderscreen/ui/widgets/customer_name.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({super.key});

  @override
  State<CustomerScreen> createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> {
  String? _customerName;
  void _handleCustomerSelection(String? customerName) {
    setState(() {
      _customerName = customerName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('موردين'),
      ),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              CustomerNameAutoComplete(
                  onCustomerSelected: _handleCustomerSelection),
              if (_customerName != null && _customerName!.isNotEmpty)
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'تفاصيل العميل:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'الاسم: ${_customerName}',
                            style: TextStyle(fontSize: 16),
                          ),
                          // Add more fields for customer details here
                          // e.g., phone number, address, etc.
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          )),
    );
  }
}
