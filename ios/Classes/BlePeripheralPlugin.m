#import "BlePeripheralPlugin.h"
#if __has_include(<ble_peripheral/ble_peripheral-Swift.h>)
#import <ble_peripheral/ble_peripheral-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "ble_peripheral-Swift.h"
#endif

@implementation BlePeripheralPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftBlePeripheralPlugin registerWithRegistrar:registrar];
}
@end
