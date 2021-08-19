//
//  ContentView.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/19.
//

import SwiftUI

struct ContentView: View {
    
    @State private var name = ""
    
    var body: some View {
        
        TextField("Name", text: $name)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
        
        Text("\(name)").font(.title).fixedSize(horizontal:true,vertical:false).frame(width:200,alignment:.leading).border(Color.gray)
            .padding()
        
        Label("Sun", systemImage:"sun.max.fill")

        Image("car").resizable().aspectRatio(contentMode:.fit).frame(width:200, height:100)

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

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
