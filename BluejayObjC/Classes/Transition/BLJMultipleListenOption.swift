//
//  BLJMultipleListenOption.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

/// Ways to handle calling listen on the same characteristic multiple times.
@objc
public enum BLJMultipleListenOption: Int {
    /// New listen and its new callback on the same characteristic will not overwrite an existing listen.
    case trap = 0
    /// New listens and its new callback on the same characteristic will replace the existing listen.
    case replaceable = 1
}
