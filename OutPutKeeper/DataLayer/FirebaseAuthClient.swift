//
//  FirebaseAuthManager.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import FirebaseAuth
import RxSwift

struct LoginParams {
    let email: String
    let passsword: String
}

enum FireBaseResult<Value> {
    case success(Value)
    case error(Error)
}

final class FirebaseAuthClient {

    typealias LoginHandler = (FireBaseResult<UserAccountEntity>) -> Void

    static let shared = FirebaseAuthClient()
    private init() {}

    private let auth = Auth.auth()

    var currentId: String? {
        return auth.currentUser?.uid
    }

    func login(params: LoginParams) -> Observable<UserAccountEntity> {
        return Observable<UserAccountEntity>.create { observer -> Disposable in
            self.auth.createUser(withEmail: params.email, password: params.passsword, completion: { authResult, error in
                // TODO: error handling

                if let error = error {
                    observer.onError(error)
                }
                guard let email = authResult?.user.email, let uid = authResult?.user.uid else { return }

                observer.onNext(UserAccountEntity(email: email, authToken: uid))
            })
            return Disposables.create()
        }
    }

    func logout(completion: @escaping (FireBaseResult<()>) -> Void) throws {
        do {
            try auth.signOut()
            completion(.success(()))
        } catch {
            completion(.error(error))
        }
    }
}
