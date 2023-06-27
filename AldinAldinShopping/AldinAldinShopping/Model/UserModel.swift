//
//  UserModel.swift
//  AldinAldinShopping
//
//  Created by Mustafa Aktas on 27.06.2023.
//

import Foundation


struct User: Codable {
    var id: String?
    var username: String?
    var email: String?
    var cart: [Int : Int]?
}
