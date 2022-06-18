//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/18.
//

import SwiftUI

let MenuNames = ["Yahoo", "Google", "Apple", "Twitter"]
let MenuUrls = ["https://yahoo.co.jp", "https://google.co.jp", "https://apple.com", "https://twitter.com"]
let menuHeight: CGFloat = 50
let menuWidth: CGFloat = 80

struct ContentView: View {
    
    @State private var selection = 0
    @State private var scrollProxy: ScrollViewProxy? // メニュータブを自動スクロールさせるため
    
    var body: some View {
        
        // メニュータブ部分
        ScrollViewReader { sp in
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(0..<MenuNames.count) { index in
                        MenuTabView(selection: $selection, name: MenuNames[index], tag: index)
                        .onTapGesture {selection = index}
                        .id(index)
                    }
                }.onAppear {
                    self.scrollProxy = sp
                }
            }
            .frame(maxWidth: .infinity, maxHeight: menuHeight)
        }
        /*
        Picker("", selection: $selection) {
            ForEach(0..<MenuNames.count) { index in
                MenuTabView(selection: $selection, name: MenuNames[index], tag: index)
            }
        }.pickerStyle(SegmentedPickerStyle())*/
        
        // 下部コンテンツ部分
        GeometryReader { geometry in
            TabView(selection: $selection) {
                ForEach(0..<MenuNames.count) { index in
                    WebView(urlString: MenuUrls[index])
                        .frame(width: geometry.size.width)
                        .tag(index)
                        .onAppear {
                            // 下部コンテンツ部分の横スクロールに合わせて、メニュータブ部分も横スクロールさせる
                            self.scrollProxy?.scrollTo(index, anchor: .top)
                        }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct MenuTabView: View {
    
    @Binding var selection: Int
    var name: String
    var tag: Int
    
    var body: some View {
        VStack {
            Text(name)
                .frame(width: menuWidth)
            
            if (selection == tag) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: menuWidth, height: 5)
            } else {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: menuWidth, height: 5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
