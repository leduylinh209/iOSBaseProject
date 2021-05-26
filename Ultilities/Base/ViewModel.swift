//
//  ViewModel.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

class ViewModel {
    
    let loading = RxActivityIndicator()
    let provider: DataManager
    var disposeBag = DisposeBag()
    let trackingError = PublishRelay<Error>()
    
    init(provider: DataManager) {
        self.provider = provider
    }
    
    deinit {
        #if DEBUG
        print("\(type(of: self)): Deinited")
        #endif
    }
}
