import Flutter
import UIKit

@available(iOS 10.0, *)
public class SwiftBlePeripheralPlugin: NSObject, FlutterPlugin {
    
    static var channel: FlutterMethodChannel?
    
    var peripheral: BlePeripheral!
    
    public override init() {
        super.init()
        peripheral = BlePeripheral()
    }
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    channel = FlutterMethodChannel(name: "ble_peripheral", binaryMessenger: registrar.messenger())
    let instance = SwiftBlePeripheralPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel!)
    
    
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let map = call.arguments as? Dictionary<String, Any>

    switch (call.method) {
    case "addService":
        let serviceId = map?["serviceId"] as! String
        let characteristicId = map?["characteristicId"] as! String
        let value = map?["value"] as! String

        peripheral.addService(serviceUUID: serviceId, characteristicUUID: characteristicId, characteristicValue: value)
        result(true)
        break
    default:
        break
        
    }
  }
}
