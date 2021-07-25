//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        let snackBar = SnackBarView.init(labelText: "BBBBBBB", buttonText: "GO")
        
        
    snackBar.labelText = "Lorem ipsum dolorはamet、conittetur adipiscing elit、sedおよびeidmid tempor incididuntのいずれかを使用します。 最小限の努力で、運動障害を起こさないようにしましょう。 自信を持ってvelit esse cillum dolore eu fugiat nulla pariaturでの代理店でのDuis自動アイレア色。 excepteur sint occaecat cupidatat non-proident、カルパ・クィ・オフィシアでの融資を受けていません。Lorem ipsum dolorはamet、conittetur adipiscing elit、sedおよびeidmid tempor incididuntのいずれかを使用します。 最小限の努力で、運動障害を起こさないようにしましょう。 自信を持ってvelit esse cillum dolore eu fugiat nulla pariaturでの代理店でのDuis自動アイレア色。 excepteur sint occaecat cupidatat non-proident、カルパ・クィ・オフィシアでの融資を受けていません。Lorem ipsum dolorはamet、conittetur adipiscing elit、sedおよびeidmid tempor incididuntのいずれかを使用します。 最小限の努力で、運動障害を起こさないようにしましょう。 自信を持ってvelit esse cillum dolore eu fugiat nulla pariaturでの代理店でのDuis自動アイレア色。 excepteur sint occaecat cupidatat non-proident、カルパ・クィ・オフィシアでの融資を受けていません。"
        
        snackBar.start(baseView: self.view)
        
    }


}

