//
//  ScanView.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI
import PluxAPI

struct ScanView: View {
    @Binding var currentView : ViewStates

    @EnvironmentObject var mainViewModel: MainViewModel
    
    @State var scanning = false
    @State var devices: [Device] = []

    
    var body: some View {
        ZStack{
            VStack {
                NavigationView {
                    //TabBar and content
                    VStack(spacing: 30) {
                        
                        List($devices) { $device in
                            DeviceRowView(device: $device)
                                .onTapGesture {
                                    stopScan()
                                    
                                    self.mainViewModel.device = $device.device.wrappedValue
                                    self.currentView = .Main
                                }
                        }
                        
                    }
                    .onAppear() {
                        self.mainViewModel.device = nil
                    }
                    .background(Color(UIColor(named:"AppPrimary")!))
                    .accentColor(Color(UIColor(named:"AppAccent")!))
                    .navigationTitle("Scan")
                    //.navigationBarTitle("Scan", displayMode: .automatic)
                    .navigationBarItems(
                        trailing:
                            Button {
                                if scanning {
                                    stopScan()
                                }
                                else {
                                    startScan()
                                }
                            } label: {
                                Text(scanning ? "Stop scan" : "Start scan")
                                    .bold()
                            }
                    )
                }
                //set TabBar items select color as the accent color
                .accentColor(Color(UIColor(named:"AppAccent")!))
                .onAppear(){
                    LogManager.sharedInstance.log("I'm running on a \(UIDevice.current.userInterfaceIdiom == .phone ? "IPHONE" : "IPAD")")
                    
                    if #available(iOS 15.0, *) {
                        let navigationBarAppearance = UINavigationBarAppearance()
                        navigationBarAppearance.configureWithDefaultBackground()
                        navigationBarAppearance.backgroundColor = UIColor(named: "AppPrimary")
                        
                        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    }
                    else {
                        //set TabBar opaque
                        UINavigationBar.appearance().isTranslucent = false
                        //set TabBar background color
                        UINavigationBar.appearance().backgroundColor = UIColor(named: "AppPrimary")
                    }
                }
                .onDisappear(){
                    print("On Disappear!!")
                    
                }
            }
            
        }
        .navigationViewStyle(.stack)
        .onAppear(){
            self.mainViewModel.deviceManager.delegate = self
        }
        .environment(\.colorScheme, .light)
        .background(Color("AppBackground"))
    }
}

struct Device: Identifiable {
    let id: Int
    var device: PXDevice
}

struct ScanView_Previews: PreviewProvider {
    static var previews: some View {
        ScanViewPreviewWrapper()
    }
}

struct ScanViewPreviewWrapper: View {
    @State(initialValue: .Scan) var currentView: ViewStates

    var body: some View {
        ScanView(currentView: $currentView).environmentObject(MainViewModel(deviceIdentifier: "00:00:00:00:00:00"))
    }
}
