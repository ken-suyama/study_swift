//
//  LogInViewModel.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/24.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class LogInViewModel{
    struct logInDto {
        var email : String
        var password : String
    }
    
    struct AccessToken: Codable {
        var accessToken : String

        enum CodingKeys: String, CodingKey {
          case accessToken = "access_token"
        }
    }
    
    func login(dto: logInDto) -> String {
        var accessToken: String = ""
        let targetUrl = URL(string: "http://localhost:3000/login")!
        var request = URLRequest(url: targetUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params: [String: String] = [
            "email": dto.email,
            "password": dto.password
        ]
        request.httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
        
        let _: Void = URLSession.shared.dataTask(with: request, completionHandler: { data , response, error in
            if let error = error {
               print(error.localizedDescription)
               print("通信が失敗しました")
               return
           }
           
           guard let data = data, let response = response as? HTTPURLResponse else {
               print("データもしくはレスポンスがnilの状態です")
               return
           }
           
           if response.statusCode == 201 {
               if !data.isEmpty {
                   let token = try! JSONDecoder().decode(AccessToken.self, from: data)
                   accessToken = token.accessToken
               }
               print("ok")
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
        
        sleep(10)
        return accessToken
    }
}
