//
//  TabBarDelegate.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/08.
//  Copyright © 2021 須山賢. All rights reserved.
//

import Foundation

@objc protocol TabBarDelegate {

    func didSelectTab(tabBarController: TabBarController)
}
