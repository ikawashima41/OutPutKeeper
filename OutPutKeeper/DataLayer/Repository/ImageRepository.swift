//
//  ImageRepository.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/09/01.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import RxSwift
import UIKit

final class ImageRepository {
    static let shared = ImageRepository()

    private init() {}

    func upload(image: String) -> Observable<URL> {
        return Observable<URL>.create { observer -> Disposable in
            FirebaseStorageClient.shared.upload(image: "", completion: { response in
                switch response {
                case .success(let url):
                    observer.on(.next(url))
                case .failure(let error):
                    observer.on(.error(error))
                }
            })
            return Disposables.create()
        }
    }

    func download(fileName: String) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer -> Disposable in
            FirebaseStorageClient.shared.download(fileName: fileName, completion: { response in
                switch response {
                case .success(let image):
                    observer.on(.next(image))
                case .failure(let error):
                    observer.on(.error(error))
                }
            })
            return Disposables.create()
        }
    }
}
