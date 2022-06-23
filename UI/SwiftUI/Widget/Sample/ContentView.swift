//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var memo = ""
    
    var body: some View {
        VStack{
        TextField("memo", text: $memo)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
        Text("\(memo)").font(.title).fixedSize(horizontal:true,vertical:false).frame(width:200,alignment:.leading)
            .padding()            
        }
        Text(UserDefaultsManager.shared.memo ?? "")
        Button(action: {
            let um = UserDefaultsManager.shared
            um.memo = memo
        }) {
            Text("保存")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
