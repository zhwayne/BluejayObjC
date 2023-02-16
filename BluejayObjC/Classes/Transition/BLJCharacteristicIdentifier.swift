//
//  BLJCharacteristicIdentifier.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation
import CoreBluetooth

/// A wrapper for CBUUID specific to a characteristic to help distinguish it from a CBUUID of a service.
@objcMembers
public final class BLJCharacteristicIdentifier: NSObject {
    /// The service this characteristic belongs to.
    public private(set) var service: BLJServiceIdentifier!
    
    /// The `CBUUID` of this characteristic.
    public private(set) var uuid: CBUUID!
    
    /// Create a `CharacteristicIdentifier` using a `CBCharacterstic`. Creation will fail if the "service" property of the CBCharacteristic is nil.
    /// Note: It isn't documented in CoreBluetooth under what circumstances that property might be nil, but it seems like it should almost never happen.
    @objc(initWithCBCharacteristic:)
    public init?(_ cbCharacteristic: CBCharacteristic) {
        let optionalService: CBService? = cbCharacteristic.service // became optional with iOS 15 SDK, do a little dance to make it always optional so code below should compile on Xcode 12 or 13
        
        guard let service = optionalService else {
            return nil
        }
        
        self.service = BLJServiceIdentifier(uuid: service.uuid)
        self.uuid = cbCharacteristic.uuid
    }
    
    /// Returns the essential description of a characteristic.
    public override var description: String {
        return "Characteristic: \(uuid.uuidString), Service: \(service.uuid.uuidString)"
    }
    
    /**
     * Create a `CharacteristicIdentifier` using a string and a `ServiceIdentifier`. Please supply a valid 128-bit UUID, or a valid 16 or 32-bit commonly used UUID.
     *
     * - Warning: If the uuid string provided is invalid and cannot be converted to a `CBUUID`, then there will be a fatal error.
     */
    @objc(initWithUUID:service:)
    public init(uuid: String, service: BLJServiceIdentifier) {
        super.init()
        self.uuid = CBUUID(string: uuid)
        self.service = service
    }
    
    /// Create a `CharacteristicIdentifier` using a `CBUUID` and a `ServiceIdentifier`.
    @objc(initWithCBUUID:service:)
    public init(uuid: CBUUID, service: BLJServiceIdentifier) {
        super.init()
        self.uuid = uuid
        self.service = service
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? CBCharacteristic {
            return (uuid == object.uuid) && (service.uuid == object.uuid)
        }
        if let object = object as? BLJCharacteristicIdentifier {
            return uuid == object.uuid && service == object.service
        }
        return false
    }
}

extension BLJCharacteristicIdentifier: LanguageTransferable {
    
    func transfer() -> CharacteristicIdentifier {
        return CharacteristicIdentifier(uuid: uuid, service: service.transfer())
    }
}
