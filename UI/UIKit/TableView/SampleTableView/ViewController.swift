//
//  ViewController.swift
//  SampleTableView
//
//  Copyright © 2021年 Yamaguchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let labelTextArray = ["吾輩は猫である。名前はまだ無い。",
                                  "どこで生れたかとんと見当がつかぬ。何でも薄暗いじめじめした所でニャーニャー泣いていた事だけは記憶している。",
                                  """
吾輩はここで始めて人間というものを見た。\
しかもあとで聞くとそれは書生という人間中で一番獰悪どうあくな種族であったそうだ。\
この書生というのは時々我々を捕つかまえて煮にて食うという話である。\
しかしその当時は何という考もなかったから別段恐しいとも思わなかった。\
ただ彼の掌てのひらに載せられてスーと持ち上げられた時何だかフワフワした感じがあったばかりである。
""",
                                  """
掌の上で少し落ちついて書生の顔を見たのがいわゆる人間というものの見始みはじめであろう。\
この時妙なものだと思った感じが今でも残っている。\
第一毛をもって装飾されべきはずの顔がつるつるしてまるで薬缶やかんだ。\
その後ご猫にもだいぶ逢あったがこんな片輪かたわには一度も出会でくわした事がない。\
のみならず顔の真中があまりに突起している。\
そうしてその穴の中から時々ぷうぷうと煙けむりを吹く。\
どうも咽むせぽくて実に弱った。これが人間の飲む煙草たばこというものである事はようやくこの頃知った。\
この書生の掌の裏うちでしばらくはよい心持に坐っておったが、しばらくすると非常な速力で運転し始めた。\
書生が動くのか自分だけが動くのか分らないが無暗むやみに眼が廻る。胸が悪くなる。\
到底とうてい助からないと思っていると、どさりと音がして眼から火が出た。\
それまでは記憶しているがあとは何の事やらいくら考え出そうとしても分らない。
ふと気が付いて見ると書生はいない。たくさんおった兄弟が一疋ぴきも見えぬ。肝心かんじんの母親さえ姿を隠してしまった。\
その上今いままでの所とは違って無暗むやみに明るい。眼を明いていられぬくらいだ。\
はてな何でも容子ようすがおかしいと、のそのそ這はい出して見ると非常に痛い。吾輩は藁わらの上から急に笹原の中へ棄てられたのである。
""",]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        /*
        // Self-Sizingを無効にするには
        // セルの高さ
        tableView.estimatedRowHeight = 0
        // セクションヘッダー
        tableView.estimatedSectionHeaderHeight = 0
        // セクションフッター
        tableView.estimatedSectionFooterHeight = 0
         */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.tableView.flashScrollIndicators()
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelTextArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCustomCell", for: indexPath) as! MyCustomCell
        cell.myLabel.text = labelTextArray[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

