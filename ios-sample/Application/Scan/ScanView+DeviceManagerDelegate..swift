//
//  ScanView+DeviceManagerDelegate..swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation
import PluxAPI

extension ScanView: DeviceManagerProtocol {
    
    //MARK:- Device Manager Protocol
    func onBluetoothStateChanged(state: Bool) {
        self.mainViewModel.bluetoothEnabled = state

        //if BTH is enabled, start timer
        if state {
            startScan()
        }
    }
    
    func onDeviceFound(device: PXDevice) {
        LogManager.sharedInstance.log("On Device found: \(device.deviceUUID) -> \(device.deviceName)")
        
        //check if device is a plux device
        if device.deviceName.lowercased().contains("plux"){
            self.devices.append(Device(id: self.devices.count, device: device))
        }
    }
    
    func onConnectionStateChanged(device: PluxAPI.PXDevice, state: PluxAPI.States) {
        return
    }
    
    func onDeviceReady(device: PluxAPI.PXDevice, properties: PluxAPI.PXDeviceProperties) {
        return
    }
    
    func onError(device: PluxAPI.PXDevice, error: PluxAPI.PXCommandErrorReply) {
        return
    }
    
    func onDataAvailable(device: PluxAPI.PXDevice, data: PXPluxFrame) {
        return
    }
    
    func onEventAvailable(device: PluxAPI.PXDevice, event: NSObject) {
        return
    }
    
    func onResquestDone(device: PluxAPI.PXDevice, request: DeviceRequests, result: Bool, data: NSObject) {
        return
    }
    
    //MARK:- Auxiliary Methods
    
}
