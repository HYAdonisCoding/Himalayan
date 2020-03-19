//
//  HYRecommendHeaderView.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

/// 闭包回调
typealias HeaderMoreBtnClick = () -> Void
class HYRecommendHeaderView: HYBaseCollectionReusableView {
    var headerMoreBtnClick: HeaderMoreBtnClick?
    
    /// 标题
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        return titleLabel
    }()
    /// 子标题
    private var subLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textColor = UIColor.lightGray
        titleLabel.textAlignment = NSTextAlignment.right
        return titleLabel
    }()
    
    /// 更多
    private var moreBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("更多 >", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        btn.addTarget(self, action: #selector(moreBtn(button:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    override func setupUI() {
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "猜你喜欢"
        self.titleLabel.snp.makeConstraints {
            $0.left.top.equalTo(15)
            $0.height.equalTo(30)
            $0.width.equalTo(150)
        }
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints {
            $0.left.equalTo(self.titleLabel.snp.right)
            $0.height.top.equalTo(self.titleLabel)
            $0.right.equalToSuperview().offset(-100)
        }
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints {
            $0.right.top.equalTo(15)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }
    var homeRecommendList: HomeRecommendModel? {
        didSet {
            guard let model = homeRecommendList else { return }
            if model.title != nil {
                self.titleLabel.text = model.title
            } else {
                self.titleLabel.text = "猜你喜欢"
            }
        }
    }
    @objc func moreBtn(button: UIButton) {
        guard let headerMoreBtnClick = headerMoreBtnClick else { return }
        headerMoreBtnClick()
    }
    
}
