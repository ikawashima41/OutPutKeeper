//
//  StoryBoardIdentifible.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/22.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit

protocol StoryBoardIdentifible {
    static var StoryBoardIdentifer: String { get }
}

extension StoryBoardIdentifible where Self: UIViewController {
    static var StoryBoardIdentifer: String {
        return String(describing: self)
    }
}

extension UIViewController: StoryBoardIdentifible {}

extension UIStoryboard {
    enum StoryBoard: String {
        case LaunchViewController
        case LoginViewController

        var fileName: String {
            return rawValue
        }
    }

    convenience init(storyBoard: StoryBoard, bundle: Bundle? = nil) {
        self.init(name: storyBoard.fileName, bundle: bundle)
    }

    func instantiateViewController<T: UIViewController>() -> T where T: StoryBoardIdentifible {
        guard let vc = self.instantiateViewController(withIdentifier: T.StoryBoardIdentifer) as? T else {
            fatalError("error")
        }
        return vc
    }
}
