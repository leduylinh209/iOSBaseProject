//
//  ViewModelType.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
