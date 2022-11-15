//
//  PLUXAPISampleApp.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI

@main
struct PLUXAPISampleApp: App {
    @State var currentView : ViewStates = .Scan
    
    @ObservedObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            if currentView == .Scan {
                ScanView(currentView: $currentView)
                    .environmentObject(mainViewModel)
            }
            if currentView == .Main {
                MainView(currentView: $currentView)
                    .environmentObject(mainViewModel)
            }
        }
    }
}
