//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        WebView(urlString: "https://yahoo.co.jp")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
