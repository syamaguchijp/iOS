//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/18.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isTapped = false
    
    var body: some View {
        
        VStack() {
            Spacer()
            Text(String("コーチマークテスト"))
                // 上のTextの座標を取得
                .background(
                    GeometryReader { geometry in
                        Color.clear.onAppear {
                            print("\(geometry.size) || \(geometry.frame(in: .global))")
                        }
                        if (!isTapped) {
                            BalloonView(message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit.", width: 200)
                                .offset(x:0, y:geometry.size.height)
                                .onTapGesture {
                                    isTapped = true
                                }
                        }
                    }
                    
                )
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
