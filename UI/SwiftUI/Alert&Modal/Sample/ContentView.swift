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
    @State private var isShowingHalfModal = false
    
    var body: some View {
        
        ZStack {
            
            VStack {
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
                
                // Half Modal
                Button("ハーフモーダル表示") {
                    self.isShowingHalfModal.toggle()
                }.padding()
            }
            
            HalfModalView(isOpen: $isShowingHalfModal, message: "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit.")
        }
        
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
