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
    
    /// メニューの開閉をトグルさせる
    func toggleMenuOpen() {
        
        if isMenuOpen {
            self.closeMenu()
            
        } else {
            self.openMenu()
            
        }
    }
    
    /// メニューを開く
    func openMenu() {
        
        self.prepareMenuForReveal()
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            
            guard let rightView = self.rightMainView else {
                return
            }

            var rect: CGRect = rightView.frame
            let width = rightView.frame.size.width
            rect.origin.x = width - 100
            self.moveHorizontally(location: rect.origin.x)
 
        }, completion: { _ in
            
            self.isMenuOpen = true
        })
    }
    
    /// メニューを閉じる
    func closeMenu() {
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0.5, options: UIViewAnimationOptions.curveEaseInOut, animations: { () -> Void in
            
            guard let rightView = self.rightMainView else {
                return
            }

            var rect: CGRect = rightView.frame
            rect.origin.x = 0
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
        rect.origin.x = 0
        rect.origin.y = 0
        leftView.frame = rect
    }
    
    /// ビューを引数で指定された位置までドラッグする
    private func moveHorizontally(location: CGFloat) {

        guard let rightView = self.rightMainView else {
            return
        }

        var rect: CGRect = rightView.frame
        if (location < 0) {
            rect.origin.x = 0.0
        } else {
            rect.origin.x = location
        }
        rect.origin.y = 0.0
        rightView.frame = rect
    }
    
    /*
     /// 現在、メニューが開いているかどうかを左側ビューの水平位置で判断する
     func isMenuOpen() -> Bool {
     guard let leftView = self.leftSlideMenuView else {
     return false
     }
     return (leftView.frame.origin.x == 0.0) ? true : false
     }
     */
}
