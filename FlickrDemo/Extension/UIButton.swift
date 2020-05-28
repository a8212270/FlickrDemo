//
//  UIButton.swift
//  FlickrDemo
//
//  Created by Pony on 2020/5/28.
//  Copyright © 2020 Pony. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setDisable() {
        self.backgroundColor = .lightGray
        self.isEnabled = false
    }
    
    func setEnable() {
        self.backgroundColor = .blue
        self.isEnabled = true
    }
}
