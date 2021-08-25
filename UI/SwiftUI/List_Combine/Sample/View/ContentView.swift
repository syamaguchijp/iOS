//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/21.
//

import SwiftUI

struct ContentView: View {
    
    // 参照型のデータオブジェクトを扱う場合は、@stateや@bindingではなく@ObservedObject
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        VStack() {
            ActivityIndicator(isAnimating: $viewModel.isLoading, style: .large)
            if (viewModel.isLoading) {
                Text("通信中")
            } else if (viewModel.rowDatas.isEmpty) {
                Text("データはありません")
            } else {
                List {
                    ForEach(viewModel.rowDatas) { rowData in
                        ListRowView(rowData: rowData)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchArticles()
        }
    }
}

struct ListRowView: View {
 
    let rowData: RowData
 
    var body: some View {
        HStack {
            URIImageView(url: rowData.user.profile_image_url).frame(width: 50, height: 50)
            Text(rowData.title)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
