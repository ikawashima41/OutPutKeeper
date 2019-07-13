//
//  LoginViewModel.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import RxSwift
import RxCocoa

protocol LoginViewModelInputs {
    // TODO: AnyObserberに変更して外部公開
    var emailText: PublishRelay<String> { get }
    var passwordText: PublishRelay<String> { get }
}

protocol LoginViewModelOutputs {
    var valid: Observable<Bool> { get }
}

final class LoginViewModel: LoginViewModelOutputs, LoginViewModelInputs {

    // Input
    let emailText = PublishRelay<String>()
    let passwordText = PublishRelay<String>()

    // Output
    let valid: Observable<Bool>

    init() {
        let emailValid: Observable<Bool> = emailText
            .map {
                return !$0.isEmpty
            }.share(replay: 1)

        let passwordValid: Observable<Bool> = passwordText
            .map {
                return !$0.isEmpty
            }.share(replay: 1)

        valid = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
    }
}

protocol LoginViewModelType {
    var inputs: LoginViewModelInputs { get }
    var outputs: LoginViewModelOutputs { get }
}

extension LoginViewModel: LoginViewModelType {
    // viewControllerからinput/outputを介してプロパティにアクセスできるようにする。
    var inputs: LoginViewModelInputs { return self }
    var outputs: LoginViewModelOutputs { return self }
}
