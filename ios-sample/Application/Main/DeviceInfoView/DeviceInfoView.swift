//
//  DeviceInfoView.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI

struct DeviceInfoView: View {
    @EnvironmentObject var mainViewModel: MainViewModel

    var body: some View {
        //Text("Hello, World! I'm the Device Info View!")
        VStack(spacing: 8){
            
//            if UIDevice.current.userInterfaceIdiom == .phone{
                VStack(spacing: 8){
                    Button {
                        self.mainViewModel.deviceManager.getProperties(device: self.mainViewModel.device)
                    } label: {
                        Text("Get Properties")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                    
                    Button {
                        self.mainViewModel.deviceManager.getBattery(device: self.mainViewModel.device)
                    } label: {
                        Text("Get Battery")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                    
                    Button {
                        self.mainViewModel.deviceManager.getTime(device: self.mainViewModel.device)
                    } label: {
                        Text("Check internal time")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                    
                    Button {
                        self.mainViewModel.deviceManager.setTime(device: self.mainViewModel.device)
                    } label: {
                        Text("Update internal time")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                    
                    Spacer()
                    
                    Button {
                        self.mainViewModel.deviceManager.disconnectDevice(device: self.mainViewModel.device)
                    } label: {
                        Text("Disconnect")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing, .bottom], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

//            }
//            else {
//
//            }
        }
    }
}

struct DeviceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInfoView()
    }
}

