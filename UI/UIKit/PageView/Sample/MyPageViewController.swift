//
//  MyPageViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class MyPageViewController: UIPageViewController {

    var vcs: [UIViewController] = []
    var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        let firstVC = storyboard!.instantiateViewController(withIdentifier: "FirstViewController") as! FirstViewController
        let secondVC = storyboard!.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        let ThirdVC = storyboard!.instantiateViewController(withIdentifier: "ThirdViewController") as! ThirdViewController
        vcs = [ firstVC, secondVC, ThirdVC ]
        setViewControllers([vcs[0]], direction: .forward, animated: true, completion: nil) // 最初に表示
        
        // PageControl
        pageControl = UIPageControl(frame: CGRect(x:0, y:self.view.frame.height - 80, width:self.view.frame.width, height:50))
        pageControl.currentPage = 0
        pageControl.numberOfPages = vcs.count
        pageControl.isUserInteractionEnabled = false
        pageControl.backgroundColor = .clear
        self.view.addSubview(pageControl)
    }
}

extension MyPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.vcs.count
    }
    
    // go forward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let index = vcs.firstIndex(of: viewController), index < vcs.count - 1 {
            pageControl.currentPage = index + 1
            return vcs[index + 1]
        }
        return nil
    }

    // go backward
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        if let index = vcs.firstIndex(of: viewController),
            index > 0 {
            pageControl.currentPage = index - 1
            return vcs[index - 1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating: Bool, previousViewControllers: [UIViewController], transitionCompleted: Bool) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
    }
}
