//
//  BalloonView.swift
//  Sample
//
//  Created by Yamaguchi on 2022/06/18.
//

import SwiftUI

struct BalloonView: View {
    
    var message: String
    var width: CGFloat
    let widthPadding: CGFloat = 10
    let fontSize: CGFloat = 15
    
    var body: some View {
        
        VStack(spacing: 0) {
            Triangle()
                .fill(Color.red)
                .frame(width: 20, height: 10)
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(Color.red)
                .frame(width: width,
                       height: estimateHeight(width: width - widthPadding * 2, message: message) + 20)
                .overlay(
                    Text(message)
                        .frame(width: width - widthPadding * 2)
                        .font(.system(size: fontSize, weight: .regular, design: .default))
                        .foregroundColor(.white)
                )
        }
    }
    
    // 動的にTextの高さを取得する
    private func estimateHeight(width: CGFloat, message: String) -> CGFloat {
        
        return message.boundingRect(
            with: CGSize(
                width: width,
                height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: [.font: UIFont.systemFont(ofSize: fontSize)],
            context: nil
        ).height
    }
}

struct Triangle: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.closeSubpath()
        }
    }
}
