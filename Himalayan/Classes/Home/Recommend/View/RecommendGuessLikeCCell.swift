//
//  RecommendGuessLikeCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class RecommendGuessLikeCCell: HYBaseCollectionViewCell {
    
    /// 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    /// 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    /// 子标题
    private var subLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        label.numberOfLines = 0
        return label
    }()
    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
    }
    
    var recommendData: RecommendListModel? {
        didSet {
            guard let model = recommendData else { return }
            if model.pic != nil {
                self.imageView.kf.setImage(with: URL(string: model.pic!))
            }
            self.titleLabel.text = model.title
            self.subLabel.text = model.subtitle
        }
    }

}
