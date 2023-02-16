//
//  BLJDisconnectHandler.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objc
public protocol BLJDisconnectHandler: NSObjectProtocol {
    /**
     Notifies the delegate that the peripheral is fully disconnected.
     
     - Parameters:
     - peripheral: the peripheral disconnected
     - error: the reason of the disconnection from CoreBluetooth, not Bluejay
     - autoReconnect: whether Bluejay will auto-reconnect if no change is given
     */
    @objc func didDisconnect(
        from peripheral: BLJPeripheralIdentifier,
        with error: Error?,
        willReconnect autoReconnect: Bool) -> BLJAutoReconnectMode
}

final class DisconnectHandlerWrapper
: ObserverWrapper<BLJDisconnectHandler>
, DisconnectHandler {
    
    func didDisconnect(from peripheral: PeripheralIdentifier, with error: Error?, willReconnect autoReconnect: Bool) -> AutoReconnectMode {
        let modeMap = [
            BLJAutoReconnectMode.noChagnge: AutoReconnectMode.noChange,
            BLJAutoReconnectMode.reconnect: AutoReconnectMode.change(shouldAutoReconnect: true),
            BLJAutoReconnectMode.no: AutoReconnectMode.change(shouldAutoReconnect: false)
        ]
        guard let object = object else { return modeMap[.no]! }
        let mode = object.didDisconnect(from: peripheral.transfer(), with: error, willReconnect: autoReconnect)
        return modeMap[mode]!
    }
}
