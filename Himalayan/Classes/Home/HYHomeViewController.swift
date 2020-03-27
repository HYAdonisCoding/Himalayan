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
        
 
//        DispatchQueue.global().async {
//            for _ in 1...100 {
//
//                self.run(number: 1)
//                if self.ticket <= 0 {
//                    print("1没票了,请回吧")
//                    break
//                }
//            }
//        }
//        DispatchQueue.global().async {
//            for _ in 1...100 {
//
//                self.run(number: 2)
//                if self.ticket <= 0 {
//                    print("2没票了,请回吧")
//                    break
//                }
//            }
//        }
//        DispatchQueue.global().async {
//            for _ in 1...100 {
//
//                self.run(number: 3)
//                if self.ticket <= 0 {
//                    print("3没票了,请回吧")
//                    break
//                }
//            }
//        }
        let thread = Thread.init(target: self, selector: #selector(run(number:)), object: "111")
        thread.start()
        Thread.detachNewThread {
            for _ in 1...100 {

                self.run(number:4)
                if self.ticket <= 0 {
                    print("4没票了,请回吧")
                    break
                }
            }
        }
        self.performSelector(inBackground: #selector(run(number:)), with: "000")
//        self.perform(#selector(run(number:)), on: thread, with: "0", waitUntilDone: false)
    }
    
    var ticket = 100
    
    @objc func run(number: NSInteger) {
        let lock = NSLock()
        lock.lock()
        //Do something
        if ticket > 0 {
            ticket -= 1;
            print("\(number)号售票员卖了一张票,还剩\(ticket)张票了")
        } else {
            print("\(number)号售票员没票了,请回吧")
        lock.unlock()
        
        }
        
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
