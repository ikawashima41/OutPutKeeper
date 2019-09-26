//
//  ProfileViewModel.swift
//  OutPutKeeper
//
//  Created by Iichiro Kawashima on 2019/07/14.
//  Copyright © 2019 Iichiro Kawashima. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol ProfileViewModelInputs {
    var selectedImage: Observable<UIImage> { get }
}

protocol ProfileViewModelOutputs {
    
}

final class ProfileViewModel: ProfileViewModelInputs, ProfileViewModelOutputs {

    let selectedImage: Observable<UIImage>

    init() {
        let _selectedImage = PublishRelay<UIImage>()
        self.selectedImage = _selectedImage.asObservable()
    }
}

protocol ProfileViewModelTypes {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

extension ProfileViewModel: ProfileViewModelTypes {
    var outputs: ProfileViewModelOutputs { return self }
    var inputs: ProfileViewModelInputs { return self }
}
