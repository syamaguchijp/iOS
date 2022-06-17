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
                ScrollView(.vertical) {
                    LazyVStack {
                        Text("Menu")
                        ForEach(0..<MenuNames.count) { index in
                            MenuRowView(selectedMenuNumber: $selectedMenuNumber, name: MenuNames[index], number: index)
                                .onTapGesture {
                                    print("\(String(describing: type(of: self))) \(#function)")
                                    self.selectedMenuNumber = index
                                    self.isOpen = false
                                }
                        }
                    }
                    .background(Color.white.opacity(1.0))
                    .frame(width: geometry.size.width * 0.7)
                    .padding(geometry.safeAreaInsets)
                }
                .background(Color.white.opacity(1.0))
                .onTapGesture {
                    print("\(String(describing: type(of: self))) \(#function)")
                    self.isOpen = false
                }
            }
            .offset(x: self.isOpen ? 0 : -geometry.size.width)
            .animation(.spring())
            .edgesIgnoringSafeArea([.top, .bottom])
        }
    }
}

struct MenuRowView: View {
    
    @Binding var selectedMenuNumber: Int
    var name: String
    var number: Int
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .frame(width: 50, height: 50)
            Text(name)
                .frame(maxWidth: .infinity, alignment: .leading)
        }.background(self.selectedMenuNumber == number ? Color.yellow : Color.white)
    }
}

