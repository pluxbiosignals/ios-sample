//
//  MainView+DeviceManagerDelegate.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation
import PluxAPI

extension MainView: DeviceManagerProtocol {
    
    //MARK:- Device Manager Protocol
    func onBluetoothStateChanged(state: Bool) {
        self.mainViewModel.bluetoothEnabled = state

        //if BTH is disabled, return to ScanView
        if !state {
            self.currentView = .Scan
        }
    }
    
    func onDeviceFound(device: PluxAPI.PXDevice) {
        return
    }
    
    func onConnectionStateChanged(device: PXDevice, state: States) {
        LogManager.sharedInstance.log("[\(device.deviceUUID)] On Connection State Changed: \(state.description)")
        
        addLoggerEntry(log: "On State Changed: \(state.description.uppercased())")
        
        self.mainViewModel.deviceState = state
        
        if state == .disconnected || state == .ended || state == .noConnection {
            self.mainViewModel.deviceReady = false
            
            //set battery level to NaN
            self.mainViewModel.deviceBatteryLevel = .nan

            self.mainViewModel.device = nil
            
            self.currentView = .Scan
        }
    }
    
    func onDeviceReady(device: PXDevice, properties: PXDeviceProperties) {
        LogManager.sharedInstance.log("[\(device.deviceUUID)] On Device Ready: \(properties)")
        
        self.mainViewModel.deviceReady = true
        
        self.mainViewModel.deviceIdentifier = properties.uid
        
        addLoggerEntry(log: "Device Ready: \(properties)")
    }
    
    func onError(device: PXDevice, error: PXCommandErrorReply) {
        LogManager.sharedInstance.log("[\(device.deviceUUID)] On Error: \(error)")
        
        addLoggerEntry(log: "Error: \(error)")
    }
    
    func onDataAvailable(device: PXDevice, data: PXPluxFrame) {
        //LogManager.sharedInstance.log("[\(device.deviceUUID)] On Data Available: \(data)")

        if data.sequence % 100 == 0 {
            addLoggerEntry(log: "New Frame received: \(data)")
        }
    }
    
    func onEventAvailable(device: PXDevice, event: NSObject) {
        LogManager.sharedInstance.log("[\(device.deviceUUID)] On Event Available: \(event)")
        
        addLoggerEntry(log: "Event: \(event)")
    }
    
    func onResquestDone(device: PXDevice, request: DeviceRequests, result: Bool, data: NSObject) {
        LogManager.sharedInstance.log("[\(device.deviceUUID)] On Request Done: \(request); Result: \(result);")
        
        addLoggerEntry(log: "On Request Done: \(request); Result: \(result); Data: \(data)")
    }
    
    
    //MARK:- Auxiliary Methods
    private func getDate(timestamp: CLong) -> String{
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd HH:mm:ss"

        return df.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
}
