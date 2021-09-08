//
//  TimeLineViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/07.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TimeLineViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate {

    func didSelectTab(tabBarController: TabBarController) {
        print("hello")
    }

    struct User {
        let icon: UIImage?
        let name: String
        let content: String
    }

    @IBOutlet weak var timeLine: UITableView!
    
    private let users: [User] = [
        User(icon: #imageLiteral(resourceName: "icon1") , name: "Angel", content: "初めてのツイート"),
        User(icon: #imageLiteral(resourceName: "icon1") , name: "Bob", content: ""),
        User(icon: #imageLiteral(resourceName: "icon1") , name: "Chirs", content: "こんにちは"),
        User(icon: #imageLiteral(resourceName: "icon1") , name: "David", content: "こんばんわ"),
        User(icon: #imageLiteral(resourceName: "icon1") , name: "Elly", content: "ジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲムジュゲム")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timeLine.dataSource = self
        timeLine.delegate = self
        timeLine.register(UINib(nibName: "TimeLineTableViewCell", bundle: nil), forCellReuseIdentifier: "TimeLineTableViewCell")
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TimeLineTableViewCell = timeLine.dequeueReusableCell(withIdentifier: "TimeLineTableViewCell", for: indexPath) as! TimeLineTableViewCell

        let user = users[indexPath.row]
        cell.setup(icon: user.icon ?? #imageLiteral(resourceName: "icon2"), name: user.name, tweet: user.content)

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
