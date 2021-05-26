//
//  KafkaRefresh+Rx.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import RxCocoa
import KafkaRefresh
import RxSwift

extension Reactive where Base: KafkaRefreshControl {

    public var isAnimating: Binder<Bool> {
        return Binder(self.base) { refreshControl, active in
            if active {
                refreshControl.beginRefreshing()
            } else {
                refreshControl.endRefreshing()
            }
        }
    }
}
