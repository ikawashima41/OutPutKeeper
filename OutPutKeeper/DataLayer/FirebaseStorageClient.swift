//
//  FirebaseStorageManager.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/14.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import FirebaseStorage

enum UploadResult<URL> {
    case success(URL)
    case failure(Error)
}

enum DownLodReuslt<UIImage> {
    case success(UIImage)
    case failure(Error)
}

final class FirebaseStorageClient {

    typealias UploadHandler = (UploadResult<URL>) -> Void
    typealias DownLoadHandler = (DownLodReuslt<UIImage>) -> Void

    static let shared = FirebaseStorageClient()

    private init() {}

    func upload(image: String, completion: @escaping UploadHandler) {
        let ref = self.setStorage(imageName: image)

        let localFile = URL(fileURLWithPath: image)
        ref.putFile(from: localFile, metadata: nil) { metadata, error in

            guard let metadata = metadata else { return }
            let size = metadata.size
            
            ref.downloadURL { (url, error) in
                if let error = error {
                    completion(.failure(error))
                }

                guard let downloadURL = url else {
                    return
                }
                completion(.success(downloadURL))
            }
        }
    }

    func download(fileName: String, completion: @escaping DownLoadHandler) {
        let ref = self.setStorage(imageName: fileName)

        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            completion(.success(image))

        }
    }

    private func setStorage(imageName: String) -> StorageReference {
        let storage = Storage.storage()
        let storageRef = storage.reference().child(imageName)
        return storageRef
    }
}
