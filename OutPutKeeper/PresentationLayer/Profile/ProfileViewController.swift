//
//  ProfileViewController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/14.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import Photos
import RxSwift

final class ProfileViewController: UIViewController {

    private let leftNavBarButton: UINavigationItem = {
        let button = UINavigationItem(title: "ログアウト")
        return button
    }()

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = 10
            profileImageView.backgroundColor = .lightGray
            profileImageView.contentMode = .scaleAspectFit
        }
    }

    @IBOutlet weak var firstTitileLabel: UILabel! {
        didSet {
            firstTitileLabel.text = "ユーザーネーム"
            firstTitileLabel.textAlignment = .left
            firstTitileLabel.textColor = .gray
        }
    }

    @IBOutlet weak var userNameLabel: UILabel! {
        didSet {
            userNameLabel.textColor = .black
            userNameLabel.text = "john"
            userNameLabel.textAlignment = .left
        }
    }

    @IBOutlet weak var secondTitleLabel: UILabel! {
        didSet {
            secondTitleLabel.text = "ユーザーアドレス"
            secondTitleLabel.textAlignment = .left
            secondTitleLabel.textColor = .gray
        }
    }

    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            emailLabel.textColor = .black
            emailLabel.textAlignment = .left
            emailLabel.text = "john@gmail.com"
        }
    }

    @IBOutlet weak var selectButton: UIButton!

    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController.create()
        picker.delegate = self
        return picker
    }()

    let viewModel = ProfileViewModel()

    private let uploadImage = PublishSubject<UIImage>()

    private let disposeBag: DisposeBag = .init()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "User Profile"
        view.backgroundColor = .white
        bindUI()

    }

    private func bindUI() {

        viewModel.inputs.selectedImage
            .bind(to: self.uploadImage.asObserver())
            .disposed(by: disposeBag)

        selectButton.rx.tap
            .subscribe(onNext: { [unowned self] _ in
                guard self.checkPermission() else { return }
                self.present(self.imagePicker, animated: true)
            }).disposed(by: disposeBag)

    }

    private func checkPermission() -> Bool {
        switch PHPhotoLibrary.authorizationStatus() {
        case .authorized:
            return true
        case .denied:
            return false
        case .notDetermined:
            return false
        case .restricted:
            return false
        }
    }
}

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImageView.image = pickedImage
        }
        dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

extension ProfileViewController {
    static func createInstance() -> ProfileViewController {
        let vc = UIStoryboard(name: ProfileViewController.className, bundle: nil).instantiateViewController(withIdentifier: ProfileViewController.className) as! ProfileViewController
        return vc
    }
}

// 別ファイルにExtensionとして移行
extension UIImagePickerController {

    static func create() -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.sourceType = .photoLibrary
        return picker
    }
}

// DownloadMethod
extension ProfileViewController {
    private func download() {
        FirebaseStorageClient.shared.download(fileName: "pinterest_profile_image.png") { [unowned self] (response) in
            switch response {
            case .success(let image):
                self.profileImageView.image = image
                self.uploadImage.on(.next(image))
            case .failure(let error):
                let alert = UIAlertController.create(message: error.localizedDescription)
                self.present(alert, animated: true)
            }
        }
    }
}
