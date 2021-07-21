//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cellDataArray: [CellData] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        collectionView.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: MyCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: MyCollectionViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewWillAppear(animated)
        
        ApiManager.init().retrieveData(completion: {(data) in
            print("\(NSStringFromClass(type(of: self))) \(#function) \(data)")
            self.cellDataArray = data
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        })
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellDataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyCollectionViewCell.identifier, for: indexPath) as! MyCollectionViewCell
        
        let cellData = cellDataArray[indexPath.row]
        cell.setText(cellData.title)
        cell.setImage(cellData.user.profile_image_url)
        cell.backgroundColor = .lightGray
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        let horizontalSpace : CGFloat = 20
        let cellSize : CGFloat = self.view.bounds.width / 2 - horizontalSpace
        return CGSize(width: cellSize, height: cellSize)
    }    
}
