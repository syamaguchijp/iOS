//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingToast = false

    var body: some View {
        
        ZStack {
            Button("Toast 表示") {
                isShowingToast.toggle()
            }
            ToastView(isOpen: $isShowingToast, message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
