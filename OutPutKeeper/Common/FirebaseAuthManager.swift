//
//  FirebaseAuthManager.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/13.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import FirebaseAuth

struct FirebaseAuthManager {

    static func login(params: LoginParams) {
        Auth.auth().createUser(withEmail: params.email, password: params.passsword, completion: { authResult, error in
            // TODO: error handling
        })
    }
}

struct LoginParams {
    let email: String
    let passsword: String
}
