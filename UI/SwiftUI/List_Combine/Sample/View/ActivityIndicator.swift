//
//  ActivityIndicator.swift
//  Sample
//
//  Created by Yamaguchi on 2021/08/25.
//

import SwiftUI
import UIKit

struct ActivityIndicator: UIViewRepresentable {
    
    typealias UIViewType = UIActivityIndicatorView

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) ->
        ActivityIndicator.UIViewType {
        
        UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ view: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        
        if isAnimating {
            view.startAnimating()
            view.isHidden = false
        } else {
            view.isHidden = true
            view.stopAnimating()
        }
    }
}
