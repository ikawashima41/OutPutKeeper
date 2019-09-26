//
//  UserAccountModel.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct UserAccountModel {
    let email: String
    let authToken: String

    init(entity: UserAccountEntity) {
        self.email = entity.email
        self.authToken = entity.authToken
    }
}
