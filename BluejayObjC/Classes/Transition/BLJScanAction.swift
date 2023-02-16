//
//  BLJScanAction.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation

public class BLJScanAction: NSObject, LanguageTransferable {
    func transfer() -> ScanAction {
        fatalError()
    }
}

@objcMembers
public class BLJContinueScanAction: BLJScanAction {
    override func transfer() -> ScanAction {
        return .continue
    }
}

@objcMembers
public class BLJBlacklistScanAction: BLJScanAction {
    override func transfer() -> ScanAction {
        return .blacklist
    }
}

@objcMembers
public class BLJStopScanAction: BLJScanAction {
    override func transfer() -> ScanAction {
        return .stop
    }
}

@objcMembers
public class BLJConnectScanAction: BLJScanAction {
    public let discovery: BLJScanDiscovery
    
    public let timeout: TimeInterval
    
    public let warningOptions: BLJWarningOptions
    
    public let resultHandler: (BLJPeripheralIdentifier?, Error?) -> Void
    
    public init(discovery: BLJScanDiscovery, timeout: TimeInterval, warningOptions: BLJWarningOptions?, resultHandler: @escaping (BLJPeripheralIdentifier?, Error?) -> Void) {
        self.discovery = discovery
        self.timeout = timeout
        self.warningOptions = warningOptions ?? BLJWarningOptions.default
        self.resultHandler = resultHandler
    }
    
    override func transfer() -> ScanAction {
        let handler = resultHandler
        return .connect(discovery.transfer(),
                        timeout > 0 ? .seconds(timeout) : .none,
                        warningOptions.transfer()) { result in
            switch result {
            case let .success(peripheral): handler(peripheral.transfer(), nil)
            case let .failure(error): handler(nil, error)
            }
        }
    }
}
