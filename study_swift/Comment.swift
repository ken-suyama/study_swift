//
//  Comment.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

class Comment: Codable {
    let id: Int
    let content: String
    let imageUrl: String?
    let createdAt: String
    let updatedAt: String
    let userId: String
    let user: User
    let tweetId: Int
//    let tweet: Tweet
    
    init(_ id: Int, _ content: String, _ imageUrl: String?, _ createdAt: String, _ updatedAt: String, _ userId: String, _ user: User, _ tweetId: Int) {
        self.id = id
        self.content = content
        self.imageUrl = imageUrl
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.userId = userId
        self.user = user
        self.tweetId = tweetId
//        self.tweet = tweet
    }
}
