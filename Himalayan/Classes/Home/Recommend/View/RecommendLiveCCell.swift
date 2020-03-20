//
//  RecommendLiveCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class RecommendLiveCCell: HYBaseCollectionViewCell {
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
    
    /// categoryName标题
    private var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.orange
        return label
    }()
    
    private lazy var replicatorLayer: ReplicatorLayer = {
        let name = ReplicatorLayer.init(frame: CGRect(x: 0, y: 0, width: 2, height: 15))
        return name
    }()
    

    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = 8
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-60)
        }
        
        self.imageView.addSubview(self.categoryLabel)
        self.categoryLabel.layer.masksToBounds = true
        self.categoryLabel.layer.cornerRadius = 4
        self.categoryLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(30)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.imageView.snp.bottom)
            $0.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom)
            $0.height.equalTo(40)
        }
        
        self.imageView.addSubview(self.replicatorLayer)
        self.replicatorLayer.snp.makeConstraints {
            $0.left.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.width.equalTo(20)
            $0.height.equalTo(10)
        }
    }
    
    var recommendLiveData: LiveModel? {
        didSet {
            guard let model = recommendLiveData else { return }
            if model.coverMiddle != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverMiddle!))
            }
            self.titleLabel.text = model.nickname
            self.subLabel.text = model.name
            self.categoryLabel.text = model.categoryName
        }
    }
}
