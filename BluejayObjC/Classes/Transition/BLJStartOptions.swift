//
//  BLJStartOptions.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objcMembers
public final class BLJStartOptions: NSObject {
    
    /// Whether to show an iOS system alert when Bluetooth is turned off while the app is still running in the background.
    public var enableBluetoothAlert: Bool
    
    /**
     * Configurations for starting Bluejay.
     *
     * - Parameters:
     *    - enableBluetoothAlert: whether to show an iOS system alert when Bluetooth is turned off while the app is still running in the background.
     */
    public init(enableBluetoothAlert: Bool) {
        self.enableBluetoothAlert = enableBluetoothAlert
    }
    
    /// Convenience factory method to avoid having to use the public initializer.
    public static var `default`: BLJStartOptions {
        return BLJStartOptions(enableBluetoothAlert: false)
    }
}

extension BLJStartOptions: LanguageTransferable {
    
    func transfer() -> StartOptions {
        return StartOptions(enableBluetoothAlert: enableBluetoothAlert, backgroundRestore: .disable)
    }
}
