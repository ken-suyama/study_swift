//
//  TweetViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/10.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let viewModel = CommentViewModel()

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var posterName: UILabel!
    @IBOutlet weak var tweet: UILabel!
    @IBOutlet weak var postedAt: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var textBox: PlaceHolderTextView!
    @IBOutlet weak var commentStack: UIStackView!
    @IBOutlet weak var comments: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var tweetImage: UIImageView!
    
    var tweetId: Int = 1
    var pPosterImage: UIImage?
    var pPosterName: String = ""
    var pTweet: String = ""
    var pPostedAt: String = ""
    var pUserIcon: UIImage?
    var pComments: [Comment?] = []
    var pTweetImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "ツイート"

        posterImage.image = pPosterImage
        posterName.text = pPosterName
        tweet.text = pTweet
        postedAt.text = pPostedAt
        userIcon.image = pUserIcon
        tweetImage.image = pTweetImage
        if pTweetImage == nil {
            tweetImage.isHidden = true
        }
        
        sendButton.addTarget(self, action: #selector(self.tapButton(_:)), for: UIControl.Event.touchUpInside)
        
        textBox.placeHolder = "返信をツイート"
        commentStack.addBorder(width: 0.5, color: .black, position: .top)
        
        comments.dataSource = self
        comments.delegate = self
        comments.register(UINib(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTableViewCell")
    }
    
    static func makeInstance(tweetId: Int, posterImage: UIImage, posterName: String, tweet: String, tweetImage: UIImage?, postedAt: String, comments: [Comment?]) -> TweetViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Tweet", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "Tweet") as! TweetViewController
        let loggedInUserIconUrl = UserDefaults.standard.string(forKey: "userIconUrl")!
        let userIcon: UIImage = UIImage(url: loggedInUserIconUrl != "" ? loggedInUserIconUrl : "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        viewController.tweetId = tweetId
        viewController.pPosterImage = posterImage
        viewController.pPosterName = posterName
        viewController.pTweet = tweet
        viewController.pPostedAt = postedAt
        viewController.pUserIcon = userIcon
        viewController.pComments = comments
        viewController.pTweetImage = tweetImage
        return viewController
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pComments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CommentsTableViewCell = comments.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell

        let comment = pComments[indexPath.row]
        let iconUrl: UIImage = UIImage(url: comment?.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        cell.setup(icon: iconUrl, name: comment?.user.name ?? "", comment: comment?.content ?? "", tweetedUserName: pPosterName)

        return cell
    }
    
    @objc func tapButton(_ sender: UIButton){
        let comment: String = textBox.text ?? ""
        if comment == "" {
            return
        }
        print(comment)
        viewModel.postComment(tweetId: tweetId, comment: comment)
        let row: Int = pComments.count
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        let userIconUrl = UserDefaults.standard.string(forKey: "userIconUrl")
        let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.pComments.insert(Comment.init(10, comment, nil, "", "", userId, User.init(userId, userEmail, "", userName, "", userIconUrl, "", ""), 1), at: row)
        self.comments.beginUpdates()
        self.comments.insertRows(at: [IndexPath(row: row, section: 0)],
                                  with: .automatic)
        self.comments.endUpdates()
        comments.scrollToRow(at: IndexPath(row: row, section: 0),
                             at: UITableView.ScrollPosition.bottom, animated: true)
        textBox.text = ""
    }
}

enum BorderPosition {
    case top, left, right, bottom
}

extension UIView {
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
