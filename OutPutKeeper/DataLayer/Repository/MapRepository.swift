//
//  MapRepository.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import RxSwift

final class MapRepository {
    static let shared = MapRepository()

    private init() {}

    func request() -> Observable<NSDictionary> {
        return Observable<NSDictionary>.create({ observer -> Disposable in
            APIClient.httpRequest(endpoint: "", method: .GET, parameters: ["" : "" as! AnyObject]) { response in
                switch response {
                case .success(let res):
                    observer.on(.next(res))
                case .error(let error):
                    observer.on(.error(error))
                }
            }
            return Disposables.create()
        })
    }
}
