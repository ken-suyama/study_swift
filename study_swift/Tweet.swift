//
//  Tweet.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

class Tweet: Codable {
    let id: Int
    let content: String
    let imageUrl: String?
    let createdAt: String
    let updatedAt: String
    let userId: String
    let user: User
    let comments: [Comment?]
    
    init(_ id: Int, _ content: String, _ imageUrl: String?, _ createdAt: String, _ updatedAt: String, _ userId: String, _ user: User, _ comments: [Comment?]) {
        self.id = id
        self.content = content
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.user = user
        self.comments = comments
    }
}
