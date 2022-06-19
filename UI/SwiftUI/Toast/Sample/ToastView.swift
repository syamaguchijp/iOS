//
//  ToastView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/19.
//

import SwiftUI

struct ToastView: View {
    
    @Binding var isOpen: Bool
    var message: String
    
    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.gray)
                
                VStack {
                    Text(message)
                        .foregroundColor(.white)
                        .padding(15)
                    Button("OK") {
                        self.isOpen = false
                    }
                        .frame(alignment : .bottomTrailing) // doesnt work
                        .offset(x: 0, y: -10)
                }
                /*
                Text(message)
                    .background(
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(.gray)
                            .padding(-15)
                            
                    )
                    .padding(20)
                 */
            }
            .fixedSize(horizontal: false, vertical: true) // ZStack内のRoundedRectangleとVStackを同じ高さにする
            .offset(y: self.isOpen ? 0 : -geometry.size.height)
            .animation(.spring())
            .onTapGesture {
                self.isOpen = false
            }
        }
    }
}
