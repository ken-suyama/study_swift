//
//  User.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

class User: Codable {
    let id: String
    let email: String
    let password: String
    let name: String
    let nickname: String
    let iconUrl: String?
    let createdAt: String
    let updatedAt: String
    
    init(_ id: String, _ email: String, _ password: String, _ name: String, _ nickname: String, _ iconUrl: String?, _ createdAt: String, _ updatedAt: String) {
        self.id = id
        self.email = email
        self.password = password
        self.name = name
        self.nickname = nickname
        self.iconUrl = iconUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}
