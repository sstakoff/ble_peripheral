import 'dart:async';

import 'package:flutter/services.dart';

enum BleState {
  Unknown,         //0
  Resetting,       //1
  Unsupported,     //2
  Unauthorized,    //3
  PoweredOff,      //4
  PoweredOn        //5
}

class BlePeripheral {

  StreamController<BleState> _peripheralManagerStateController;

  BlePeripheral() {
    _peripheralManagerStateController = StreamController<BleState>.broadcast();
    configMethodHandler();
  }

  static const MethodChannel _channel =
      const MethodChannel('ble_peripheral');

  static Future<bool> addService({String serviceId, String characteristicId, String value}) async {
    final bool res = await _channel.invokeMethod('addService',
      {
        'serviceId': serviceId,
        'characteristicId': characteristicId,
        'value': value
      }
    );
    return res;
  }

  Stream<BleState> get peripheralManagerState => _peripheralManagerStateController.stream;


  configMethodHandler() {
    _channel.setMethodCallHandler((call) async {
      print('Got a call: ${call.method}');
      switch (call.method) {
        case 'peripheralManagerDidUpdateState':
          int state = call.arguments;
          if (_peripheralManagerStateController.hasListener)
            _peripheralManagerStateController.add(BleState.values[state]);
          break;
        default:
          print('Unknown method: ${call.method}');
      }

    });
  }
}
