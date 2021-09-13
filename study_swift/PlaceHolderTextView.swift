//
//  TweetTextView.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/10.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

@IBDesignable class PlaceHolderTextView: UITextView {

    // MARK: Stored Instance Properties

    @IBInspectable public var placeHolder: String = "" {
        willSet {
            self.placeHolderLabel.text = newValue
            self.placeHolderLabel.sizeToFit()
        }
    }

    public lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 6.0, y: 9.0, width: 0.0, height: 0.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = UIColor.white
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    // MARK: Initializers

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: View Life-Cycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        changeVisiblePlaceHolder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged),name: UITextView.textDidChangeNotification, object: nil)
    }

    // MARK: Other Private Methods

    private func changeVisiblePlaceHolder() {
        self.placeHolderLabel.alpha = (self.placeHolder.isEmpty || !self.text.isEmpty) ? 0.0 : 1.0
    }

    @objc private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceHolder()
    }

}
