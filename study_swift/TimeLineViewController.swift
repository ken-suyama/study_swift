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

    struct User {
        let icon: UIImage?
        let name: String
        let content: String
    }

    @IBOutlet var timeLine: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.viewModel.fetchTweet())
        self.tweets = self.viewModel.fetchTweet()

        timeLine.dataSource = self
        timeLine.delegate = self
        timeLine.register(UINib(nibName: "TimeLineTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeLineTableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimeLineTableViewCell = timeLine.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell

        let tweet = self.tweets[indexPath.row]
        let iconUrl: UIImage = UIImage(url: tweet.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        cell.setup(icon: iconUrl, name: tweet.user.name, tweet: tweet.content)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tweets = viewModel.fetchTweet()
        let tweet = self.tweets[indexPath.row]
        let iconUrl: UIImage = UIImage(url: tweet.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        let loginUserIconUrl: UIImage = UIImage(url: tweet.user.iconUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        let viewController = TweetViewController.makeInstance(tweetId: tweet.id, posterImage: iconUrl, posterName: tweet.user.name, tweet: tweet.content, postedAt: tweet.createdAt, userIcon: loginUserIconUrl, comments: tweet.comments)

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
