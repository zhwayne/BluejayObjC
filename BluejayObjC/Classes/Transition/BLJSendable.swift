//
//  BLJSendable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

/// Protocol to indicate that a type can be sent via the Bluetooth connection.
@objc
public protocol BLJSendable: NSObjectProtocol {
    
    /**
     A place to implement your serialization logic.
     */
    func toBluetoothData() -> Data
}
