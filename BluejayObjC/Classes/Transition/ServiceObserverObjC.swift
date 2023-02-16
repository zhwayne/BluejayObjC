//
//  ServiceObserverObjC.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objc
public protocol BLJServiceObserver: NSObjectProtocol {
    /**
     * Called whenever a peripheral's services change.
     *
     * - Parameters:
     *    - from: the peripheral that changed services.
     *    - invalidatedServices: the services invalidated.
     */
    func didModifyServices(from peripheral: BLJPeripheralIdentifier, invalidatedServices: [BLJServiceIdentifier])
}

final class ServiceObserverWrapper
: ObserverWrapper<BLJServiceObserver>
, ServiceObserver {
    
    func didModifyServices(from peripheral: PeripheralIdentifier, invalidatedServices: [ServiceIdentifier]) {
        object?.didModifyServices(from: peripheral.transfer(), invalidatedServices: invalidatedServices.map { $0.transfer() })
    }
}
