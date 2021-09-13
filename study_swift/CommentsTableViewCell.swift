//
//  CommentsTableViewCell.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/10.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var commentedUserIcon: UIImageView!
    @IBOutlet weak var commentedUserName: UILabel!
    @IBOutlet weak var tweetedUserName: UILabel!
    @IBOutlet weak var comment: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(icon: UIImage, name: String, comment: String, tweetedUserName: String) {
        self.commentedUserIcon.image = icon
        self.commentedUserName.text = name
        self.comment.text = comment
        self.tweetedUserName.text = "@" + tweetedUserName
    }
}
