//
//  NavigationController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class NavigationController: UINavigationController {
    private var statusBarStyle = UIStatusBarStyle.default
    private var statusBarHidden = true

    override func viewDidLoad() {
        super.viewDidLoad()
        //delegate = self
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }

    override var prefersStatusBarHidden: Bool {
        return statusBarHidden
    }
}

extension NavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        statusBarStyle  = viewController.preferredStatusBarStyle
        statusBarHidden = viewController.prefersStatusBarHidden
        setNeedsStatusBarAppearanceUpdate()
    }
}
