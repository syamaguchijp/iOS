//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/20.
//

import SwiftUI

struct ContentView: View {
    
    @State var selection = 0
    
    var body: some View {
        
        TabView(selection: $selection) {
            WebView(urlString: "https://yahoo.co.jp")
                .tabItem{Image(systemName:"list.dash"); Text("Yahoo")}
                .tag(0)
            
            WebView(urlString: "https://google.co.jp")
                .tabItem{Image(systemName:"gear"); Text("Google")}
                .tag(1)
            
            WebView(urlString: "https://apple.com")
                .tabItem{Image(systemName:"power"); Text("Apple")}
                .tag(2)
            
        }.onChange(of: selection) { selection in
            if selection == 0 {
                print("selection 0")
            } else if selection == 1 {
                print("selection 1")
            } else {
                print("selection 2")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
