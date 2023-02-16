//
//  BLJConnectionObserver.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objc
public protocol BLJConnectionObserver: NSObjectProtocol {
    
    /// Called whenever Bluetooth availability changes, as well as when an object first subscribes to become a ConnectionObserver.
    @objc optional func bluetoothAvailable(_ available: Bool)
    
    /// Called whenever a peripheral is connected, as well as when an object first subscribes to become a ConnectionObserver and the peripheral is already connected.
    @objc optional func connected(to peripheral: BLJPeripheralIdentifier)
    
    /// Called whenever a peripheral is disconnected.
    @objc optional func disconnected(from peripheral: BLJPeripheralIdentifier)
}

final class ConnectionObserverWrapper
: ObserverWrapper<BLJConnectionObserver>
, ConnectionObserver {
    
    func bluetoothAvailable(_ available: Bool) {
        object?.bluetoothAvailable?(available)
    }
    
    func connected(to peripheral: PeripheralIdentifier) {
        object?.connected?(to: peripheral.transfer())
    }
    
    func disconnected(from peripheral: PeripheralIdentifier) {
        object?.disconnected?(from: peripheral.transfer())
    }
}
