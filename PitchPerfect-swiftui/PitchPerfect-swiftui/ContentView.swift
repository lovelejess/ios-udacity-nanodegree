//
//  ContentView.swift
//  PitchPerfect-swiftui
//
//  Created by Jess Le on 12/5/19.
//  Copyright © 2019 lovelejess. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                print("RecordButton button tapped!")
            }) {
                Image("RecordButton").renderingMode(.original)
            }

            Text("Tap to Record")

            Button(action: {
                print("Stop button tapped!")
            }) {
                Image("Stop").renderingMode(.original)
                .resizable()
                .frame(width: 64, height: 64)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
