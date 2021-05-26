//
//  AccountNetworking.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import Moya

struct AccountNetworking: NetworkingType {
    
    typealias T = AccountRemoteEndPoint
    let provider: RemoteProvider<AccountRemoteEndPoint>
    var token: String = ""
}

extension NetworkingType {
    static func accountNetworking() -> AccountNetworking {
        return AccountNetworking(provider: newProvider(plugins))
    }
}

extension AccountNetworking: AccountRemoteProvider {
    func loadProfile(userId: String) -> Single<Response<UserProfile>> {
        return provider.request(.loadProfile(prepareHeader(), userId)).map(Response<UserProfile>.self)
    }
}
