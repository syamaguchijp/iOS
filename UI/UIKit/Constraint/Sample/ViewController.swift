//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2022/07/06.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let view1 = UIView()
        view1.backgroundColor = .red
        view1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view1)
        NSLayoutConstraint.activate([
            view1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            view1.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            view1.heightAnchor.constraint(equalToConstant: 50.0),
            view1.widthAnchor.constraint(equalToConstant: 50.0)
        ])
        
        let view2 = UIView()
        view2.backgroundColor = .yellow
        view2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view2)
        NSLayoutConstraint.activate([
            view2.leadingAnchor.constraint(equalTo: view1.trailingAnchor, constant: 10),
            view2.topAnchor.constraint(equalTo: view1.topAnchor),
            view2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            view2.heightAnchor.constraint(equalTo: view1.heightAnchor, multiplier: 0.5)
        ])
        
        let view3 = UIView()
        view3.backgroundColor = .green
        view3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(view3)
        NSLayoutConstraint.activate([
            view3.topAnchor.constraint(equalTo: view1.bottomAnchor, constant: 10),
            view3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            view3.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            view3.heightAnchor.constraint(equalToConstant: 30.0)
        ])
        
        
    }
}

