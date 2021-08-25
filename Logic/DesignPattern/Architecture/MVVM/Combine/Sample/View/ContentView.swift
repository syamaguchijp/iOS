//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import SwiftUI

struct ContentView: View {
    
    // 参照型のデータオブジェクトを扱う場合は、@stateや@bindingではなく@StateObjectや@ObservedObject
    // @StateObjectを付与したオブジェクトはViewインスタンスが破棄された後も破棄されずSwiftUIから保持されるが、@ObservedObjectはViewインスタンスが破棄されるとオブジェクトも破棄される
    @StateObject var viewModel = ContentViewModel()
    
    var body: some View {
        
        TextField("Name", text: $viewModel.inputName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
        TextField("Password", text: $viewModel.inputPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
        Button(action: {
            viewModel.startUrlSession()
        }) {
            Text("登録")
        }.padding()
        
        if (viewModel.isLoading) {
            Text("通信中").padding()
        }
        //Text(viewModel.inputName)
        
        // 通信結果の表示
        if let response = viewModel.apiResponse {
            Text(response.args.userName ?? "")
            Text(response.url)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
