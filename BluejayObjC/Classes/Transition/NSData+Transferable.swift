//
//  NSData+Transferable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

extension NSData: BLJSendable, BLJReceivable {
    
    public func toBluetoothData() -> Data {
        return (self as Data).toBluetoothData()
    }
    
    public static func from(bluetoothData: Data) -> Self? {
        return Data(bluetoothData: bluetoothData) as? Self
    }
}

@objc extension NSData {
    
    public var uint8: UInt8 { UInt8(bluetoothData: self as Data) }
    public var uint16: UInt16 { UInt16(bluetoothData: self as Data) }
    public var uint32: UInt32 { UInt32(bluetoothData: self as Data) }
    public var uint64: UInt64 { UInt64(bluetoothData: self as Data) }
    
    public var int8: Int8 { Int8(bluetoothData: self as Data) }
    public var int16: Int16 { Int16(bluetoothData: self as Data) }
    public var int32: Int32 { Int32(bluetoothData: self as Data) }
    public var int64: Int64 { Int64(bluetoothData: self as Data) }
    
    public static func uint8(_ value: UInt8) -> Data { value.toBluetoothData() }
    public static func uint16(_ value: UInt16) -> Data { value.toBluetoothData() }
    public static func uint32(_ value: UInt32) -> Data { value.toBluetoothData() }
    public static func uint64(_ value: UInt64) -> Data { value.toBluetoothData() }
    
    public static func int8(_ value: Int8) -> Data { value.toBluetoothData() }
    public static func int16(_ value: Int16) -> Data { value.toBluetoothData() }
    public static func int32(_ value: Int32) -> Data { value.toBluetoothData() }
    public static func int64(_ value: Int64) -> Data { value.toBluetoothData() }
}
