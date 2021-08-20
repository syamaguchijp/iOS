//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    @State var isActiveSecondView = false
    @State private var isPowerOn = false
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical,showsIndicators:true) {
                
                VStack{
                    // ボタン押下による画面遷移
                    Button(action: {
                        self.isActiveSecondView.toggle()
                    }) {
                        Text("ボタンアクションでの画面遷移")
                    }
                    NavigationLink(destination: SecondView(),
                                   isActive: $isActiveSecondView) {
                        // コード上でprogramaticallyに遷移するときは、EmptyViewを指定する
                        EmptyView()
                    }
                    // ココマデ
                    
                    // NavigationLink押下による画面遷移
                    NavigationLink(destination: SecondView()) {
                        Image("car").resizable().aspectRatio(contentMode:.fit).frame(width:200, height:100)
                    }
                    // ココマデ
                    
                    // @stateでデータバインディング
                    Button(action: {
                        self.isPowerOn.toggle() // クリックでisPowerOnの値を反転
                    }) {
                        Image(systemName: "power")
                    }
                    Text(isPowerOn ? "オン" : "オフ")
                    // ココマデ
                }
        
                // TextFieldと入力値に対応するText
                TextField("Name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                Text("\(name)").font(.title).fixedSize(horizontal:true,vertical:false).frame(width:200,alignment:.leading).border(Color.gray)
                    .padding()
                // ココマデ
                
                Label("Sun", systemImage:"sun.max.fill")
                    .padding()
                
                Button(action:{
                        print("tappedbutton")
                }){
                    VStack{
                        Image(systemName:"camera").resizable().renderingMode(.original).aspectRatio(contentMode:.fit).frame(width:40, height:40)
                        Text("Camera").foregroundColor(.black)
                    }.frame(width:150, height:100)
                    .overlay(RoundedRectangle(cornerRadius:8).stroke(Color.black,lineWidth:4))
                }
                //.border(Color.gray)
                
                Rectangle().foregroundColor(.gray).frame(width:100,height:100)
                
                List{
                    Section(header: Text("Header"), footer: Text("footer")){
                        HStack {
                            Image(systemName:"moon")
                            Text("moon")
                        }
                        HStack {
                            Image(systemName:"sun.max")
                            Text("sun")
                        }
                    }
                }
                
                VStack{
                    MyRectView(color:.red)
                    MyRectView(color:.yellow)
                    MyRectView(color:.blue)
                    MyRectView(color:.red)
                    MyRectView(color:.yellow)
                    MyRectView(color:.blue)
                    MyRectView(color:.red)
                    MyRectView(color:.yellow)
                    MyRectView(color:.blue)
                }.frame(maxWidth: .infinity)
                
            }.gesture(
                // ScrollViewのスクロールイベント
                DragGesture().onChanged { value in
                    if value.translation.height > 0 {
                        print("\(String(describing: type(of: self))) \(#function) down")
                    } else {
                        print("\(String(describing: type(of: self))) \(#function) up")
                    }
                }
            )
            
            .navigationTitle("FirstView").navigationBarTitleDisplayMode(.large)
        }
    }
}

struct MyRectView: View {
    var color: Color
    var body: some View{
        Rectangle().frame(width:200,height:200).foregroundColor(color).cornerRadius(10)
    }
}

struct SecondView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Text("SecondViewです")
            .padding()
        Button("戻る") {
            presentationMode.wrappedValue.dismiss()
        }
        .navigationBarTitle("SecondView")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
