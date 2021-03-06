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
    var rightMainViewController: UIViewController?
    var isMenuOpen = false
    var menus = [Menu]()
    var currentIndex = 0
    
    private override init() {
        
        super.init()
        
        generateMenus()
    }
    
    // メニューを生成する
    private func generateMenus() {
        
        let menu1 = Menu(title: "Apple", url: "https://www.apple.com/jp/")
        menus.append(menu1)
        
        let menu2 = Menu(title: "Yahoo!", url: "https://yahoo.co.jp")
        menus.append(menu2)
        
        let menu3 = Menu(title: "Google", url: "https://google.com")
        menus.append(menu3)
        
        let menu4 = Menu(title: "Twitter", url: "https://twitter.com")
        menus.append(menu4)
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
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0.5, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            
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
        
        UIView.animate(withDuration: SlideMenuOpenDurationSec, delay: 0.5, options: UIView.AnimationOptions.curveEaseInOut, animations: { () -> Void in
            
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
