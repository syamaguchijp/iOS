//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/20.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isShowingAlert = false
    @State private var isShowingActionSheet = false
    @State private var isShowingModal = false
    
    var body: some View {
        
        // Alert
        Button("アラート表示") {
            self.isShowingAlert.toggle()
        }
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("タイトル"),
                  message: Text("メッセージ"),
                  primaryButton: .default(Text("NO"), action: {print("tapped NO.")}),
                  secondaryButton: .default(Text("YES"), action: {print("tapped YES.")}))
        }.padding()
        
        // ActionSheet
        Button("アクションシート表示") {
            self.isShowingActionSheet.toggle()
        }
        .actionSheet(isPresented: $isShowingActionSheet) {
            ActionSheet(title: Text("タイトル"), message: Text("メッセージ"),
                        buttons:[.default(Text("1")) {print("1")}, .default(Text("2")) {print("2")}, .cancel()])
        }.padding()
        
        // Modal(Sheet)
        Button("モーダル表示") {
            self.isShowingModal.toggle()
        }
        .sheet(isPresented: $isShowingModal, onDismiss: {print("close modal.")}) {
            ModalView()
        }.padding()
        
        //TODO: iOS 15では「medium」モードにするとHalfModalが作成できる
        
    }
}

struct ModalView: View {
    // 環境変数からpresentationModeプロパティを取得
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Text("Modal View.").padding()
        Button("Close") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
