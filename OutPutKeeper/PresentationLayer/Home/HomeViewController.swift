//
//  HomeViewController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/14.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Home"
        view.backgroundColor = .white
    }
}

extension HomeViewController {
    static func createInstance() -> HomeViewController {
        let vc = UIStoryboard(name: HomeViewController.className, bundle: nil).instantiateViewController(withIdentifier: HomeViewController.className) as! HomeViewController
        return vc
    }
}
