//
//  HYPlayViewController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/16.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class HYPlayViewController: HYBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBarButton)
    }
    

    //Mark: - 导航栏左边按钮
    private lazy var leftBarButton: UIButton = {
        let button = UIButton.init(type: UIButton.ButtonType.custom)
        button.frame = CGRect(x:0, y:0, width:30, height: 30)
        button.setImage(UIImage(named: "playpage_icon_down_black_30x30_"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(leftBarButtonClick), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    @objc func leftBarButtonClick() {
        self.dismiss(animated: true, completion: nil)
    }

}
