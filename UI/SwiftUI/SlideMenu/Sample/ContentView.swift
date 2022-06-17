//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/17.
//

import SwiftUI

struct ContentView: View {
    
    @State var isOpenMenu = false
    @State var selectedMenuNumber = 0
    
    var body: some View {
        ZStack {
            NavigationView {
                ZStack {
                    switch selectedMenuNumber {
                        default:
                            WebView(urlString: MenuUrls[selectedMenuNumber])
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            self.isOpenMenu.toggle()
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .imageScale(.large)
                        }
                    }}
                .navigationTitle(MenuNames[selectedMenuNumber])
            }
            .onChange(of: selectedMenuNumber) { value in
                print("\(String(describing: type(of: self))) \(#function)")
            }
            
            MenuView(isOpen: $isOpenMenu, selectedMenuNumber: $selectedMenuNumber)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
