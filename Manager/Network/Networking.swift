//
//  Networking.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON

class DefaultSessionManager: Session {
    static let shared: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.headers = .default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        return Session(configuration: configuration, startRequestsImmediately: false)
    }()
}

class RemoteProvider<Target> where Target: Moya.TargetType {
    fileprivate let provider: MoyaProvider<Target>
    
    init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider<Target>.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<Target>.RequestClosure = MoyaProvider<Target>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider<Target>.neverStub,
         session: Session = DefaultSessionManager.shared,
         plugins: [PluginType] = [],
         trackInflights: Bool = false) {
        self.provider = MoyaProvider(endpointClosure: endpointClosure,
                                     requestClosure: requestClosure,
                                     stubClosure: stubClosure,
                                     session: session,
                                     plugins: plugins,
                                     trackInflights: trackInflights)
    }
    
    func request(_ token: Target) -> Single<Moya.Response> {
        return provider.rx
            .request(token)
    }
    
    func requestJSON(_ token: Target) -> Single<JSON> {
        return request(token).map { (response) -> JSON in
            try JSON(data: response.data)
        }
    }
}

protocol NetworkingType {
    associatedtype T: TargetType
    var provider: RemoteProvider<T> { get }
    var token: String { get set }
}

extension NetworkingType {
    func prepareHeader(_ header: [String: String]? = nil) -> [String: String] {
        var params = [String: String]()
        if !token.isEmpty {
            params["Authorization"] = ("Token \(token)")
        }
        if let header = header {
            header.forEach { (k,v) in params[k] = v }
        }
        return params
    }
}

extension NetworkingType {
    static func endpointsClosure<T>() -> (T) -> Endpoint where T: TargetType {
        return { target in
            let endpoint = MoyaProvider.defaultEndpointMapping(for: target)
            // Sign all non-XApp, non-XAuth token requests
            return endpoint
        }
    }
    
    static func APIKeysBasedStubBehaviour<T>(_: T) -> Moya.StubBehavior {
        return .never
    }
    
    static var plugins: [PluginType] {
        var plugins: [PluginType] = []
        #if DEBUG
        plugins.append(loggerPlugin())
        #endif
        return plugins
    }
    
    static func loggerPlugin() -> NetworkLoggerPlugin {
        let logger = NetworkLoggerPlugin()
        logger.configuration.logOptions = .verbose
        return logger
    }
    
    // (Endpoint<Target>, NSURLRequest -> Void) -> Void
    static func endpointResolver() -> MoyaProvider<T>.RequestClosure {
        return { (endpoint, closure) in
            do {
                var request = try endpoint.urlRequest() // endpoint.urlRequest
                request.httpShouldHandleCookies = false
                closure(.success(request))
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    static func newProvider<T>(_ plugins: [PluginType]) -> RemoteProvider<T> {
        return RemoteProvider(endpointClosure: endpointsClosure(),
                              requestClosure: endpointResolver(),
                              stubClosure: APIKeysBasedStubBehaviour,
                              plugins: plugins)
    }
}

func stubberJSONFile(_ filename: String) -> Data {
    @objc class TestClass: NSObject {}
    guard let path = Bundle(for: TestClass.self).path(forResource: filename, ofType: "json") else { fatalError("Not exist sample data file name: \(filename)") }
    return try! Data(contentsOf: URL(fileURLWithPath: path))
}
