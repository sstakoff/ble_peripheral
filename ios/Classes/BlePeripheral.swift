//
//  Peripheral.swift
//  ble_peripheral
//
//  Created by Stu Stakoff on 4/10/20.
//

import Foundation
import CoreBluetooth


@available(iOS 10.0, *)
class BlePeripheral : NSObject, CBPeripheralManagerDelegate {
    
    var _peripheralManager: CBPeripheralManager!
    var _poweredOn: Bool = false
    
    override init() {
        super.init()
        _peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if (_peripheralManager.state == CBManagerState.poweredOn) {
            _poweredOn = true
        }
        
        SwiftBlePeripheralPlugin.channel?.invokeMethod("peripheralManagerDidUpdateState", arguments: _peripheralManager.state.rawValue)
    }
    
    func addService(serviceUUID SUUID: String, characteristicUUID CUUID: String, characteristicValue val: String) {
    
        let svc: CBMutableService = CBMutableService(type: CBUUID(string: SUUID), primary: true)
        let ch: CBMutableCharacteristic = CBMutableCharacteristic(type: CBUUID(string: CUUID), properties: .read, value: val.data(using: .utf8), permissions: .readable)
        svc.characteristics = [ch]
        _peripheralManager.add(svc)
    }
    
    func peripheralManager(_ peripheral: CBPeripheralManager, didAdd service: CBService, error: Error?) {
        if ((error) != nil) {
            print("Error adding service: " + error.debugDescription)
        } else {
            print("Added service: " + service.uuid.uuidString)
            _peripheralManager.startAdvertising([CBAdvertisementDataServiceUUIDsKey: [service.uuid]])
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        print("Now Advertising")
    }
    
    
}
