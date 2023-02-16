//
//  NSString+Transferable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

extension NSString: BLJSendable, BLJReceivable {
    
    public func toBluetoothData() -> Data {
        return (self as String).toBluetoothData()
    }
    
    public static func from(bluetoothData: Data) -> Self? {
        return String(bluetoothData: bluetoothData) as? Self
    }
}
