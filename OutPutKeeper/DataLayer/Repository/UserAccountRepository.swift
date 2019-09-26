//
//  UserAccountRepository.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import RxSwift

final class UserAccountRepository {

    static let shared = UserAccountRepository()
    
    private init() {}

    func login(params: LoginParams) -> Observable<UserAccountEntity> {
        return FirebaseAuthClient.shared.login(params: params)
            .do(onNext: { result in
                print(result.authToken)
                print(result.email)
            })
    }
}
