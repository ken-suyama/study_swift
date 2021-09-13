//
//  TweetViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/10.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    struct Comment {
        let commentedUserIcon: UIImage?
        let commentedUserName: String
        let content: String
    }

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var postedAt: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var textBox: PlaceHolderTextView!
    @IBOutlet weak var commentStack: UIStackView!
    @IBOutlet weak var comments: UITableView!
    
    var pPosterImage : UIImage?
    var pPosterName : String = ""
    var pTweet : String = ""
    var pPostedAt : String = ""
    var pUserIcon : UIImage?
    
    private let commentList: [Comment] = [
        Comment(commentedUserIcon: #imageLiteral(resourceName: "icon1") , commentedUserName: "Angel", content: "初めてのコメント"),
        Comment(commentedUserIcon: #imageLiteral(resourceName: "icon1") , commentedUserName: "Bob", content: ""),
        Comment(commentedUserIcon: #imageLiteral(resourceName: "icon1") , commentedUserName: "Chirs", content: "Hello"),
        Comment(commentedUserIcon: #imageLiteral(resourceName: "icon1") , commentedUserName: "David", content: "Good Evening"),
        Comment(commentedUserIcon: #imageLiteral(resourceName: "icon1") , commentedUserName: "Elly", content: "ごこうのすりきれかいじゃりすいぎょのすいぎょうまつうんらいまつふうらいまつくうねるところにすむところやぶらこうじの　ぶらこうじパイポパイポパイポのシューリンガンシューリンガンのグーリンダイグーリンダイのポンポコピーのポンポコナーのちょうきゅうめいのちょうすけ")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ツイート"

        posterImage.image = pPosterImage
        posterName.text = pPosterName
        tweet.text = pTweet
        postedAt.text = now()
        userIcon.image = pUserIcon
        
        textBox.placeHolder = "返信をツイート"
        commentStack.addBorder(width: 0.5, color: .black, position: .top)
        
        comments.dataSource = self
        comments.delegate = self
        comments.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTableViewCell")
    }
    
    static func makeInstance(posterImage: UIImage, posterName: String, tweet: String, postedAt: String, userIcon: UIImage) -> TweetViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tweet", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Tweet") as! TweetViewController
        viewController.pPosterImage = posterImage
        viewController.pPosterName = posterName
        viewController.pTweet = tweet
        viewController.pPostedAt = postedAt
        viewController.pUserIcon = userIcon
        return viewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = comments.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell

        let comment = commentList[indexPath.row]
        cell.setup(icon: comment.commentedUserIcon ?? #imageLiteral(resourceName: "icon1"), name: comment.commentedUserName, comment: comment.content, tweetedUserName: self.posterName.text ?? "")

        return cell
    }
    
    private func now() -> String {
        let dt = Date()
        let dateFormatter = DateFormatter()

        // DateFormatter を使用して書式とロケールを指定する
        dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yMMMdHms", options: 0, locale: Locale(identifier: "ja_JP"))

        return dateFormatter.string(from: dt)
    }
}

enum BorderPosition {
    case top, left, right, bottom
}

extension UIView {

    /// viewに枠線を表示する
    /// - Parameters:
    ///   - width: 太さ
    ///   - color: 色
    ///   - position: 場所
    func addBorder(width: CGFloat, color: UIColor, position: BorderPosition) {
        let border = CALayer()

        switch position {
        case .top:
            border.frame = CGRect(x: 0, y: -8, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .left:
            border.frame = CGRect(x: 0, y: -8, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .right:
            border.frame = CGRect(x: self.frame.width - width, y: 0, width: width, height: self.frame.height)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        case .bottom:
            border.frame = CGRect(x: 0, y: self.frame.height - width, width: self.frame.width, height: width)
            border.backgroundColor = color.cgColor
            self.layer.addSublayer(border)
        }
    }
}
