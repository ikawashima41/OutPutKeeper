//
//  UIAlertController+Extensions.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/15.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func create(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
}
