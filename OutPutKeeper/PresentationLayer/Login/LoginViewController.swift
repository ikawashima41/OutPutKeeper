//
//  LoginViewController.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel! {
        didSet {
            emailLabel.text = "email"
        }
    }

    @IBOutlet weak var emailTextField: UITextField! {
        didSet {
            emailTextField.layer.cornerRadius = 8
        }
    }

    @IBOutlet weak var passwordLabel: UILabel! {
        didSet {
            passwordLabel.text = "password"
        }
    }

    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.isSecureTextEntry = true
            passwordTextField.layer.cornerRadius = 8
        }
    }

    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.setTitle("Login", for: .normal)
            loginButton.titleLabel?.textColor = .white
            loginButton.backgroundColor = .blue
            loginButton.layer.cornerRadius = 10
            loginButton.isHidden = true
        }
    }

    let viewModel = LoginViewModel(dependency: UserAccountRepository.shared)
    private let disposeBag: DisposeBag = .init()



    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Login view"
        bindUI()
    }

    private func bindUI() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.emailText)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.inputs.passwordText)
            .disposed(by: disposeBag)

        loginButton.rx.tap
            .bind(to: viewModel.inputs.loginTrigger)
            .disposed(by: disposeBag)

        viewModel.outputs.valid
            .skip(1)
            .subscribe(onNext: { [unowned self] value in
                self.loginButton.isHidden = !value
            }).disposed(by: disposeBag)
        
        viewModel.outputs.result
            .subscribe(onNext: { _ in
                let vc = TabBarViewController()
                self.present(vc, animated: true)
            }).disposed(by: disposeBag)

        viewModel.outputs.error
            .subscribe(onNext: { error in
                print(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}

extension LoginViewController {
    static func createInstance() -> LoginViewController {
        let st = UIStoryboard(storyBoard: .LoginViewController)
        let vc: LoginViewController = st.instantiateViewController()
        return vc
    }
}
