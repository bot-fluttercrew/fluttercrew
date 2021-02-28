import 'dart:io'; //InternetAddress utility

import 'package:flutter/material.dart';

import 'package:connectivity/connectivity.dart';

import 'package:fluttercrew/fluttercrew.dart';

typedef OnConnectionCallback = void Function(bool hasConnection);

abstract class ConnectionInterface {
  // update the connection state
  Future<void> updateConnection(ConnectivityResult result);
  // The test to actually see if there is a connection
  Future<bool> checkConnection();
}

class ConnectionService implements ConnectionInterface {
  ConnectionService({@required this.onConnectionCallback}) {
    Connectivity().onConnectivityChanged.listen(updateConnection);
  }

  // DEPENDENCIES
  final OnConnectionCallback onConnectionCallback;

  // LOCAL VARIABLES
  bool _previousConnection;

  @override
  Future<void> updateConnection(ConnectivityResult result) async {
    await Future.delayed(const Duration(milliseconds: 100));
    return onConnectionCallback(await checkConnection());
  }

  @override
  Future<bool> checkConnection() async {
    bool hasConnection;
    try {
      final result = await InternetAddress.lookup('delivery.famiglia.com.ua');
      hasConnection = result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      hasConnection = false;
    }

    if (_previousConnection != hasConnection) {
      Utils().logger?.i('Connection changed => $hasConnection');
    }

    return _previousConnection = hasConnection;
  }
}
