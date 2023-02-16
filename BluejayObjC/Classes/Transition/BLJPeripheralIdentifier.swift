//
//  IYPeripheralIdentifier.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objcMembers
public final class BLJPeripheralIdentifier: NSObject {
    
    /// The UUID of the peripheral.
    public let uuid: UUID
    
    /// The name of the peripheral.
    public let name: String
    
    /// Returns both the name and uuid of the peripheral.
    public override var description: String {
        return "Peripheral: \(name), UUID: \(uuid)"
    }
    
    /// Create a PeripheralIdentifier using a UUID.
    @objc(initWithUUID:name:)
    public init(uuid: UUID, name: String?) {
        self.uuid = uuid
        self.name = name ?? "No Name"
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? BLJPeripheralIdentifier else { return false }
        return uuid == object.uuid
    }
    
    public override var hash: Int {
        return uuid.hashValue ^ name.hash
    }
}

extension BLJPeripheralIdentifier: LanguageTransferable {
    
    func transfer() -> PeripheralIdentifier {
        return PeripheralIdentifier(uuid: uuid, name: name)
    }
}

extension PeripheralIdentifier: LanguageTransferable {
    
    func transfer() -> BLJPeripheralIdentifier {
        return BLJPeripheralIdentifier(uuid: uuid, name: name)
    }
}
