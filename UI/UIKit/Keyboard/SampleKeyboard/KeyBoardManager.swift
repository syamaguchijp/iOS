//
//  KeyBoardManager.swift
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

protocol KeyBoardManagerDelegate: AnyObject {
    func keyBoardManagerDidTap(scrollView: UIScrollView)
}

/// キーボード表示時のせり上がりや、キーボードを閉じる動作を行う管理クラス
/// UIViewController においてインスタンスを生成されて利用される
class KeyBoardManager: NSObject {
 
    var viewController: UIViewController?
    var scrollView: UIScrollView? // せり上げるスクロールビュー
    var textFieldArray: [UITextField] = [] // タップしたときに閉じるべきキーボードたちの配列
    var keyBoardRemainViewArray: [UIView] = [] // タップしたときにキーボードを閉じたくないときのUIView
    var updateScrollTargetView: UIView? // せり上げる基準とするターゲットのUIView
    var superViewBufferY = CGFloat(0.0)
    var safeAreaInsets : UIEdgeInsets? // SafeArea対応
    weak var delegate: KeyBoardManagerDelegate?
    
    private let movingYBuffer = CGFloat(10.0) // せり上げるY値のバッファ
    private var tapGestureRecognizer: UITapGestureRecognizer?
    private var scrollViewContentInsets: UIEdgeInsets?
    private var scrollViewScrollIndicatorInsets: UIEdgeInsets?
    
    /// メモリ解放時にコールされる
    deinit {
        
        // オブザーバを除去する
        NotificationCenter.default.removeObserver(self)
    }
    
    /// キーボードを表示したときや閉じるときをハンドリングできるように、オブザーバ、ジェスチャレコグナイザを設定する
    func generateObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        guard let sv = scrollView else {
            return
        }
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapGesture(gestureRecognizer:)))
        sv.addGestureRecognizer(tapGestureRecognizer!)
        tapGestureRecognizer!.cancelsTouchesInView = false
    }
    
    // MARK: キーボードを表示する
    
    /// キーボードが表示される時に NSNotification からコールされる
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let info = notification.userInfo, let keyboardFrameInfo = info[UIResponder.keyboardFrameEndUserInfoKey],
            let keyboardAnimationInfo = info[UIResponder.keyboardAnimationDurationUserInfoKey] else {
                return
        }
        
        guard let target = updateScrollTargetView else {
            return
        }
        
        // 画面タップジェスチャを、キーボードを閉じる機能のみにし、テーブルビューなどのタップイベントを動作させない
        tapGestureRecognizer!.cancelsTouchesInView = true
        
        // キーボードに対象物が隠れないよう、スクロールビューをかち上げる
        if let keyboardFrame = (keyboardFrameInfo as AnyObject).cgRectValue {
            
            let movingY = self.calculateMovingY(keyboardFrame: keyboardFrame, target: target)
            
            let animationDuration = (keyboardAnimationInfo as AnyObject).doubleValue
            
            if movingY > 0.0 {
                self.updateScrollViewSize(moveSize: movingY, duration: animationDuration!)
            }
        }
    }
    
    /// 予めスクロールビューのサイズを記憶しておく（viewDidAppear時）
    func memorizeScrollViewSize() {
        
        guard let sv = scrollView else {
            return
        }
        
        scrollViewContentInsets = sv.contentInset
        scrollViewScrollIndicatorInsets = sv.scrollIndicatorInsets
    }
    
    /// キーボード表示時にどのくらい画面を上にかち上げるべきかを返却する
    func calculateMovingY(keyboardFrame: CGRect, target: UIView) -> CGFloat {
        
        // スクロールビューの位置を記憶しておく
        self.memorizeScrollViewSize()
        
        guard let sv = scrollView else {
            return CGFloat(0.0)
        }
        
        let visibleTargetY = target.frame.maxY + superViewBufferY - (sv.contentOffset.y + sv.contentInset.top) // 現在の可視領域の中におけるターゲットのY座標（ターゲットの座標から、現在、下にスクロールしている分を引く）
        var movingY = visibleTargetY - keyboardFrame.minY + movingYBuffer
        if let safeAreaInsets = safeAreaInsets {
            movingY += safeAreaInsets.bottom
        }
        
        return movingY
    }
    
    /// スクロールビューのサイズをレストアする
    func restoreScrollViewSize() {
        
        guard let sv = scrollView, let contentInset = scrollViewContentInsets, let scrollIndicatorInsets = scrollViewScrollIndicatorInsets else {
            return
        }
        
        sv.scrollIndicatorInsets = scrollIndicatorInsets
        //sv.contentInset = contentInset // iOS14
        sv.contentInset = UIEdgeInsets.init(top: sv.contentInset.top, left: 0, bottom: 0, right: 0) // iOS15
    }
    
    /// スクロールビューのサイズを更新し、キーボードを表示したときに下に隠れないように、せりあげるようにする
    func updateScrollViewSize(moveSize: CGFloat, duration: TimeInterval) {
        
        guard let sv = scrollView else {
            return
        }
        
        UIView.beginAnimations("ResizeForKeyboard", context: nil)
        UIView.setAnimationDuration(duration)
        
        let contentInsets = UIEdgeInsets.init(top: sv.contentInset.top, left: 0, bottom: moveSize, right: 0) // 上、左、下、右
        sv.contentInset = contentInsets
        sv.scrollIndicatorInsets = contentInsets
        sv.contentOffset = CGPoint(x: 0, y : sv.contentOffset.y + moveSize) // 現在のスクロール地点から、さらに動く分を足して、スクロール位置を指定する

        UIView.commitAnimations()
    }
    
    // MARK: キーボードを閉じる
    
    // キーボードを閉じる時に NSNotification からコールされる
    @objc func keyboardWillHide(notification: NSNotification) {
        
        // 画面タップジェスチャを流して、テーブルビューなどのタップイベントを動作させるようにする
        tapGestureRecognizer!.cancelsTouchesInView = false
        
        // キーボードを閉じる動作は tapGesture に任せるため、ここでは、restoreScrollViewSize は行わなくてよい
    }
    
    // MARK: スクロールビューをタップする
    
    /// スクロールビューをタップしたときに UITapGestureRecognizer からコールされる。
    /// この画面では、キーボードを閉じる動作を行う。
    @objc func tapGesture(gestureRecognizer: UITapGestureRecognizer){
        
        // キーボードを閉じたくない場合に該当するときはreturn
        if let tappedView = gestureRecognizer.view {
            for view in keyBoardRemainViewArray {
                if tappedView == view {
                    return
                }
            }
        }
        
        // キーボードを閉じる
        for textField in textFieldArray {
            textField.resignFirstResponder()
        }
        
        // スクロールビューを復元する
        self.restoreScrollViewSize()
        
        // スクロールビューがタップされた旨をデリゲート元に伝える
        if let delegate = delegate, let scrollView = scrollView {
            delegate.keyBoardManagerDidTap(scrollView: scrollView)
        }
    }
    
}
