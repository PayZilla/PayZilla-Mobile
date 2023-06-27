import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class NetworkManager extends ChangeNotifier {
  NetworkManager(Connectivity connectivity) : _connectivity = connectivity;
  final Connectivity _connectivity;

  Future<bool> hasNetwork() async {
    try {
      final netInfo = await _connectivity.checkConnectivity();
      notifyListeners();
      return !(netInfo == ConnectivityResult.none);
    } catch (e) {
      return false;
    }
  }
}
