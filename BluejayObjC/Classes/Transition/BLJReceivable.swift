//
//  BLJReceivable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

/// Protocol to indicate that a type can be received from the Bluetooth connection.
@objc
public protocol BLJReceivable: NSObjectProtocol {
    
    /**
     A place to implement your deserialization logic.
     
     - Parameter bluetoothData: The data received over Bluetooth and needing to be deserialized.
     */
    static func from(bluetoothData: Data) -> Self?
}
