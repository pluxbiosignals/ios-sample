//
//  DeviceManager.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import Foundation
import PluxAPI

@objc class DeviceManager: NSObject, PXBioPluxManagerDelegate {
    
    private let centralManager: PXBioPluxManager
    
    var delegate: DeviceManagerProtocol?
        
    //MARK:- Lifecycle
    override init(){
        self.centralManager = PXBioPluxManager()

        super.init()
        
        self.centralManager.delegate = self
        self.centralManager.logLevel = .simple
    }
    
    //MARK:- Device Scan Methods
    func startScan(){
        self.centralManager.scanDevices()
    }
    
    func stopScan(){
        self.centralManager.stopScanDevices()
    }

    //MARK:- Device Lifecycle Methods
    func connectDevice(device: PXDevice?){
        if let device = device{
            self.centralManager.connectDevice(device)
        }
    }
    
    func disconnectDevice(device: PXDevice?){
        if let device = device{
            self.centralManager.disconnectDevice(device)
        }
    }
    
    //MARK:- Device Acquisition Methods
    func start(device: PXDevice?, baseFrequency: Float, sourceArrays: [PXSource]){
        if let device = device{
            device.startAcquisitionWithBaseFrequency(baseFrequency, sourcesArray: sourceArrays){ (result, results) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .start, result: result, data: results!)
                }
            }
        }
    }
    
    func stop(device: PXDevice?) {
        if let device = device{
            device.stopAcquisitionWithCompletionBlock(){ (result, results) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .stop, result: result, data: results!)
                }
            }
        }
    }
    
    
    //MARK:- Device Schedule Methods
    func addSchedule(device: PXDevice?, startTime: CLong, duration: CLong, nRepeats: Int?, repeatPeriod: CLong?, baseFrequency: Float?, sourceArrays: [PXSource]?, sessionText: String){
        if let device = device{
            device.addScheduleAcquisitionWithCompletionBlock(startTime: startTime, duration: duration, nRepeats: nRepeats ?? 0, repeatPeriod: repeatPeriod ?? 0, baseFrequency: baseFrequency ?? 200, sourcesArray: sourceArrays ?? [PXSource(port: 1, numberOfBits: 16, channelMask: 1, frequencyDivisor: 1)], text: sessionText){ (result, results) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .addShedule, result: result, data: results!)
                }
            }
        }
    }
    
    func stopSchedule(device: PXDevice?){
        if let device = device{
            device.stopScheduleWithCompletionBlock { (result, data) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .stopSchedule, result: result, data: data!)
                }
            }
        }
    }
    
    func getSchedules(device: PXDevice?){
        if let device = device{
            device.getSchedulesWithCompletionBlock{ (result, data) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getSchedules, result: result, data: data!)
                }
            }
        }
    }
    
    func deleteAllSchedules(device: PXDevice?){
        if let device = device{
            device.delAllSchedulesWithCompletionBlock{ (result, results) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .deleteAllSchedules, result: result, data: results!)
                }
            }
        }
    }
    
    //MARK:- Device Session Methods
    func getSessionList(device: PXDevice?){
        if let device = device{
            device.getSessionsWithCompletionBlock{ (result, data) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getSessionsList, result: result, data: data!)
                }
            }
        }
    }
    
    func replaySession(device: PXDevice?, session: PXSession){
        if let device = device{
            device.replaySession(session: session)
        }
    }
    
    func deleteSessions(device: PXDevice?){
        if let device = device{
            device.eraseSDCardSessionsWithCompletionBlock{ (result, results) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .eraseSDCard, result: result, data: results!)
                }
            }
        }
    }
    
    //MARK:- Device Generic Methods
    
    func getProperties(device: PXDevice?){
        if let device = device{
            device.getPropertiesWithCompletionBlock{ (result, properties) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getProperties, result: result, data: properties!)
                }
            }
        }
    }
    
    func setTime(device: PXDevice?){

        let time = Date.currentTimeStampInSeconds
        
        if let device = device {
            device.setTimeOfDeviceWithCompletionBlock(time){ (result, time) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .setTime, result: result, data: time!)
                }
            }
        }
    }
    
    func getTime(device: PXDevice?){
        
        if let device = device {
            device.getTimeOfDeviceWithCompletionBlock{ (result, time) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getTime, result: result, data: time!)
                }
            }
        }
    }
    
    func getBattery(device: PXDevice?){
        if let device = device{
            device.getBatteryWithCompletionBlock{ (result, battery) in
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getBattery, result: result, data: battery!)
                }
            }
        }
    }
    
    func setParameters(device: PXDevice?, port: Int, paramAdd: Int, paramArray: [UInt8]){
        
        if let device = device {
            device.setParametersWithCompletionBlock(port, paramAdd: paramAdd, paramArray: paramArray){ (result, parameters) in
                
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .setParameters, result: result, data: parameters!)
                }
            }
        }
    }
    
    func getParameters(device: PXDevice?, port: Int, paramAdd: Int){
        
        if let device = device {
            device.getParametersWithCompletionBlock(port, paramAdd: paramAdd){ (result, parameters) in
                
                if let delegate = self.delegate{
                    delegate.onResquestDone(device: device, request: .getParameters, result: result, data: parameters!)
                }
            }
        }
    }
    
    //MARK:- PXBioPluxManagerDelegate
    
    @objc func onDeviceFound(_ device: PXDevice){
        if let delegate = self.delegate{
            delegate.onDeviceFound(device: device)
        }
    }
    
    @objc func onConnectionStateChanged(_ device: PXDevice, state: States) {
        if state == .disconnected || state == .ended || state == .noConnection {
            LogManager.sharedInstance.log("On Connection State changed: \(state.description) -> Device: \(device.deviceUUID)")
        }
        
        if let delegate = self.delegate{
            delegate.onConnectionStateChanged(device: device, state: state)
        }
    }
    
    @objc func didFailToConnectDevice(_ device: PXDevice) {
        LogManager.sharedInstance.log("Did fail to connect to device")
        
        if let delegate = self.delegate{
            delegate.onConnectionStateChanged(device: device, state: States.noConnection)
        }
    }
    
    @objc func onDeviceReady(_ device: PXDevice, properties: PXDeviceProperties) {
                
        if let delegate = self.delegate{
            delegate.onDeviceReady(device: device, properties: properties)
        }
    }
    
    @objc func onError(_ device: PXDevice, error: PXCommandErrorReply) {
//        LogManager.sharedInstance.log("\(data)")
        
        if let delegate = self.delegate{
            delegate.onError(device: device, error: error)
        }
    }
    
    @objc func onDataAvailable(_ device: PXDevice, data: PXPluxFrame) {
        LogManager.sharedInstance.log("[\(device.deviceName)] On Data Available: \(data)")

        if let delegate = self.delegate{
            delegate.onDataAvailable(device: device, data: data)
        }
    }
    
    @objc func onEventAvailable(_ device: PXDevice, event: NSObject) {
        if let delegate = self.delegate{
            delegate.onEventAvailable(device: device, event: event)
        }
    }
    
    @objc func didBluetoothPoweredOff() {

        if let delegate = self.delegate{
            delegate.onBluetoothStateChanged(state: false)
        }
    }
    
    @objc func didBluetoothPoweredOn() {

        if let delegate = self.delegate{
            delegate.onBluetoothStateChanged(state: true)
        }
    }
}

protocol DeviceManagerProtocol {
    func onBluetoothStateChanged(state: Bool)
    
    func onDeviceFound(device: PXDevice)
    
    func onConnectionStateChanged(device: PXDevice, state: States)
    
    func onDeviceReady(device: PXDevice, properties: PXDeviceProperties)
    
    func onError(device: PXDevice, error: PXCommandErrorReply)
    
    func onDataAvailable(device: PXDevice, data: PXPluxFrame)
    
    func onEventAvailable(device: PXDevice, event: NSObject)
    
    func onResquestDone(device: PXDevice, request: DeviceRequests, result: Bool, data: NSObject)
}

enum DeviceRequests {
    case start
    case stop
    case addShedule
    case stopSchedule
    case getSchedules
    case deleteAllSchedules
    case getSessionsList
    case replaySession
    case eraseSDCard
    case getProperties
    case setTime
    case getTime
    case getBattery
    case setParameters
    case getParameters
}
