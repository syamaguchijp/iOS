//
//  MenuView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/17.
//

import SwiftUI

let MenuNames = ["Yahoo", "Google", "Apple"]
let MenuUrls = ["https://yahoo.co.jp", "https://google.co.jp", "https://apple.com"]

struct MenuView: View {
    
    @Binding var isOpen: Bool
    @Binding var selectedMenuNumber: Int

    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                if self.isOpen {
                    List {
                        Section(header: Text("Menu")) {
                            ForEach(0..<MenuNames.count) { index in
                                MenuRowView(name: MenuNames[index])
                                    .onTapGesture {
                                        print("\(String(describing: type(of: self))) \(#function)")
                                        self.selectedMenuNumber = index
                                        self.isOpen = false
                                    }
                                    .listRowBackground(self.selectedMenuNumber == index ? Color.yellow : Color.white)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.white.opacity(1.0))
                    .frame(width: geometry.size.width * 0.7)
                    .padding(geometry.safeAreaInsets)
                    .onTapGesture {
                        print("\(String(describing: type(of: self))) \(#function)")
                        self.isOpen = false
                    }
                    .transition(.move(edge: .leading))
                }
            }
            .animation(.spring())
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct MenuRowView: View {
    
    var name: String
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .frame(width: 50, height: 50)
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

