//
//  NavigationController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
