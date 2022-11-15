//
//  DeviceRowView.swift
//  ios-sample
//
//  Created by Gonçalo Telo on 15/11/2022.
//

import SwiftUI

struct DeviceRowView: View {
  @Binding var device: Device
  
  var body: some View {
    HStack(alignment: .top) {
      Image("plux_icon")
        .resizable()
        .aspectRatio(contentMode: .fill)
        .frame(width: 70, height: 70, alignment: .center)
        VStack(alignment: .leading) {
            Text("Name: \(device.device.deviceName)")
                .font(.headline)
            Spacer()
            Text("Identifier: \(device.device.deviceUUID)")
                .font(.subheadline)
        }
        Spacer()
    }
    .padding()
  }
}
