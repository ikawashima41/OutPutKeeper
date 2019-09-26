//
//  UserAccountTranslator.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation

struct UserAccountTranslator: Translator {
    func translate(_ entity: UserAccountEntity) -> UserAccountModel {
        return UserAccountModel(entity: entity)
    }
}
