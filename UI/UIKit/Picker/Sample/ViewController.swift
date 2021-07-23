//
//  ViewController.swift
//  Sample
//
//  Created by Yamaguchi on 2021/07/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField1: UITextField!
    let pickerView1 = UIPickerView()
    let pickerList = ["東京都", "神奈川県", "埼玉県", "千葉県", "群馬県", "栃木県", "茨城県"]
    
    @IBOutlet weak var textField2: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        preparePickerView()
        prepareDatePicker()
    }
    
    func preparePickerView() {
        
        // PickerView（都道府県）
        pickerView1.delegate = self
        pickerView1.dataSource = self
        let toolbar1 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem1 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didFinishTextField1))
        toolbar1.setItems([spacelItem1, doneItem1], animated: true)
        textField1.inputAccessoryView = toolbar1
        textField1.inputView = pickerView1
    }

    @objc func didFinishTextField1() {
        
        textField1.endEditing(true)
        textField1.text = pickerList[pickerView1.selectedRow(inComponent: 0)]
    }
    
    func prepareDatePicker() {
        
        // DatePicker
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        //datePicker.preferredDatePickerStyle = .wheels // iOS14から
        let toolbar2 = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem2 = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didFinishTextField2))
        toolbar2.setItems([spacelItem2, doneItem2], animated: true)
        textField2.inputAccessoryView = toolbar2
        textField2.inputView = datePicker
    }
    
    @objc func didFinishTextField2() {
        
        textField2.endEditing(true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat  = "yyyy/MM/dd HH:mm";
        textField2.text = dateFormatter.string(from: datePicker.date)
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }
}

