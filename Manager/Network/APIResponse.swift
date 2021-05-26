//
//  APIResponse.swift
//  BaseProject
//
//  Created by linhld on 26/05/2021.
//

import Foundation

class ArrayResponse<T: Decodable>: Decodable {
    let success: Bool
    let message: String?
    let data: [T]
}

class Response<T: Decodable>: Decodable {
    let success: Bool
    let message: String?
    let data: T
}
