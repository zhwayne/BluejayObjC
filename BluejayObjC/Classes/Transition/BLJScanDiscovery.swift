//
//  BLJScanDiscovery.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

@objcMembers
public final class BLJScanDiscovery: NSObject {
    
    /// The unique, persistent identifier associated with the peer.
    public let peripheralIdentifier: BLJPeripheralIdentifier
    
    /// The advertisement packet the discovered peripheral is sending.
    public let advertisementPacket: [String: Any]
    
    /// The signal strength of the peripheral discovered.
    public let rssi: Int
    
    public init(peripheralIdentifier: BLJPeripheralIdentifier,
                advertisementPacket: [String: Any],
                rssi: Int) {
        self.peripheralIdentifier = peripheralIdentifier
        self.advertisementPacket = advertisementPacket
        self.rssi = rssi
    }
    
    public override var description: String {
        return "Peripheral: \(peripheralIdentifier), rssi: \(rssi)"
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? BLJScanDiscovery else { return false }
        return peripheralIdentifier.isEqual(other.peripheralIdentifier) && rssi == other.rssi
    }
    
    public override var hash: Int {
        return peripheralIdentifier.hash ^ rssi.hashValue
    }
}

extension BLJScanDiscovery: LanguageTransferable {
    
    func transfer() -> ScanDiscovery {
        return ScanDiscovery(peripheralIdentifier: peripheralIdentifier.transfer(),
                             advertisementPacket: advertisementPacket,
                             rssi: rssi)
    }
}


extension ScanDiscovery: LanguageTransferable {
    
    func transfer() -> BLJScanDiscovery {
        return BLJScanDiscovery(peripheralIdentifier: peripheralIdentifier.transfer(),
                                 advertisementPacket: advertisementPacket,
                                 rssi: rssi)
    }
}
