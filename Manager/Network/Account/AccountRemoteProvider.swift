//
//  AccountRemoteProvider.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import Moya

protocol AccountRemoteProvider {
    
    func loadProfile(userId: String) -> Single<Response<UserProfile>>
    
    var token: String { get set }
}

enum AccountRemoteEndPoint {
    case loadProfile([String: String], String)
}

extension AccountRemoteEndPoint: TargetType {
    var baseURL: URL {
        return URL(string: "")!
    }
    
    var path: String {
        switch self {
        case .loadProfile:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadProfile:
            return .post
        }
    }
    
    var sampleData: Data {
        switch self {
        case .loadProfile:
            return stubberJSONFile("UserProfile")
        default:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .loadProfile(_, let userId):
            return .requestParameters(parameters: ["user_id": userId], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .loadProfile(let header, _):
            return header
        }
    }
    
}
