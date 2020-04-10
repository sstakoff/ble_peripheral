import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ble_peripheral/ble_peripheral.dart';

void main() {
  const MethodChannel channel = MethodChannel('ble_peripheral');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BlePeripheral.platformVersion, '42');
  });
}
