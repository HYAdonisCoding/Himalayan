//
//  HYHomeViewController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/16.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import DNSPageView

class HYHomeViewController: HYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建DNSPageStyle, 设置样式
        let style = DNSPageView.PageStyle()
        style.isTitleViewScrollEnabled = false
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        
        let titles = ["推荐", "分类", "VIP", "直播", "广播"]
        let viewControllers: [HYBaseViewController] = [HYHomeRecommendController(), HYHomeClassifyController(), HYHomeVIPController(), HYHomeLiveController(), HYHomeBroadcastController()]
        for vc in viewControllers {
            self.addChild(vc)
        }
        
        let pageView = DNSPageView.PageView(frame: CGRect(x: 0, y: navigationBarHeight, width: ScreenWidth, height: ScreenHeight-navigationBarHeight-44), style: style, titles: titles, childViewControllers: viewControllers)
        view.addSubview(pageView)
        
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
