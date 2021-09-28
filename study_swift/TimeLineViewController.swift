//
//  TimeLineViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/07.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TimeLineViewController: UITableViewController, UITabBarDelegate {
    
    private let viewModel = TweetViewModel()
    private var tweets: [Tweet] = []
    private let notificationCenter = NotificationCenter.default

    @IBOutlet var timeLine: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tweets = self.viewModel.fetchTweet()

        timeLine.dataSource = self
        timeLine.delegate = self
        timeLine.register(UINib(nibName: "TimeLineTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeLineTableViewCell")
        
        notificationCenter.addObserver(self, selector: #selector(updateList), name: .tweetPosted, object: nil)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.refresh), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
    }
    
    @objc func refresh() {
        tableView.performBatchUpdates({
            self.tweets = self.viewModel.fetchTweet()
            self.timeLine.reloadData()
        }) { (finished) in
            self.refreshControl?.endRefreshing()
        }
    }
    
    @objc func updateList(notification: Notification) {
        let content = notification.userInfo!["tweet"] as! String
        let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
        let userName = UserDefaults.standard.string(forKey: "userName") ?? ""
        let userIconUrl = UserDefaults.standard.string(forKey: "userIconUrl") != "" ? UserDefaults.standard.string(forKey: "userIconUrl") : nil
        let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        self.tweets.insert(Tweet.init(10, content, nil, "", "", userId, User.init(userId, userEmail, "", userName, "", userIconUrl, "", ""), []), at: 0)
        self.timeLine.beginUpdates()
        self.timeLine.insertRows(at: [IndexPath(row: 0, section: 0)],
                                  with: .automatic)
        self.timeLine.endUpdates()
        timeLine.scrollToRow(at: IndexPath(row: 0, section: 0),
                             at: UITableView.ScrollPosition.bottom, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimeLineTableViewCell = timeLine.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell

        let tweet = self.tweets[indexPath.row]
        let iconUrl: UIImage = UIImage(url: tweet.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        let tweetImage: UIImage? = tweet.imageUrl != nil ? UIImage(url: tweet.imageUrl!) : nil
        cell.setup(icon: iconUrl, name: tweet.user.name, tweet: tweet.content, tweetImage: tweetImage)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tweets = viewModel.fetchTweet()
        let tweet = self.tweets[indexPath.row]
        let iconUrl: UIImage = UIImage(url: tweet.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        let tweetImage: UIImage? = tweet.imageUrl != nil ? UIImage(url: tweet.imageUrl!) : nil
        let viewController = TweetViewController.makeInstance(tweetId: tweet.id, posterImage: iconUrl, posterName: tweet.user.name, tweet: tweet.content, tweetImage: tweetImage, postedAt: tweet.createdAt, comments: tweet.comments)

        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

extension UIImage {
    public convenience init(url: String) {
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            self.init(data: data)!
            return
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        self.init()
    }
}
