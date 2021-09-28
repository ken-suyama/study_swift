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
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return }
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
           
           guard let _ = data,
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
