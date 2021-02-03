//
//  SlideMenuLeftViewController.swift
//  SampleSlideMenu
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

/// スライドメニューの左側メニューを司るクラス
class SlideMenuLeftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    private let slideMenuRowCount: Int = 4
    private let slideMenuRowHeight: CGFloat = 60.0
    private let slideMenuBackgroundColor = UIColor(red: 68.0, green: 68.0, blue: 68.0, alpha: 1.0)
    private let selectedTextColor = UIColor.red
    private let deselectedTextColor = UIColor.black
    private let headerViewHeight: CGFloat = 60.0
    
    private var footerViewHeight: CGFloat = 0.0
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.bounces = false
        tableView.isScrollEnabled = false
        
        // 画面をタップした際にスライドメニューを閉じるようにする
        let tapRecognizerSelfView = UITapGestureRecognizer(target: self, action: #selector(self.didTapSelfView(sender:)))
        tapRecognizerSelfView.delegate = self
        self.view.addGestureRecognizer(tapRecognizerSelfView)
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        // フッタービューに付与すべき高さを設定する
        footerViewHeight = tableView.frame.size.height - slideMenuRowHeight * CGFloat(slideMenuRowCount) - headerViewHeight
        
        // シャドウをつけ、メニュー部分とのフリンジを際立たせる
        let caLayer = self.view.layer
        caLayer.shadowOpacity = 1.0 // 影の透明度
        caLayer.shadowRadius = 1.0 // ぼかしの量
        caLayer.shadowOffset = CGSize(width: 0.0, height: 0.0) // 影のかかる方向
        caLayer.rasterizationScale = UIScreen.main.scale
        caLayer.shouldRasterize = true
        caLayer.masksToBounds = false
    }
    
    // MARK: TableView Delegate
    
    /// ヘッダービューの高さを設定する
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerViewHeight
    }
    
    /// フッタービューの高さを設定する
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return footerViewHeight
    }
    
    /// フッタービューを生成する
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: footerViewHeight))
        footerView.backgroundColor = UIColor.clear
        
        let separateLine = UIView(frame: CGRect(x: 0.0, y: 0.0, width: tableView.bounds.size.width, height: 1.0))
        separateLine.backgroundColor = UIColor(red: 34.0 / 255.0, green: 34.0 / 255.0, blue: 34.0 / 255.0, alpha: 0.5)
        footerView.addSubview(separateLine)
        
        return footerView
    }
    
    /// 行数を設定する
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return slideMenuRowCount
    }
    
    /// 行の高さを設定する
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return slideMenuRowHeight
    }
    
    /// 行のセルを生成する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.frame = CGRect(x: 0.0, y: 0.0, width: self.view.bounds.size.width, height: slideMenuRowHeight)
        cell.backgroundColor = UIColor.clear
        cell.selectionStyle = .none//.default
        
        cell.textLabel?.text = SlideMenuController.shared.menus[indexPath.row].title
        
        return cell
    }
    
    /// テーブルビューの行をタップした時にコールされる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 選択されているセルの文字色を変更
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = selectedTextColor
        
        // メニューを閉じる
        SlideMenuController.shared.closeMenu()
        
        // 選択された行に従って処理する
        SlideMenuController.shared.currentIndex = indexPath.row
        if let vc = SlideMenuController.shared.rightMainViewController as? ViewController {
            vc.loadWebView()
        }
        
        


    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // セルの選択が外れた時に文字色を戻す
        tableView.cellForRow(at: indexPath)?.textLabel?.textColor = deselectedTextColor
    }
    
    // MARK: Tap Event
    
    // 画面全体をタップした時にコールされる
    @objc func didTapSelfView(sender: UITapGestureRecognizer) {
        
        // スライドメニューを閉じる
        SlideMenuController.shared.closeMenu()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if gestureRecognizer is UITapGestureRecognizer {
            let location = touch.location(in: tableView)
            if tableView.indexPathForRow(at: location) != nil {
                return false
            }
        }
        return true
    }

}
