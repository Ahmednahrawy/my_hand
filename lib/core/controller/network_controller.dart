import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _streamSubscription;
  var isDeviceConnected = false;

  @override
  void onInit() {
    super.onInit();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> connectivityResult) async {
    if (connectivityResult.contains(ConnectivityResult.none)) {
      isDeviceConnected = await DataConnectionChecker().hasConnection;
      if (!isDeviceConnected) {
        Get.rawSnackbar(
            messageText: const Text(
              "No internet connection at the moment",
              style:
                  TextStyle(color: Color.fromARGB(255, 39, 1, 1), fontSize: 14),
            ),
            isDismissible: false,
            duration: const Duration(days: 1),
            backgroundColor: const Color.fromRGBO(239, 83, 80, 0.3),
            icon: const Icon(
              Icons.wifi_off,
              color: Color.fromARGB(255, 46, 1, 1),
              size: 35,
            ),
            margin: EdgeInsets.zero,
            borderRadius: 8.0,
            snackStyle: SnackStyle.FLOATING);
      } else {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
      }
    } else {
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
    }
  }
}
