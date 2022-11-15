//
//  AcquisitionView.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI

import SwiftUI
import PluxAPI

struct AcquisitionView: View {
    @EnvironmentObject var mainViewModel: MainViewModel

    var body: some View {
        VStack(spacing: 8){
//            if UIDevice.current.userInterfaceIdiom == .phone{
                VStack(spacing: 8){
                    
                    Button {
                        let baseFrequency: Float = 1000
                        let sourceArrays = [PXSource(port: 1, numberOfBits: 16, channelMask: 1, frequencyDivisor: 100)]

                        self.mainViewModel.deviceManager.start(device: self.mainViewModel.device, baseFrequency: baseFrequency, sourceArrays: sourceArrays)
                    } label: {
                        Text("Start Acquisition")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
                    
                    Button {
                        self.mainViewModel.deviceManager.stop(device: self.mainViewModel.device)
                    } label: {
                        Text("Stop Acquisition")
                            .bold()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)
                    .padding([.leading, .trailing], 8)
                    .disabled(!self.mainViewModel.deviceReady)
            
                    Spacer()
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

 //           }
 //           else {
 //
 //           }
        }
    }
}

struct AcquisitionView_Previews: PreviewProvider {
    static var previews: some View {
        AcquisitionView()
    }
}
