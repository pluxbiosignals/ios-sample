//
//  MainView.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI

struct MainView: View {
    @Binding var currentView : ViewStates

    @EnvironmentObject var mainViewModel: MainViewModel
    
    @State private var selection = 0
    @State private var loggerEntries: [Entry] = []
            
    var body: some View {
        ZStack{
            ZStack{
                VStack {
                    NavigationView {
                        //TabBar and content
                        VStack{
                            VStack(spacing: 0){
                                VStack(alignment: .center) {
                                    Text("Device Output")
                                        .font(.title3)
                                        .foregroundColor(Color(UIColor(named:"AppPrimaryDark")!))
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                                
                                ScrollViewReader { value in
                                    ScrollView{
                                        VStack(spacing: 0) {
                                            ForEach(loggerEntries, id: \.id) { entry in
                                                Text(entry.getLog())
                                                    .foregroundColor(Color.white)
                                                    .bold()
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                                    .lineLimit(nil)
                                                    .background(Color.black)
                                                    .id(entry.id)
                                            }
                                        }
                                    }
                                    .background(Color.black)
                                    .onAppear {
                                        value.scrollTo(loggerEntries.last?.id)
                                    }
                                    .onChange(of: loggerEntries.count) { _ in
                                        value.scrollTo(loggerEntries.last?.id)
                                    }
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
                                VStack(alignment: .center) {
                                    Text("Requests")
                                        .font(.title3)
                                        .foregroundColor(Color(UIColor(named:"AppPrimaryDark")!))
                                        .bold()
                                        .frame(maxWidth: .infinity, alignment: .topLeading)
                                }
                            }
                            
                            TabView(selection: $selection){
                                DeviceInfoView()
                                    .tabItem {
                                        VStack {
                                            Image("info-circle")
                                            Text("Device Info")
                                        }
                                    }
                                    .tag(0)
                                
                                AcquisitionView()
                                    .tabItem {
                                        VStack {
                                            Image("play")
                                            Text("Acquisition")
                                        }
                                    }
                                    .tag(1)

                            }
                            .padding(.top, -8)
                            .onAppear() {
                                //set default selection
                                self.selection = 0
                                
                                //connect to the device
                                self.mainViewModel.deviceManager.connectDevice(device: self.mainViewModel.device)
                                
                            }
                            .accentColor(Color(UIColor(named:"AppAccent")!))
                            //.navigationTitle("Test")
                            .navigationBarTitle(self.mainViewModel.deviceIdentifier, displayMode: .automatic)
                        }
                    }
                    .navigationViewStyle(.stack)
                    //set TabBar items select color as the accent color
                    .accentColor(Color(UIColor(named:"AppAccent")!))
                    .onAppear(){
                        if #available(iOS 15.0, *) {
                            let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
                            tabBarAppearance.configureWithDefaultBackground()
                            tabBarAppearance.backgroundColor = UIColor(named: "AppPrimary")
                            
                            tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "AppYellow") ?? Color.gray]
                            tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "AppYellow")
                            tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
                            tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.white
                            
                            UITabBar.appearance().standardAppearance = tabBarAppearance
                            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                            
                            
                            let navigationBarAppearance = UINavigationBarAppearance()
                            //navigationBarAppearance.configureWithOpaqueBackground()
                            navigationBarAppearance.configureWithDefaultBackground()
                            navigationBarAppearance.backgroundColor = UIColor(named: "AppPrimary")
                            
                            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
                            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                        }
                        else {
                            //set TabBar opaque
                            UITabBar.appearance().isTranslucent = false
                            //set TabBar background color
                            UITabBar.appearance().barTintColor = UIColor(named: "AppPrimary")
                            //set TabBar items default color as white
                            UITabBar.appearance().tintColor = UIColor.white
                            //set TabBar items unselected color as white
                            UITabBar.appearance().unselectedItemTintColor = UIColor.white
                        }
                        
                        //let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){timer in
                        //    loggerEntries.append(Entry(Date.now.formatted(date: .long, time: .complete)))
                        //}
                        
                    }
                    .onDisappear(){
                        self.loggerEntries.removeAll()
                        LogManager.sharedInstance.log("On Disappear!!")
                        
                    }
                }
                
            }
            .onAppear(){
                self.mainViewModel.deviceManager.delegate = self
            }
            .environment(\.colorScheme, .light)
            .background(Color("AppBackground"))

        }
    }
    
    struct Entry {
        let id = UUID()
        let log: String
        
        init(_ log: String) {
            self.log = log
        }
        
        func getLog() -> String{
            return self.log
        }
    }
    
    func addLoggerEntry(log: String){
        let df = DateFormatter()
        df.dateFormat = "y-MM-dd H:mm:ss.SSSS"

        self.loggerEntries.append(Entry("[\(df.string(from: Date()))]: \(log)"))
    }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainViewPreviewWrapper()
    }
}

struct MainViewPreviewWrapper: View {
    @State(initialValue: .Main) var currentView: ViewStates

    var body: some View {
        MainView(currentView: $currentView).environmentObject(MainViewModel(deviceIdentifier: "00:00:00:00:00:00"))
    }
}
