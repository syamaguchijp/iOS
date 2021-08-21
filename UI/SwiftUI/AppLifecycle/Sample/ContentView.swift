//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
        }.onAppear {
            print("VStack appeared")
        }.onDisappear {
            print("VStack disappeared")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
