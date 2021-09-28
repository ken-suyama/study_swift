//
//  UserViewModel.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

class UserViewModel {
    struct createUserDto {
        var id : String
        var email : String
        var password : String
        var name : String
        var nickname : String
    }

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
    
    struct Me: Codable {
        let id: String
        let email: String
        let name: String
        let nickname: String
        let iconUrl: String?
        let createdAt: String
        let updatedAt: String
        
        init(_ id: String, _ email: String, _ name: String, _ nickname: String, _ iconUrl: String?, _ createdAt: String, _ updatedAt: String) {
            self.id = id
            self.email = email
            self.name = name
            self.nickname = nickname
            self.iconUrl = iconUrl
            self.createdAt = createdAt
            self.updatedAt = updatedAt
        }
    }
    
    func me() {
        let targetUrl = URL(string: "http://localhost:3000/users/me")!
        var request = URLRequest(url: targetUrl)
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return }
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
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
            do {
                let me: Me = try JSONDecoder().decode(Me.self, from: data)
                UserDefaults.standard.set(me.id, forKey: "id")
                UserDefaults.standard.set(me.name, forKey: "userName")
                UserDefaults.standard.set(me.nickname, forKey: "userNickName")
                UserDefaults.standard.set(me.email, forKey: "userEmail")
                UserDefaults.standard.set(me.iconUrl ?? "", forKey: "userIconUrl")
            } catch let error {
                print(":エラー:\(error)")
            }
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
        
        sleep(5)
    }
    
    func registerUser(dto: createUserDto) {
        let targetUrl = URL(string: "http://localhost:3000/users")!
        var request = URLRequest(url: targetUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params: [String: String] = [
            "id": dto.id,
            "email": dto.email,
            "password": dto.password,
            "name": dto.name,
            "nickname": dto.nickname,
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
           
           if response.statusCode == 201 {
               print("ok")
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
        sleep(10)
    }
}
