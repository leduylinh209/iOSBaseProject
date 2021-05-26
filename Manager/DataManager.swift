//
//  DataManager.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol DataManager {
    
    var isLogin: Observable<Bool> { get }
//    var profile: Observable<UserProfile?> { get }
    
    var token: String { set get }
    var memberId: String? { set get }
    
//    func loadMyProfile() throws -> Single<UserProfile?>
//    func updateMyProfile(_ profile: UserProfile?)
}
