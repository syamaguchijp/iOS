//
//  SlideMenuController.swift
//  SampleSlideMenu
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

/// スライドメニューの開閉をコントロールするクラス
class SlideMenuController: NSObject {
    
    static let shared = SlideMenuController()
    
    private let SlideMenuOpenDurationSec: Double = 0.3
    
    var leftSlideMenuView: UIView?
    var rightMainView: UIView?
    var isMenuOpen = false

    private override init() {
        
        super.init()
    }
    
    /// メニューを開く
    func openMenu() {
        
        self.prepareMenuForReveal()
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            
            guard let leftView = self.leftSlideMenuView else {
                return
            }
            
            var rect: CGRect = leftView.frame
            rect.origin.x = 0
            self.moveHorizontally(location: rect.origin.x)
 
        }, completion: { _ in
            
            self.isMenuOpen = true
        })
    }
    
    /// メニューを閉じる
    func closeMenu() {
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            
            guard let leftView = self.leftSlideMenuView else {
                return
            }

            var rect: CGRect = leftView.frame
            rect.origin.x = leftView.frame.size.width * -1
            self.moveHorizontally(location: rect.origin.x)
            
        }, completion: { _ in
            
            self.isMenuOpen = false
        })
    }
    
    /// メニューを開く直前にコールされ、メニューを可視化しドラッグできるようにする
    private func prepareMenuForReveal() {
        
        guard let leftView = leftSlideMenuView, let rightView = rightMainView else {
            return
        }
        
        rightView.window?.insertSubview(leftView, at: 0)
        rightView.window?.bringSubview(toFront: leftView)
        
        self.updateMenuFrameAndTransformAccordingToOrientation()
    }
    
    /// CGAffineTransform を設定し、ビューを左右に移動できるようにする
    private func updateMenuFrameAndTransformAccordingToOrientation() {
        
        guard let leftView = leftSlideMenuView, let rightView = rightMainView else {
            return
        }
        
        let transform: CGAffineTransform = rightView.transform
        leftView.transform = transform
        
        var rect: CGRect = rightView.frame
        rect.origin.x = leftView.frame.size.width * -1
        rect.origin.y = 0
        leftView.frame = rect
    }
    
    /// ビューを引数で指定された位置までドラッグする
    private func moveHorizontally(location: CGFloat) {

        guard let leftView = self.leftSlideMenuView else {
            return
        }

        var rect: CGRect = leftView.frame
        rect.origin.x = location
        rect.origin.y = 0.0
        leftView.frame = rect
    }

}
