//
//  TabBarViewController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/14.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

enum TabType: Int {
    case homeView, profileView

    var title: String {
        switch self {
        case .homeView:
            return "Home"
        case .profileView:
            return "Profile"
        }
    }
}

final class TabBarViewController: UITabBarController {

    private let homeView: UINavigationController = {
        let homeView = HomeViewController.createInstance()
        homeView.tabBarItem = UITabBarItem(title: TabType.homeView.title, image: nil, tag: TabType.homeView.rawValue)
        let homeBar = UINavigationController(rootViewController: homeView)
        return homeBar
    }()

    private let profileView: UINavigationController = {
        let profileView = ProfileViewController.createInstance()
        profileView.tabBarItem = UITabBarItem(title: TabType.profileView.title, image: nil, tag: TabType.profileView.rawValue)
        let profileBar = UINavigationController(rootViewController: profileView)
        return profileBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([homeView, profileView], animated: false)
    }
}

extension TabBarViewController {
    static func createinstance() -> TabBarViewController {
        let instance = TabBarViewController()
        return instance
    }
}
