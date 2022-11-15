//
//  MainViewModel.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation
import Combine
import PluxAPI

final class MainViewModel: ObservableObject {
    // ObservableObject conformance
    let bluetoothStateDidChange = PassthroughSubject<Bool, Never>()
    let deviceStateDidChange = PassthroughSubject<States, Never>()
    
    @Published var bluetoothEnabled: Bool{
        didSet { bluetoothStateDidChange.send(bluetoothEnabled) }
    }
    @Published var deviceManager: DeviceManager = DeviceManager()
    @Published var device: PXDevice?
    @Published var deviceState: States {
        didSet { deviceStateDidChange.send(deviceState) }
    }
    
    @Published var deviceIdentifier: String = "PLUX"
    @Published var deviceReady: Bool = false
    
    @Published var deviceBatteryLevel: Float = .nan
    
    
    init() {
        self.deviceIdentifier = "PLUX"
        self.bluetoothEnabled = false
        self.deviceState = .noConnection
    }
    
    init(deviceIdentifier: String) {
        self.deviceIdentifier = deviceIdentifier
        self.bluetoothEnabled = false
        self.deviceState = .noConnection
        self.deviceReady = false
    }
    
    func reset(){
        self.deviceIdentifier = "PLUX"
        self.deviceState = .noConnection
        self.deviceReady = false
    }
    
}
