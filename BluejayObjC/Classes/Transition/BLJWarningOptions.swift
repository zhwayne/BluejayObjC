//
//  BLJWarningOptions.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation
import CoreBluetooth

/// A connection's configurations for system alerts.
@objcMembers
public final class BLJWarningOptions: NSObject {
    
    /// Determines whether iOS should show a system alert when your suspended app is connected to a peripheral.
    let notifyOnConnection: Bool
    
    /// Determines whether iOS should show a system alert when your suspended app is disconnected from a peripheral.
    let notifyOnDisconnection: Bool
    
    /// Determines whether iOS should show a system alert when your suspended app receives a notification from a peripheral.
    let notifyOnNotification: Bool
    
    /// Sensible default warning options: all off in favour of not aggressively notifying the user of changes when the app is backgrounded.
    public static let `default` = BLJWarningOptions(notifyOnConnection: false, notifyOnDisconnection: false, notifyOnNotification: false)
    
    /// Convenience helper to create a dictionary for usage in CoreBluetooth.
    var dictionary: [String: Bool] {
        return [
            CBConnectPeripheralOptionNotifyOnConnectionKey: notifyOnConnection,
            CBConnectPeripheralOptionNotifyOnDisconnectionKey: notifyOnDisconnection,
            CBConnectPeripheralOptionNotifyOnNotificationKey: notifyOnNotification
        ]
    }
    
    /**
     Creates a connection options that can specify whether iOS can display a system alert when certain conditions are met while your app is suspended, usually an alert dialog outside of your app in the Home screen for example.
     
     - Parameters:
     - notifyOnConnection: Determines whether iOS should show a system alert when your suspended app is connected to a peripheral.
     - notifyOnDisconnection: Determines whether iOS should show a system alert when your suspended app is disconnected from a peripheral.
     */
    public init(notifyOnConnection: Bool, notifyOnDisconnection: Bool, notifyOnNotification: Bool) {
        self.notifyOnConnection = notifyOnConnection
        self.notifyOnDisconnection = notifyOnDisconnection
        self.notifyOnNotification = notifyOnNotification
    }
    
}

extension BLJWarningOptions: LanguageTransferable {
    
    func transfer() -> WarningOptions {
        return WarningOptions(notifyOnConnection: notifyOnConnection,
                              notifyOnDisconnection: notifyOnDisconnection,
                              notifyOnNotification: notifyOnNotification)
    }
}
