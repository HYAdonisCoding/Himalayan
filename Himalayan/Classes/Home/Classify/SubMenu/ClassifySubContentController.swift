//
//  ClassifySubContentController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/19.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ClassifySubContentController: HYBaseViewController {
    /// 必要参数
    private var keywordId: Int = 0
    private var categoryId: Int = 0
    convenience init(keywordId: Int = 0, categoryId: Int = 0) {
        self.init()
        self.keywordId = keywordId
        self.categoryId = categoryId
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: 等待将来回来做: <#DESC#>
        print("等待将来回来做")
        // Do any additional setup after loading the view.
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
