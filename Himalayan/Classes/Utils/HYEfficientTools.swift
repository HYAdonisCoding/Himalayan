//
//  HYEfficientTools.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

extension UIDevice {
    public func isiPhoneXMore() -> Bool {
        var isMore:Bool = false
        if #available(iOS 11.0, *) {
            isMore = (UIApplication.shared.keyWindow?.safeAreaInsets.bottom)! > CGFloat(0.0) ? true : false
        }
        return isMore
    }
}

class HYEfficientTools {
    func setStacicGuidePage() -> UIView {
        let imageNameArray: [String] = ["lead01", "lead02", "lead03"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        return guideView
    }
    
    func setDynamicGuidePage() -> UIView {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        return guideView
    }
    
    func setVideoGuidePage() -> UIView {
        let urlStr = Bundle.main.path(forResource: "qidong", ofType: "mp4")
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL: videoUrl, isHiddenSkipButton: false)
        return guideView
    }
    
    /// 加载底部tabBar样式
    /// - Parameter delegate: 代理
    func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarVC = ESTabBarController()
        tabBarVC.delegate = delegate
        tabBarVC.title = "Irregularity"
        tabBarVC.tabBar.shadowImage = UIImage.init(named: "transparent")
        tabBarVC.shouldHijackHandler = {
            tabBarVC, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarVC.didHijackHandler = {
            [weak tabBarVC] tabbarVC, viewController, index in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                // play
                let vc = HYPlayViewController()
                let n1 = HYNavigationController.init(rootViewController: vc)
                n1.modalPresentationStyle = .fullScreen
                tabBarVC?.present(n1, animated: true, completion: {
                    
                })
                
            }
        }
        
        let vc1 = HYHomeViewController()
        let vc2 = HYListenViewController()
        let vc3 = HYPlayViewController()
        let vc4 = HYFindViewController()
        let vc5 = HYMineViewController()
        
        vc1.tabBarItem = ESTabBarItem.init(HYIrregularityBasicContentView(), title: "Home", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"), tag: 0)
        vc2.tabBarItem = ESTabBarItem.init(HYIrregularityBasicContentView(), title: "Find", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"), tag: 1)
        vc3.tabBarItem = ESTabBarItem.init(HYIrregularityContentView(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"), tag: 2)
        vc4.tabBarItem = ESTabBarItem.init(HYIrregularityBasicContentView(), title: "Favor", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"), tag: 3)
        vc5.tabBarItem = ESTabBarItem.init(HYIrregularityBasicContentView(), title: "Mine", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"), tag: 4)
        vc1.title = "Home"
        vc2.title = "Find"
        vc3.title = "Play"
        vc4.title = "Favor"
        vc5.title = "Mine"
        let n1 = HYNavigationController.init(rootViewController: vc1)
        let n2 = HYNavigationController.init(rootViewController: vc2)
        let n3 = HYNavigationController.init(rootViewController: vc3)
        let n4 = HYNavigationController.init(rootViewController: vc4)
        let n5 = HYNavigationController.init(rootViewController: vc5)
        n1.navigationBar.isTranslucent = true
        n2.navigationBar.isTranslucent = true
        n3.navigationBar.isTranslucent = true
        n4.navigationBar.isTranslucent = true
        n5.navigationBar.isTranslucent = true
        ///
        n1.navigationBar.shadowImage = UIImage()
        
        tabBarVC.viewControllers = [n1, n2, n3, n4, n5]
        return tabBarVC
    }
}
