//
//  Result.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift

enum Result<T> {
    case success(T)
    case failure(Error)
}

extension ObservableType {
    func mapToResult() -> Observable<Result<Element>> {
        return self.map { Result<Element>.success($0) }
            .catchError{ Observable.just(Result<Element>.failure($0)) }
    }
}
