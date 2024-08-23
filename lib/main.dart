import 'package:flutter/material.dart';
import 'package:my_hand/config/routes/app_router.dart';
import 'package:my_hand/my_app.dart';

void main() async {
  runApp(MyApp(
    appRouter: AppRouter(),
  ));
}
