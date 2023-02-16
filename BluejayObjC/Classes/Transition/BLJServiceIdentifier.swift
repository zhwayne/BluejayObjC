//
//  BLJServiceIdentifier.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation
import CoreBluetooth

@objcMembers
public final class BLJServiceIdentifier: NSObject {
    
    /// The `CBUUID` of this service.
    public let uuid: CBUUID
    
    /**
     * Create a `ServiceIdentifier` using a string. Please supply a valid 128-bit UUID, or a valid 16 or 32-bit commonly used UUID.
     *
     * - Warning: If the uuid string provided is invalid and cannot be converted to a `CBUUID`, then there will be a fatal error.
     */
    @objc(initWithUUID:)
    public init(uuid: String) {
        self.uuid = CBUUID(string: uuid)
    }
    
    /// Create a `ServiceIdentifier` using a `CBUUID`.
    @objc(initWithCBUUID:)
    public init(uuid: CBUUID) {
        self.uuid = uuid
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? BLJServiceIdentifier else { return false }
        return uuid == object.uuid
    }
}

extension BLJServiceIdentifier: LanguageTransferable {
    
    func transfer() -> ServiceIdentifier {
        return ServiceIdentifier(uuid: uuid)
    }
}

extension ServiceIdentifier: LanguageTransferable {
    
    func transfer() -> BLJServiceIdentifier {
        return BLJServiceIdentifier(uuid: uuid)
    }
}
