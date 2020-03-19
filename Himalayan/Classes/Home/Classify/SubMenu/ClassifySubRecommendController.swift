//
//  ClassifySubRecommendController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/19.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class ClassifySubRecommendController: HYBaseViewController {
    private var categoryId: Int = 0
    convenience init(categoryId: Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // TODO: 等待将来回来做: <#DESC#>
        print("等待将来回来做")
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
