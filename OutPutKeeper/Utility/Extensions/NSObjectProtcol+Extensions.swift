//
//  NSObjectProtcol+Extensions.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

// class名の取得
extension NSObjectProtocol {
    static var className: String {
        return String(describing: self)
    }
}
