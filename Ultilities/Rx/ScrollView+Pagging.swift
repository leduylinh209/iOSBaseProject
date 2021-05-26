//
//  ScrollView+Pagging.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol PagingIndicator {
    var headerLoading: RxActivityIndicator { get }
    var footerLoading: RxActivityIndicator { get }
}

protocol ScrollViewPaging: AnyObject {
    
    var headerRefreshTrigger: PublishRelay<Void> { get }
    var footerRefreshTrigger: PublishRelay<Void> { get }
    
    var isHeaderLoading: BehaviorRelay<Bool> { get }
    var isFooterLoading: BehaviorRelay<Bool> { get }
    
    var pagingScrollView: UIScrollView { get }
    
    var disposeBag: DisposeBag { get }
}

extension ScrollViewPaging {
    func configPaging() {
        pagingScrollView.bindGlobalStyle(forHeadRefreshHandler: { [weak self] in
            guard let `self` = self else { return }
            if self.pagingScrollView.headRefreshControl.isTriggeredRefreshByUser == false {
                self.headerRefreshTrigger.accept(())
            }
        })
        
        pagingScrollView.bindGlobalStyle(forFootRefreshHandler: { [weak self] in
            guard let `self` = self else { return }
            self.footerRefreshTrigger.accept(())
        })
        pagingScrollView.footRefreshControl.autoRefreshOnFoot = true
        
        isHeaderLoading.bind(to: pagingScrollView.headRefreshControl.rx.isAnimating)
            .disposed(by: disposeBag)
        isFooterLoading.bind(to: pagingScrollView.footRefreshControl.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func subscribePagingIndicator(_ pagingIndicator: PagingIndicator) {
        pagingIndicator.headerLoading
            .asObservable()
            .bind(to: isHeaderLoading)
            .disposed(by: disposeBag)
        
        pagingIndicator.footerLoading
            .asObservable()
            .bind(to: isFooterLoading)
            .disposed(by: disposeBag)
    }
}
