//
//  UIViewController.swift
//  FlickrDemo
//
//  Created by Pony on 2020/5/28.
//  Copyright © 2020 Pony. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    /// Api Alert
    func APIProcessingErrorStatus(_ response: Encodable, alertActionHandle: ((_ APIStatus: APIStatus)->Void)? = nil) {
        let res = response as! APIStatus
        
        let alert = UIAlertController(title: res.message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "確認", style: .default, handler: { (action) in
            if let alertAction = alertActionHandle{
                alertAction(res)
            }
        }))
        present(alert, animated: true)
    }
    
    
    /// [C] Hide key board
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// show alert
    func displayAlert(_ title: String, message: String = "", btnStr: String = "OK", alertActionHandle: (()->Void)? = nil) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: btnStr, style: UIAlertAction.Style.default, handler: { action in
            if let alertAction = alertActionHandle {
                alertAction()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}
