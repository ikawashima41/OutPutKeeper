//
//  UserAccountUseCase.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import RxSwift

final class UserAccountUseCase {

    private let repository: UserAccountRepository

    init(repository: UserAccountRepository) {
        self.repository = repository
    }

    func login(params: LoginParams) -> Observable<UserAccountModel>{
        return repository
                .login(params: params)
                .map { UserAccountTranslator().translate($0) }
    }
}
