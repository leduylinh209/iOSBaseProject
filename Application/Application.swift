//
//  Application.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation

final class Application {
    
    static let `default` = Application(dataManager: AppDataManager(accountProvider: AccountNetworking.accountNetworking()))
    
    var dataManager: DataManager
    let navigator: Navigator
    
    init(dataManager: DataManager) {
        self.navigator = Navigator(provider: dataManager)
        self.dataManager = dataManager
    }
}
