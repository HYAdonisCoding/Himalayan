//
//  HYBasicContentView.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/16.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import ESTabBarController_swift

class HYBasicContentView: ESTabBarItemContentView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = UIColor.init(white: 175/255.0, alpha: 1.0)
        highlightTextColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1)
        iconColor = UIColor.init(white: 175/255.0, alpha: 1.0)
        highlightIconColor = UIColor.init(red: 254/255.0, green: 73/255.0, blue: 42/255.0, alpha: 1)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
