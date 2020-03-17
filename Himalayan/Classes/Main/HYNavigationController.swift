//
//  HYNavigationController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/16.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class HYNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarAppearence()
    }
    
    func setNavigationBarAppearence() {
        // 设置导航栏默认的背景色
        WRNavigationBar.defaultNavBarBarTintColor = UIColor.init(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
        // 设置导航栏所有按钮的默认颜色
        WRNavigationBar.defaultNavBarTintColor = DominantColor
        /// 设置导航栏标题颜色
        WRNavigationBar.defaultNavBarTitleColor = .black
        /// r统一设置状态栏样式
//        WRNavigationBar.defaultStatusBarStyle = .lightContent
        // 如果需要设置导航栏底部分割线隐藏,可以在这里统一设置
        WRNavigationBar.defaultShadowImageHidden = true
    }
}

extension HYNavigationController {
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
