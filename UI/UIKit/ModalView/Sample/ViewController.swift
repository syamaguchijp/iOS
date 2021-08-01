//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    
    let sb = UIStoryboard(name: "Main", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton1(_ sender: Any) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let vc = sb.instantiateViewController(withIdentifier: "ModalViewController")
        // https://developer.apple.com/library/archive/featuredarticles/ViewControllerPGforiPhoneOS/PresentingaViewController.html#//apple_ref/doc/uid/TP40007457-CH14-SW1
        vc.modalPresentationStyle = .formSheet
        vc.isModalInPresentation = false // trueにするとスワイプで消えなくなる
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapButton2(_ sender: Any) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let vc = sb.instantiateViewController(withIdentifier: "ModalViewController")
        vc.modalPresentationStyle = .pageSheet
        vc.isModalInPresentation = false
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapButton3(_ sender: Any) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let vc = sb.instantiateViewController(withIdentifier: "ModalViewController")
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapButton4(_ sender: Any) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let vc = HalfModalViewController(nibName: "HalfModalViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.modalPresentationStyle = .overCurrentContext // この設定をしないと遷移後に透明部分が黒くなってしまう
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func didTapButton5(_ sender: Any) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let vc = ScrollViewController(nibName: "ScrollViewController", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}

