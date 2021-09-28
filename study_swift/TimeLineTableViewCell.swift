//
//  HogeTableViewCell.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/07.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class TimeLineTableViewCell: UITableViewCell {

    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var tweetImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(icon: UIImage, name: String, tweet: String, tweetImage: UIImage?) {
        self.userIcon.image = icon
        self.userName.text = name
        self.content.text = tweet
        self.tweetImage.image = tweetImage
        if tweetImage == nil {
            self.tweetImage.isHidden = true
        }
    }
    
}
