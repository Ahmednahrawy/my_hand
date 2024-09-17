import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('موردين'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: itemBuilder),
      ),
    );
  }
}
