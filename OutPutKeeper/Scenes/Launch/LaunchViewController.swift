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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let vc = UIStoryboard(name: LoginViewController.className, bundle: nil).instantiateViewController(withIdentifier: LoginViewController.className)
        let nc = UINavigationController(rootViewController: vc)
        self.present(nc, animated: true)

    }
}

extension LaunchViewController {
    static func createInstance() -> LaunchViewController {
        let vc = UIStoryboard(name: LaunchViewController.className, bundle: nil).instantiateViewController(withIdentifier: LaunchViewController.className) as! LaunchViewController
        return vc
    }
}
