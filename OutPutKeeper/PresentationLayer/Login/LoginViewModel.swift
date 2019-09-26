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
    // 入力（書き込み）だけ可能にするためAnyObserverで定義
    var emailText: AnyObserver<String> { get }
    var passwordText: AnyObserver<String> { get }
    var loginTrigger: AnyObserver<Void> { get }
}

protocol LoginViewModelOutputs {
    var valid: Observable<Bool> { get }
    var result: Observable<UserAccountEntity> { get }
    var error: Observable<Error> { get }
}

final class LoginViewModel: LoginViewModelOutputs, LoginViewModelInputs {

    // input
    let emailText: AnyObserver<String>
    let passwordText: AnyObserver<String>
    let loginTrigger: AnyObserver<Void>

    // Output
    let valid: Observable<Bool>
    let result: Observable<UserAccountEntity>
    let error: Observable<Error>

    private let dependency: UserAccountRepository!

    private let disposeBag: DisposeBag = .init()

    init(dependency: UserAccountRepository) {
        self.dependency = dependency

        let _emailText = PublishRelay<String>()
        self.emailText = AnyObserver<String>() { event in
            guard let event = event.element else { return }
            _emailText.accept(event)
        }

        let _passwordText = PublishRelay<String>()
        self.passwordText = AnyObserver<String>() { event in
            guard let event = event.element else { return }
            _passwordText.accept(event)
        }

        let _loginTrigger = PublishRelay<Void>()
        self.loginTrigger = AnyObserver<Void>() { event in
            guard let event = event.element else { return }
            _loginTrigger.accept(event)
        }

        let _result = PublishRelay<UserAccountEntity>()
        self.result = _result.asObservable()

        let _error = PublishRelay<Error>()
        self.error = _error.asObservable()

        let emailValid: Observable<Bool> = _emailText
            .map {
                return !$0.isEmpty
            }.share(replay: 1)

        let passwordValid: Observable<Bool> = _passwordText
            .map {
                return !$0.isEmpty
            }.share(replay: 1)

        valid = Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }

        let parameters = Observable.combineLatest(_emailText, _passwordText)

        let result = _loginTrigger
            .withLatestFrom(parameters)
            .flatMap { (email, password) -> Observable<Event<UserAccountEntity>> in
                dependency.login(params: LoginParams(email: email, passsword: password))
                .materialize()
            }.share(replay: 1)

        result
            .flatMap { $0.element.map(Observable.just) ?? .empty() }
            .bind(to: _result)
            .disposed(by: disposeBag)

        result
            .flatMap { $0.error.map(Observable.just) ?? .empty() }
            .bind(to: _error)
            .disposed(by: disposeBag)
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
