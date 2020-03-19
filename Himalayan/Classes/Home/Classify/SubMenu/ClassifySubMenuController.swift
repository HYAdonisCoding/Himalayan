//
//  ClassifySubMenuController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/19.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON
import DNSPageView

class ClassifySubMenuController: HYBaseViewController {
    private var categoryId: Int = 0
    private var isVipPush: Bool = false
    
    convenience init(categoryId: Int = 0, isVipPush: Bool = false) {
        self.init()
        self.categoryId = categoryId
        self.isVipPush = isVipPush
    }
    private var keywords: [ClassifySubMenuKeywords]?
    private var nameArray = NSMutableArray()
    private var keywordArray = NSMutableArray()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        loadHeaderCategoryData()
    }
    
    func loadHeaderCategoryData()  {
        ClassifySubMenuProvider.request(ClassifySubMenuAPI.headerCategoryList(categoryId: self.categoryId)) { (result) in
            if case let .success(response) = result {
                /// 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifySubMenuKeywords>.deserializeModelArrayFrom(json: json["keywords"].description) {
                    self.keywords = mappedObject as? [ClassifySubMenuKeywords]
                    for keyword in self.keywords! {
                        self.nameArray.add(keyword.keywordName!)
                    }
                    if !self.isVipPush {
                        self.nameArray.insert("推荐", at: 0)
                    }
                    self.initHeaderView()
                }
            }
        }
    }
    func initHeaderView() {
        /// 创建
        let style = DNSPageView.PageStyle()
        style.isTitleViewScrollEnabled = true
        style.isTitleScaleEnabled = true
        style.isShowBottomLine = true
        style.titleSelectedColor = UIColor.black
        style.titleColor = UIColor.gray
        style.bottomLineColor = DominantColor
        style.bottomLineHeight = 2
        style.titleViewBackgroundColor = FooterViewColor
        
        /// 创建每一页对应的vc
        var viewControllers = [HYBaseViewController]()
        for keyword in self.keywords! {
            let vc = ClassifySubContentController(keywordId: keyword.keywordId, categoryId: keyword.categoryId)
            viewControllers.append(vc)
        }
        if !isVipPush {
            // 这里需要插入推荐的控制器，因为接口数据中并不含有推荐
            let categoryId = (self.keywords?.last?.categoryId)
            viewControllers.insert(ClassifySubRecommendController(categoryId: categoryId!), at: 0)
        }
        
        for vc in viewControllers {
            self.addChild(vc)
        }
        let pageView = DNSPageView.PageView(frame: CGRect(x: 0, y: navigationBarHeight, width: ScreenWidth, height: ScreenHeight-navigationBarHeight), style: style, titles: nameArray as! [String], childViewControllers: viewControllers)
        view.addSubview(pageView)
    }

}
