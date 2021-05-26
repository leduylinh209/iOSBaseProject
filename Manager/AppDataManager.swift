//
//  AppDataManager.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

enum DataError: Error {
    case missingMemberId
    
    var localizedDescription: String {
        switch self {
        case .missingMemberId:
            return "Require memberId to make action"
        }
    }
}

final class AppDataManager: DataManager {
    var isLogin: Observable<Bool> { return accessToken.share().map { !$0.isEmpty } }
//    var profile: Observable<UserProfile?> { return myProfile.share() }
    
    var memberId: String?
    
    var token: String {
        get {
            return accessToken.value
        }
        set {
            accessToken.accept(newValue)
        }
    }
    
    private var accountProvider: AccountRemoteProvider
    private let accessToken: BehaviorRelay<String>
//    private let myProfile = BehaviorRelay<UserProfile?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(accountProvider: AccountRemoteProvider) {
        self.accountProvider = accountProvider
        accessToken = BehaviorRelay(value: "")
        
        accessToken.subscribe(onNext: { [unowned self] (token) in
            self.accountProvider.token = token
        }).disposed(by: disposeBag)
    }
    
//    func updateMyProfile(_ profile: UserProfile?) {
//        myProfile.accept(profile)
//    }
}
