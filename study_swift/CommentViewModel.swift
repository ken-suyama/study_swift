//
//  TweetViewModel.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class CommentViewModel {

    func postComment(tweetId: Int, comment: String) -> Void {
        print(comment)
        let targetUrl = URL(string: "http://localhost:3000/tweets/"+String(tweetId)+"/comments")!
        var request = URLRequest(url: targetUrl)
        let token: String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2YmJsIiwiZW1haWwiOiJlbWFpbDJAZXhhbXBsZS5jb20iLCJpYXQiOjE2MzIyODYyNjUsImV4cCI6MTYzMjI5ODI2NX0.dwY-Y-80d7TGvZAOlzk21AlAm1jGCJyhO-mwLT1YVOo"
        request.httpMethod = "POST"
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params: [String: String] = [
            "content": comment
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
    

        let _: Void = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
           if let error = error {
               print(error.localizedDescription)
               print("通信が失敗しました")
               return
           }
           
           guard let data = data,
                 let response = response as? HTTPURLResponse else {
               print("データもしくはレスポンスがnilの状態です")
               return
           }
           
           if response.statusCode == 200 {
               print("succced")
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
    }
}
