//
//  ObserverWrapper.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

struct ObserverAssociatedKeys {
    static var rssiObserverKey = "ObserverAssociatedKeys.rssiObserverKey"
    static var serviceObserverKey = "ObserverAssociatedKeys.serviceObserverKey"
    static var connectionObserverKey = "ObserverAssociatedKeys.connectionObserverKey"
    static var disconnectHandlerKey = "ObserverAssociatedKeys.disconnectHandlerKey"
}

extension NSObjectProtocol {
    
    func getWrapper<T>(key: UnsafeRawPointer, type: T.Type) -> T? {
        return objc_getAssociatedObject(self, key) as? T
    }
}

class ObserverWrapper<T: NSObjectProtocol> {
    
    weak var object: T?
        
    init(object: T, key: UnsafeRawPointer) {
        self.object = object
        objc_setAssociatedObject(object, key, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
