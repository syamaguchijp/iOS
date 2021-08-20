//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/20.
//

import SwiftUI

struct ContentView: View {
    let prefectures = ["北海道","青森県","岩手県","宮城県","秋田県","山形県","福島県",
                  "茨城県","栃木県","群馬県","埼玉県","千葉県","東京都","神奈川県",
                  "新潟県","富山県","石川県","福井県","山梨県","長野県","岐阜県",
                  "静岡県","愛知県","三重県","滋賀県","京都府","大阪府","兵庫県",
                  "奈良県","和歌山県","鳥取県","島根県","岡山県","広島県","山口県",
                  "徳島県","香川県","愛媛県","高知県","福岡県","佐賀県","長崎県",
                  "熊本県","大分県","宮崎県","鹿児島県","沖縄県"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(), count: 4)) {
                    ForEach(0 ..< prefectures.count) { index in
                        MyCell(pref: prefectures[index])
                            .onTapGesture {
                                print("Tapped \(index).")
                            }
                    }
                }
            }
            .navigationTitle("都道府県リスト")
        }
    }
}

struct MyCell: View {
    
    var pref: String
    
    var body: some View {
        // SecondViewに画面遷移する
        NavigationLink(destination: SecondView(text: pref)) {
            VStack(alignment: .center, spacing: 5, content: {
                Image(systemName: "power")
                    .frame(width: 50, height: 50)
                Text(pref)
            })
        }
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var text: String
    var body: some View {
        Text("\(text)")
            .padding()
        Button("戻る") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
