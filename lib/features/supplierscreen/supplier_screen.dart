import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SupplierScreen extends StatefulWidget {
  const SupplierScreen({Key? key}) : super(key: key);

  @override
  State<SupplierScreen> createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  String _data = "";
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  var url = Uri.parse(baseUrl);

  void _showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
    );
  }

  Future<void> _updateData(
    http.Response response,
    String successMessage,
    String failureMessage,
  ) async {
    print(response.statusCode);
    setState(() {
      if (response.statusCode == 200 || response.statusCode == 201) {
        _data = response.body;
        print(successMessage);
        _showToast(successMessage);
      } else {
        _data = failureMessage;
        print(failureMessage);
        _showToast(failureMessage);
      }
    });
  }

  Future<void> fetchData() async {
    try {
      var response = await http.get(url);
      _updateData(response, 'Data fetched', 'Failed to fetch');
    } catch (e) {
      _updateData(
          http.Response('Failed', 500), 'Failed to fetch', 'Failed to fetch');
    }
  }

  Future<void> createData() async {
    try {
      var response = await http.post(url, body: {
        'title': 'nahrawy',
        'body': 'ahmed',
        'userId': '1',
      });
      _updateData(response, 'Data created', 'Failed to create');
    } catch (e) {
      _updateData(
          http.Response('Failed', 500), 'Failed to create', 'Failed to create');
    }
  }

  Future<void> deleteData() async {
    try {
      const String baseUrl = 'https://jsonplaceholder.typicode.com/posts/1';
      var uri = Uri.parse(baseUrl);
      var response = await http.delete(uri);
      _updateData(response, 'Data deleted', 'Failed to delete');
    } catch (e) {
      _updateData(
          http.Response('Failed', 500), 'Failed to delete', 'Failed to delete');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('عملاء'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Center(
          child: Column(
            children: [
              Wrap(
                children: [
                  ElevatedButton(
                      onPressed: fetchData, child: const Text('fetch')),
                  ElevatedButton(
                      onPressed: createData, child: const Text('create')),
                  ElevatedButton(
                      onPressed: deleteData, child: const Text('delete')),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_data),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
