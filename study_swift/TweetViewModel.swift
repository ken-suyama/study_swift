//
//  TweetViewModel.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/21.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TweetViewModel {

    func fetchTweet() -> [Tweet] {
        var tweetObj: [Tweet] = []
        let targetUrl = URL(string: "http://localhost:3000/tweets")!
        var request = URLRequest(url: targetUrl)
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return [] }
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
                print(try JSONDecoder().decode([Tweet].self, from: data))
                let tweets: [Tweet] = try JSONDecoder().decode([Tweet].self, from: data)
                tweetObj.append(contentsOf: tweets)
               } catch let error {
                   print(":エラー:\(error)")
               }
               
           } else if response.statusCode == 401 {
                let appDomain = Bundle.main.bundleIdentifier
                UserDefaults.standard.removePersistentDomain(forName: appDomain!)
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
        sleep(5)
        return tweetObj
    }
    
    func fetchMyPhotoTweets() -> [Tweet] {
        var tweetObj: [Tweet] = []
        let targetUrl = URL(string: "http://localhost:3000/my_tweets/my_photo_tweets")!
        var request = URLRequest(url: targetUrl)
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return [] }
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
                print(try JSONDecoder().decode([Tweet].self, from: data))
                let tweets: [Tweet] = try JSONDecoder().decode([Tweet].self, from: data)
                tweetObj.append(contentsOf: tweets)
               } catch let error {
                   print(":エラー:\(error)")
               }
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
        sleep(5)
        print(tweetObj)
        return tweetObj
    }
    
    func postTweet(content: String) -> Void {
        let targetUrl = URL(string: "http://localhost:3000/tweets")!
        var request = URLRequest(url: targetUrl)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return }
        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        let params: [String: String?] = [
            "content": content,
            "imageUrl": nil
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
               print("ok")
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
    }
    
    func postTweetWithImage(content: String, image: UIImage) -> Void {
        let boundary = "example.boundary.\(ProcessInfo.processInfo.globallyUniqueString)"

        let imageData = image.jpegData(compressionQuality: 1.0)
        let mimeType = imageData?.mimeType!
        let body = ImageUploader.createHttpBody(binaryData: imageData!, content: content, mimeType: mimeType!, boundary: boundary)
        let targetUrl = URL(string: "http://localhost:3000/tweets")!
        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return }
        var headers: HTTPHeaders {
            return [
                "Content-Type": "multipart/form-data; boundary=\(boundary)",
                "Accept": "application/json",
                "Authorization": "Bearer \(token)"
            ]
        }
        var request = URLRequest(url: targetUrl, method: "POST", headers: headers)
//        request.httpMethod = "POST"
//        request.addValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
//        request.addValue(boundary, forHTTPHeaderField: "boundary")
//        guard let token: String = UserDefaults.standard.string(forKey: "accessToken") else { return }
//        request.addValue("Bearer " + token, forHTTPHeaderField: "Authorization")
        request.httpBody = body

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
               print("ok")
           } else {
               print("statusCode:\(response.statusCode)")
           }
        }).resume()
    }
}

extension Data {

    var mimeType: String? {
        var values = [UInt8](repeating: 0, count: 1)
        copyBytes(to: &values, count: 1)

        switch values[0] {
        case 0xFF:
            return "image/jpeg"
        case 0x89:
            return "image/png"
        case 0x47:
            return "image/gif"
        case 0x49, 0x4D:
            return "image/tiff"
        default:
            return nil
        }
    }
}

extension URLRequest {

    init(url: URL, method: String, headers: HTTPHeaders?) {
        self.init(url: url)
        httpMethod = method

        if let headers = headers {
            headers.forEach {
                setValue($0.1, forHTTPHeaderField: $0.0)
            }
        }
    }
}
