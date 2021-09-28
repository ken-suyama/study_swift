//
//  PostTweetViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/24.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class PostTweetViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let notificationCenter = NotificationCenter.default

    var myImagePicker: UIImagePickerController!
    var myImageView: UIImageView!


    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var tweetTextField: UITextField!
    @IBOutlet weak var photoButton: UIButton!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var eraseImageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sendButtonDisable()
        let loggedInUserIconUrl = UserDefaults.standard.string(forKey: "userIconUrl")!
        self.userIcon.image = UIImage(url: loggedInUserIconUrl != "" ? loggedInUserIconUrl : "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        self.userIcon.layer.borderColor = UIColor.black.cgColor
        self.userIcon.layer.borderWidth = 0.5
        
        tweetTextField.delegate = self
        eraseImageButton.isHidden = true
        selectedImageView.image = nil
        
        myImageView = UIImageView(frame: self.view.bounds)

        // インスタンス生成
        myImagePicker = UIImagePickerController()

        // デリゲート設定
        myImagePicker.delegate = self

        // 画像の取得先はフォトライブラリ
        myImagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary

        // 画像取得後の編集を不可に
        myImagePicker.allowsEditing = false
    }

    @IBAction func onClickEraseImageButton(_ sender: Any) {
        selectedImageView.image = nil
        eraseImageButton.isHidden = true
    }

    @IBAction func onClickPhotoButton(_ sender: Any) {
        self.present(myImagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onClickCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onClickTweetButton(_ sender: Any) {
        if (tweetTextIsEmpty()) {
            print("tweetTextIsEmpty")
            return;
        }
        let tweet: String = tweetTextField.text!
        let viewModel: TweetViewModel = TweetViewModel()
        if selectedImageView.image != nil {
            viewModel.postTweetWithImage(content: tweet, image: selectedImageView.image!)
        } else {
            viewModel.postTweet(content: tweet)
        }
        
        notificationCenter.post(name: .tweetPosted, object: nil, userInfo: ["tweet": tweet])
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        //選択された画像を取得.
        let myImage: AnyObject?  = info[UIImagePickerController.InfoKey.originalImage] as AnyObject
        
        selectedImageView.image = myImage as? UIImage
        eraseImageButton.isHidden = false
        dismiss(animated: true, completion: nil)
    }

    /**
     画像選択がキャンセルされた時に呼ばれる.
     */
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        // モーダルビューを閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    private func tweetTextIsEmpty() -> Bool {
        return tweetTextField.text?.isEmpty ?? true
    }
}

extension PostTweetViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if tweetTextIsEmpty() {
            sendButtonDisable()
            return
        }
        
        sendButtonAnable()
    }
    
    private func sendButtonDisable() -> Void {
        postButton.isEnabled = false
        postButton.backgroundColor = UIColor.rgb(red: 255, green: 221, blue: 187)
    }
    
    private func sendButtonAnable() -> Void {
        postButton.isEnabled = true
        postButton.backgroundColor = UIColor.rgb(red: 255, green: 141, blue: 0)
    }
}

extension Notification.Name {
    static let tweetPosted = Notification.Name("tweetPosted")
}
