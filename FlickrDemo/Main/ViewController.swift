//
//  ViewController.swift
//  FlickrDemo
//
//  Created by Pony on 2020/5/28.
//  Copyright © 2020 Pony. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var Fid_text: UITextField!
    @IBOutlet weak var Fid_page: UITextField!
    @IBOutlet weak var Btn_search: UIButton!
    
    var textCount = (false, false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Fid_text.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        Fid_page.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        
        Btn_search.setDisable()
        
        self.hideKeyboardWhenTappedAround()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if textField == Fid_text {
            textCount.0 = textField.text! == "" ? false : true
        } else {
            textCount.1 = textField.text! == "" ? false : true
        }
        
        if textCount.0 && textCount.1 {
            self.Btn_search.setEnable()
        } else {
            self.Btn_search.setDisable()
        }
    }

    
    @IBAction func onClickSearch(_ sender: Any) {
        guard let text = Fid_text.text, text != "" else {
            self.displayAlert("請輸入搜尋內容")
            return
        }
        
        guard let page = Fid_page.text, page != "" else {
            self.displayAlert("請輸入呈現數量")
            return
        }
        
        let request = searchPhotoType.Request(text: text, per_page: page)
        
        api.getAPIResponse(apiURL: .searchPhoto, jsonType: request) { (isSuccess, res) in
            guard isSuccess else {
                self.APIProcessingErrorStatus(res)
                return
            }
            
            let res = res as! searchPhotoType.Response
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
            vc.searchData = res.photos.photo
            vc.result = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
