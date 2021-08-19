//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical,showsIndicators:true){
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
            }.frame(maxWidth: .infinity) // Widthを画面いっぱいに
        }.gesture(
            DragGesture().onChanged { value in
                if value.translation.height > 0 {
                    print("\(String(describing: type(of: self))) \(#function) down")
                } else {
                    print("\(String(describing: type(of: self))) \(#function) up")
                }
            }
        )
    }
}

struct MyRectView: View {
    var color: Color
    var body: some View{
        Rectangle().frame(width:200,height:200).foregroundColor(color).cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
