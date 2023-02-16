//
//  BLJBluejay.swift
//  BluetoothDemo
//
//  Created by iya on 2022/10/27.
//

import Foundation
import CoreBluetooth

/// An Objective-C wrapper for Bluejay.
@objcMembers
public final class BLJBluejay: NSObject {
    
    public static let shared = BLJBluejay()
    
    private let bluejay = Bluejay()
    
    private override init() {
        super.init()
    }
    
    /// Helps distinguish one Bluejay instance from another.
    public var uuid: UUID { bluejay.uuid }
    
    /// Allows checking whether Bluetooth is powered on. Also returns false if Bluejay is not started yet.
    public var isBluetoothAvailable: Bool { bluejay.isBluetoothAvailable }
    
    /// Allows checking for if CoreBluetooth state is transitional (update is imminent)
    /// please re-evaluate the bluetooth state again as it may change momentarily after it has returned true
    public var isBluetoothStateUpdateImminent: Bool { bluejay.isBluetoothStateUpdateImminent }
    
    /// Allows checking whether Bluejay is currently connecting to a peripheral.
    public var isConnecting: Bool { bluejay.isConnecting }
    
    /// Allows checking whether Bluejay is currently connected to a peripheral.
    public var isConnected: Bool { bluejay.isConnected }
    
    /// Allows checking whether Bluejay is currently disconnecting from a peripheral.
    public var isDisconnecting: Bool { bluejay.isDisconnecting }
    
    /// Allowing checking whether Bluejay will automatic reconnect after an unexpected disconnection. Default is true, and Bluejay will also always set this to true on a successful connection to a peripheral. Conversely, Bluejay will always set this to false after an explicit disconnection request.
    public var shouldAutoReconnect: Bool { bluejay.shouldAutoReconnect }
    
    /// Allows checking whether Bluejay is currently scanning.
    public var isScanning: Bool { bluejay.isScanning }
    
    /// Allows checking whether Bluejay has started and is available for use.
    public var hasStarted: Bool { bluejay.hasStarted }
    
    /// Allows checking whether Bluejay has background restoration enabled.
    public var isBackgroundRestorationEnabled: Bool { bluejay.isBackgroundRestorationEnabled }
    
    /// Enables disconnection errors or arguments to "cancelEverything" also being broadcast to active listeners, to allow them to perform cleanup or shutdown
    /// operations.
    ///
    /// Note: Currently defaults to false, to match original behaviour, because this could be quite disruptive to code that was written assuming this isn't true.
    /// Arguably should default to true, since there are some situations (such listens in background tasks without timeouts) where this is required for correct
    /// behaviour, and it may change eventually.
    public var broadcastErrorsToListeners: Bool {
        set { bluejay.broadcastErrorsToListeners = newValue }
        get { bluejay.broadcastErrorsToListeners }
    }
    
    /**
     Starting Bluejay will initialize the CoreBluetooth stack. Simply initializing a Bluejay instance without calling this function will not initialize the CoreBluetooth stack. An explicit start call is required so that we can also support proper background restoration, where CoreBluetooth must be initialized in the AppDelegate's application(_:didFinishLaunchingWithOptions:) for both starting an iOS background task and for parsing the restore identifier.
     
     - Parameters:
     - options: Wrapper for CBCentralManager initialization configurations when starting a new Bluejay instance.
     */
    public func start(options: BLJStartOptions) {
        bluejay.start(mode: StartMode.new(options.transfer()))
    }
    
    /**
     Stops all operations and clears all states in Bluejay before returning a Core Bluetooth state that can then be used by another library or code outside of Bluejay.
     
     - Returns: Returns a CBCentralManager and possibly a CBPeripheral as well if there was one connected at the time of this call.
     - Warning: Will crash if Bluejay has not been instantiated properly or if Bluejay is still connecting.
     */
    public func stopAndExtractBluetoothState() -> (manager: CBCentralManager, peripheral: CBPeripheral?) {
        return bluejay.stopAndExtractBluetoothState()
    }
    
    /**
     This will cancel the current and all pending operations in the Bluejay queue. It will also disconnect by default after the queue is emptied, but you can cancel everything without disconnecting.
     
     - Parameters:
     - error: Defaults to a generic `cancelled` error. Pass in a specific error if you want to deliver a specific error to all of your running and queued tasks.
     - shouldDisconnect: Defaults to true, will not disconnect if set to false, but only matters if Bluejay is actually connected.
     */
    public func cancelEverything(shouldDisconnect: Bool = true) {
        bluejay.cancelEverything(error: BluejayError.cancelled, shouldDisconnect: shouldDisconnect)
    }
    
    /**
     Register for notifications on Bluetooth connection events and state changes. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter connectionObserver: object interested in receiving Bluejay's Bluetooth connection related events.
     */
    public func register(connectionObserver: BLJConnectionObserver) {
        if let _ = connectionObserver.getWrapper(key: &ObserverAssociatedKeys.connectionObserverKey, type: ConnectionObserverWrapper.self) {
            return
        }
        let wrapper = ConnectionObserverWrapper(object: connectionObserver, key: &ObserverAssociatedKeys.connectionObserverKey)
        bluejay.register(connectionObserver: wrapper)
    }
    
    /**
     Unregister for notifications on Bluetooth connection events and state changes. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter connectionObserver: object no longer interested in receiving Bluejay's connection related events.
     */
    public func unregister(connectionObserver: BLJConnectionObserver) {
        if let wrapper = connectionObserver.getWrapper(key: &ObserverAssociatedKeys.connectionObserverKey, type: ConnectionObserverWrapper.self) {
            bluejay.unregister(connectionObserver: wrapper)
        }
    }
    
    /**
     Register for notifications when `readRSSI` is called. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter rssiObserver: object interested in receiving Bluejay's `readRSSI` response.
     */
    public func register(rssiObserver: BLJRSSIObserver) {
        if let _ = rssiObserver.getWrapper(key: &ObserverAssociatedKeys.rssiObserverKey, type: RSSIObserveWrapper.self) {
            return
        }
        let wrapper = RSSIObserveWrapper(object: rssiObserver,key:  &ObserverAssociatedKeys.rssiObserverKey)
        bluejay.register(rssiObserver: wrapper)
    }
    
    /**
     Unregister for notifications when `readRSSI` is called. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter rssiObserver: object no longer interested in receiving Bluejay's `readRSSI` response.
     */
    public func unregister(rssiObserver: BLJRSSIObserver) {
        if let wrapper = rssiObserver.getWrapper(key: &ObserverAssociatedKeys.rssiObserverKey, type: RSSIObserveWrapper.self) {
            bluejay.unregister(rssiObserver: wrapper)
        }
    }
    
    /**
     Register for notifications when a connected peripheral's services change. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter serviceObserver: object interested in receiving the connected peripheral's did modify services event.
     */
    public func register(serviceObserver: BLJServiceObserver) {
        if let _ = serviceObserver.getWrapper(key: &ObserverAssociatedKeys.serviceObserverKey, type: ServiceObserverWrapper.self) {
            return
        }
        let wrapper = ServiceObserverWrapper(object: serviceObserver, key: &ObserverAssociatedKeys.serviceObserverKey)
        bluejay.register(serviceObserver: wrapper)
    }
    
    /**
     Unregister for notifications when a connected peripheral's services change. Unregistering is not required, Bluejay will unregister for you if the observer is no longer in memory.
     
     - Parameter serviceObserver: object no longer interested in receiving the connected peripheral's did modify services event.
     */
    public func unregister(serviceObserver: BLJServiceObserver) {
        if let wrapper = serviceObserver.getWrapper(key: &ObserverAssociatedKeys.serviceObserverKey, type: ServiceObserverWrapper.self) {
            bluejay.unregister(serviceObserver: wrapper)
        }
    }
        
    /**
     Register a single disconnection handler for giving it a final say on what to do at the end of a disconnection, as well as evaluate and control Bluejay's auto-reconnect behaviour.
     
     - Parameter handler: object interested in becoming Bluejay's optional but most featureful disconnection handler.
     */
    public func registerDisconnectHandler(handler: BLJDisconnectHandler) {
        let wrapper = DisconnectHandlerWrapper(object: handler, key: &ObserverAssociatedKeys.disconnectHandlerKey)
        bluejay.registerDisconnectHandler(handler: wrapper)
    }
    
    /**
     Remove any registered disconnection handler.
     */
    public func unregisterDisconnectHandler() {
        bluejay.unregisterDisconnectHandler()
    }
    
    /**
     Scan for the peripheral(s) specified.
     
     - Warning: Setting `serviceIdentifiers` to `nil` will result in picking up all available Bluetooth peripherals in the vicinity, **but is not recommended by Apple**. It may cause battery and cpu issues on prolonged scanning, and **it also doesn't work in the background**. If you need to scan for all Bluetooth devices, we recommend making use of the `duration` parameter to stop the scan after 5 ~ 10 seconds to avoid scanning indefinitely and overloading the hardware.
     
     - Parameters:
     - duration: Stops the scan when the duration in seconds is reached. Defaults to zero (indefinite).
     - allowDuplicates: Determines whether a previously scanned peripheral is allowed to be discovered again.
     - throttleRSSIDelta: Throttles discoveries by ignoring insignificant changes to RSSI.
     - serviceIdentifiers: Specifies what visible services the peripherals must have in order to be discovered.
     - discovery: Called whenever a specified peripheral has been discovered.
     - expired: Called whenever a previously discovered peripheral has not been seen again for a while, and Bluejay is predicting that it may no longer be in range. (Only for a scan with allowDuplicates enabled)
     - stopped: Called when the scan is finished and provides an error if there is any.
     */
    public func scan(duration: TimeInterval = 0, allowDuplicates: Bool = false, throttleRSSIDelta: Int = 5, serviceIdentifiers: [BLJServiceIdentifier]?, discovery: @escaping (BLJScanDiscovery, [BLJScanDiscovery]) -> BLJScanAction, expired: ((BLJScanDiscovery, [BLJScanDiscovery]) -> BLJScanAction)? = nil, stopped: @escaping ([BLJScanDiscovery], Error?) -> Void) {
        let serviceIdentifiers = serviceIdentifiers?.map { $0.transfer() }
        bluejay.scan(duration: duration, allowDuplicates: allowDuplicates, throttleRSSIDelta: throttleRSSIDelta, serviceIdentifiers: serviceIdentifiers) {
            let action = discovery($0.transfer(), $1.map({ $0.transfer() }))
            return action.transfer()
        } expired: {
            guard let action = expired?($0.transfer(), $1.map({ $0.transfer() })) else { return .stop }
            return action.transfer()
        } stopped: {
            stopped($0.map({ $0.transfer() }), $1)
        }
    }
    
    /// Stops current or queued scan.
    public func stopScanning() {
        bluejay.stopScanning()
    }
    
    /**
     Attempt to connect directly to a known peripheral. The call will fail if Bluetooth is not available, or if Bluejay is already connected. Making a connection request while Bluejay is scanning will also cause Bluejay to stop the current scan for you behind the scene prior to fulfilling your connection request.
     
     - Parameters:
     - peripheralIdentifier: The peripheral to connect to.
     - timeout: Specify how long the connection time out should be.
     - warningOptions: Optional connection warning options, if not specified, Bluejay's default will be used.
     - completion: Called when the connection request has ended.
     */
    public func connect(_ peripheralIdentifier: BLJPeripheralIdentifier, timeout: TimeInterval, warningOptions: BLJWarningOptions? = nil, completion: @escaping (BLJPeripheralIdentifier?, Error?) -> Void) {
        bluejay.connect(peripheralIdentifier.transfer(), timeout: timeout > 0 ? .seconds(timeout) : .none, warningOptions: warningOptions?.transfer()) { result in
            switch result {
            case let .success(peripheral): completion(peripheral.transfer(), nil)
            case let .failure(error): completion(nil, error)
            }
        }
    }
    
    /**
     Disconnect a connected peripheral or cancel a connecting peripheral.
     
     - Attention: If you are going to use the completion block, be careful on how you orchestrate and organize multiple disconnection callbacks if you are also using a `DisconnectHandler`.
     
     - Parameters:
     - immediate: If true, the disconnect will not be enqueued and will cancel everything in the queue immediately then disconnect. If false, the disconnect will wait until everything in the queue is finished.
     - completion: Called when the disconnect request is fully completed.
     */
    public func disconnect(immediate: Bool = false, completion: ((BLJPeripheralIdentifier?, Error?) -> Void)? = nil) {
        bluejay.disconnect(immediate: immediate) { result in
            guard let completion = completion else { return }
            switch result {
            case let .disconnected(peripheral): completion(peripheral.transfer(), nil)
            case let .failure(error): completion(nil, error)
            }
        }
    }
    
    /**
     Read from the specified characteristic.
     
     - Parameters:
     - characteristicIdentifier: The characteristic to read from.
     - completion: Called with the result of the attempt to read from the specified characteristic.
     */
    public func read(from characteristicIdentifier: BLJCharacteristicIdentifier, completion: @escaping (Data?, Error?) -> Void) {
        bluejay.read(from: characteristicIdentifier.transfer()) { (result: ReadResult<Data>) in
            switch result {
            case .success(let value): completion(value, nil)
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    /**
     Write to the specified characteristic.
     
     - Parameters:
     - characteristicIdentifier: The characteristic to write to.
     - type: Write type.
     - completion: Called with the result of the attempt to write to the specified characteristic.
     */
    public func write(to characteristicIdentifier: BLJCharacteristicIdentifier, value: BLJSendable, type: CBCharacteristicWriteType = .withResponse, completion: @escaping (Error?) -> Void) {
        bluejay.write(to: characteristicIdentifier.transfer(), value: value.toBluetoothData()) { result in
            switch result {
            case .success: completion(nil)
            case .failure(let error): completion(error)
            }
        }
    }
    
    /**
     Listen for notifications on the specified characteristic.
     
     - Parameters:
     - characteristicIdentifier: The characteristic to listen to.
     - completion: Called with the result of the attempt to listen for notifications on the specified characteristic.
     */
    public func listen(to characteristicIdentifier: BLJCharacteristicIdentifier, multipleListenOption option: BLJMultipleListenOption = .trap, completion: @escaping (Data?, Error?) -> Void) {
        bluejay.listen(to: characteristicIdentifier.transfer(), multipleListenOption: MultipleListenOption(rawValue: option.rawValue)!) { (result: ReadResult<Data>) in
            switch result {
            case .success(let value): completion(value, nil)
            case .failure(let error): completion(nil, error)
            }
        }
    }
    
    /**
     End listening on the specified characteristic.
     
     - Parameters:
     - characteristicIdentifier: The characteristic to stop listening to.
     - completion: Called with the result of the attempt to stop listening to the specified characteristic.
     */
    public func endListen(to characteristicIdentifier: BLJCharacteristicIdentifier, completion: ((Error?) -> Void)? = nil) {
        bluejay.endListen(to: characteristicIdentifier.transfer()) { result in
            guard let completion = completion else { return }
            switch result {
            case .success: completion(nil)
            case .failure(let error): completion(error)
            }
        }
    }
    
    /**
     Check if a peripheral is listening to a specific characteristic.
     
     - Parameters:
     - to: The characteristic we want to check.
     */
    @objc(isListeningTo:)
    public func isListening(to characteristicIdentifier: BLJCharacteristicIdentifier) -> Bool {
        let isListening = try? bluejay.isListening(to: characteristicIdentifier.transfer())
        return isListening ?? false
    }
    
    /**
     Attempts to read the RSSI (signal strength) of the currently connected peripheral.
     
     - Warning: Will throw if called while a Bluejay background task is running, or if not connected.
     */
    @objc(readRSSIWithError:)
    public func readRSSI() throws {
        try bluejay.readRSSI()
    }
    
    /**
     A helper function to take an array of Sendables and combine their data together.
     
     - Parameter sendables: An array of Sendables whose Data should be appended in the order of the given array.
     
     - Returns: The resulting data of all the Sendables combined in the order of the passed in array.
     */
    @objc(combine:)
    public static func combine(sendables: [BLJSendable]) -> Data {
        return Bluejay.combine(sendables: sendables.map({ $0.toBluetoothData() }))
    }
}
