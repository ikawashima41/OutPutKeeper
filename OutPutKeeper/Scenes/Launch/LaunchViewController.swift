import UIKit

final class LaunchViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.image = UIImage(named: "logo.png")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension LaunchViewController {
    static func createInstance() -> LaunchViewController {
        let vc = UIStoryboard(name: LaunchViewController.className, bundle: nil).instantiateViewController(withIdentifier: LaunchViewController.className) as! LaunchViewController
        return vc
    }
}
