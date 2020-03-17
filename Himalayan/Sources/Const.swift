//
//  Const.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height
let DominantColor = UIColor.init(red: 242/255.0, green: 77/255.0, blue: 51/255.0, alpha: 1)
let FooterViewColor = UIColor.init(red: 240/255.0, green:241/255.0, blue: 244/255.0, alpha: 1)

/// iPhone 全面屏
let isIPhoneX = (ScreenWidth == 812 || ScreenHeight == 896) ? true : false
let navigationBarHeight: CGFloat = isIPhoneX ? 88 : 64
let tabBarHeight: CGFloat = isIPhoneX ? 49 + 34 : 49


