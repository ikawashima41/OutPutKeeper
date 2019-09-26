//
//  Translator.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

protocol Translator {
    associatedtype Input
    associatedtype OutPut

    func translate(_: Input) -> OutPut
}
