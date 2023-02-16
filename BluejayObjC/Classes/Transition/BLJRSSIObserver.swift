//
//  BLJRSSIObserver.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objc
public protocol BLJRSSIObserver: NSObjectProtocol {
    
    /**
     * Called whenever a peripheral's RSSI value changes.
     *
     * - Parameters:
     *    - from: the peripheral that read the RSSI value.
     *    - RSSI: the RSSI value as a `NSNumber`.
     *    - error: the error if the RSSI read failed.
     */
    func didReadRSSI(from peripheral: BLJPeripheralIdentifier, RSSI: NSNumber, error: Error?)
}

final class RSSIObserveWrapper
: ObserverWrapper<BLJRSSIObserver>
, RSSIObserver {
    
    func didReadRSSI(from peripheral: PeripheralIdentifier, RSSI: NSNumber, error: Error?) {
        object?.didReadRSSI(from: peripheral.transfer(), RSSI: RSSI, error: error)
    }
}
