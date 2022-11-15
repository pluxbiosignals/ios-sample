//
//  ScanView+ScanRountine.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation

extension ScanView{
    
    var scanningTime: Double {
        return 15
    }
    
    func startScan(){
        if self.scanning{
            return
        }
        
        self.devices.removeAll()
        
        self.scanning = true
        
        //start scanning for devices
        self.mainViewModel.deviceManager.startScan()
        
        //stop scanning after 20 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + scanningTime) {
            stopScan()
        }
    }
    
    func stopScan() {
        self.scanning = false
        
        self.mainViewModel.deviceManager.stopScan()
    }
}
