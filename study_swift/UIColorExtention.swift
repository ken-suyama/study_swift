//
//  UIColorExtention.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/23.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) ->UIColor {
        return self.init(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
}
