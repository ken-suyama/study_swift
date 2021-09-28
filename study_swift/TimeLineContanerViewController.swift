//
//  TimeLineContanerViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/24.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TimeLineContanerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickTweetButton(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "PostTweet", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "PostTweet") as! PostTweetViewController
        self.present(viewController, animated: true, completion: nil)
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
