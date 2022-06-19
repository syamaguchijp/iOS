//
//  HalfModalView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/19.
//

import SwiftUI

struct HalfModalView: View {
    
    @Binding var isOpen: Bool
    var message: String = ""
    
    @State private var draggetOffset: CGFloat = 0
    private let maxDraggOffset: CGFloat = 50
    private let halfModalHeightRatio: CGFloat = 0.7 // 画面縦幅に対する比率
 
    var dragGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                print("onChanged y=\(value.location.y) start=\(value.startLocation.y)")
                let tempDiffY = value.location.y - value.startLocation.y
                if (tempDiffY > 0 && tempDiffY < maxDraggOffset) {
                    draggetOffset = tempDiffY
                } else if (tempDiffY > 0) {
                    self.isOpen = false
                }
            }
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .fill(Color.gray)
                VStack {
                    Text(message)
                        .foregroundColor(.white)
                        .padding(15)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height * halfModalHeightRatio)
            .position( //.offsetだとDrag時に不具合を惹起するため、positionで。
                x: geometry.size.width / 2,
                y: self.isOpen ? estimateDisplayPositionY(geometry: geometry) : estimateInitialPositionY(geometry: geometry))
            .animation(.spring())
            .onTapGesture {
                //self.isOpen = false
            }
        }
        .gesture(dragGesture)
    }
    
    func estimateDisplayPositionY(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height - (geometry.size.height * halfModalHeightRatio / 2) +  geometry.safeAreaInsets.bottom + draggetOffset
    }
    
    func estimateInitialPositionY(geometry: GeometryProxy) -> CGFloat {
        return geometry.size.height + (geometry.size.height * halfModalHeightRatio / 2) +  geometry.safeAreaInsets.bottom
    }
}

