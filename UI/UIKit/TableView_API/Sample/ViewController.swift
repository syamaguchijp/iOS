//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/06/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    private var rowDataArray: [RowData] = []
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        removeEmptyCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print("\(NSStringFromClass(type(of: self))) \(#function)")
        
        super.viewWillAppear(animated)
        
        indicatorView.startAnimating()
        
        ApiManager.init().retrieveData(completion: {(data) in
            self.rowDataArray = data
            DispatchQueue.main.async {
                self.indicatorView.stopAnimating()
                self.tableView.reloadData()
                self.removeEmptyCell()
            }
        })
    }
    
    func removeEmptyCell() {
        
        tableView.tableFooterView = UIView.init(frame: CGRect.zero)
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) \(rowDataArray.count)")
        return rowDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("\(NSStringFromClass(type(of: self))) \(#function) indexPath.row=\(indexPath.row)")
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MyCustomCell.identifier, for: indexPath) as! MyCustomCell
        
        let rowData = rowDataArray[indexPath.row]
        cell.myLabel?.text = rowData.title
        let url = URL(string: rowData.user.profile_image_url)
        do {
            let imageData = try Data(contentsOf: url!)
            cell.myImageView?.image = UIImage(data: imageData)
        } catch {
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
