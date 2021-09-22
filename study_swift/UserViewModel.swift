//
//  UserViewModel.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

class UserViewModel {
    func fetchUsers() {
        let targetUrl = URL(string: "http://localhost:3000/users")!
        let request = URLRequest(url: targetUrl)
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
               print(String(data: data, encoding: .utf8)!)
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
    }
}
