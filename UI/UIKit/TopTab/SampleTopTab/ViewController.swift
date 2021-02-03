//
//  ViewController.swift
//  SampleTopTab
//
//  Created by Yamaguchi on 2021/01/13.
//

import UIKit

class ViewController: UIViewController {

    // 画面上部のタブ部分
    @IBOutlet weak var tabCollectionView: UICollectionView!
    // 画面中央のコンテンツ領域
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    private let tabCellIdentifier = "TabCell"
    private let contentCellIdentifier = "ContentCell"
    private let tabCellHeight = CGFloat(40)
    private let tabCellWidth = CGFloat(100)
    
    private var tabNames = [String]()
    private var contentVCs = [UIViewController]()
    private var currentIndex = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        generateContents()
        
        tabCollectionView.dataSource = self
        tabCollectionView.delegate = self
        
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.isPagingEnabled = true
    }
    
    private func generateContents() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let webVC1 = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC1.url = "https://www.apple.com/jp/"
        tabNames.append("Apple")
        contentVCs.append(webVC1)
        
        let webVC2 = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC2.url = "https://google.com"
        tabNames.append("Google")
        contentVCs.append(webVC2)
        
        let webVC3 = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC3.url = "https://youtube.com"
        tabNames.append("YouTube")
        contentVCs.append(webVC3)
        
        let webVC4 = storyboard.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        webVC4.url = "https://twitter.com"
        tabNames.append("Twitter")
        contentVCs.append(webVC4)
    }
    
    private func setCurrentIndex(index: Int, animated: Bool) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) current=\(index)")
        
        currentIndex = index
        let path = IndexPath(item: currentIndex, section: 0)
        
        self.tabCollectionView.reloadData()
        
        guard let rect = self.contentCollectionView.layoutAttributesForItem(at: path)?.frame else {
            return
        }
        
        self.contentCollectionView.scrollRectToVisible(rect, animated: animated)
        self.contentCollectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        return contentVCs.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")

        if collectionView == tabCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tabCellIdentifier, for: indexPath) as! TabCollectionViewCell
            cell.nameLabel.text = tabNames[indexPath.row]
            cell.select(isSelected: currentIndex == indexPath.row)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contentCellIdentifier, for: indexPath)
        let contentVC = contentVCs[indexPath.row]
        
        cell.addSubview(contentVC.view)
        contentVC.view.translatesAutoresizingMaskIntoConstraints = false
        contentVC.view.topAnchor.constraint(equalTo: cell.topAnchor, constant: 0).isActive = true
        contentVC.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: 0).isActive = true
        contentVC.view.leadingAnchor.constraint(equalTo: cell.leadingAnchor).isActive = true
        contentVC.view.trailingAnchor.constraint(equalTo: cell.trailingAnchor).isActive = true
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        setCurrentIndex(index: indexPath.row, animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if scrollView == contentCollectionView {
            let newIndex = Int(self.contentCollectionView.contentOffset.x / contentCollectionView.frame.size.width)
            
            var animated = true
            if currentIndex == newIndex {
                // 右端の最後のページのため一番左端に戻す
                currentIndex = 0
                animated = false
            } else {
                currentIndex = newIndex
            }
            setCurrentIndex(index: currentIndex, animated: animated)
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if collectionView == tabCollectionView {
            return CGSize(width: tabCellWidth, height: tabCellHeight)
        }

        return CGSize(width: view.frame.width, height: view.frame.height - tabCellHeight - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
}
