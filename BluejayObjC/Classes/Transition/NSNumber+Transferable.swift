//
//  NSNumber+Transferable.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

public func data(value: Int8) -> Data { return value.toBluetoothData() }
public func data(value: Int16) -> Data { return value.toBluetoothData() }
public func data(value: Int32) -> Data { return value.toBluetoothData() }
public func data(value: Int64) -> Data  { return value.toBluetoothData() }
public func data(value: UInt8) -> Data { return value.toBluetoothData() }
public func data(value: UInt16) -> Data { return value.toBluetoothData() }
public func data(value: UInt32) -> Data  { return value.toBluetoothData() }
public func data(value: UInt64) -> Data { return value.toBluetoothData() }
