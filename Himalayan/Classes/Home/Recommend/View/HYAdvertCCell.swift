//
//  HYAdvertCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class HYAdvertCCell: HYBaseCollectionViewCell {
    /// 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    /// 标题
    private var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 16)
        return titleLabel
    }()
    /// 子标题
    private var subLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = UIColor.gray
        return titleLabel
    }()
    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.image = UIImage(named: "pic1.jpeg")
        self.imageView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "明朝那些事"
        self.titleLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(30)
            $0.top.equalTo(self.imageView.snp.bottom)
        }
        self.addSubview(self.subLabel)
        self.subLabel.text = "说服力的积分乐山大佛大士力架反倒是浪费接口都是雷锋精神的陆丰收代理费吉林省的"
        self.subLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.height.equalTo(30)
            $0.top.equalTo(self.titleLabel.snp.bottom)
            $0.bottom.equalToSuperview()
        }
    }

    var adModel: RecommendAdvertModel? {
        didSet {
            guard let model = adModel else { return }
            self.titleLabel.text = model.name
            self.subLabel.text = model.description
            self.imageView.kf.setImage(with: URL(string: model.cover!))
        }
    }
}
