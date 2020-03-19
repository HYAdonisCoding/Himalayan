//
//  OneKeyListenCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class OneKeyListenCCell: HYBaseCollectionViewCell {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        titleLabel.textAlignment = NSTextAlignment.center
        return titleLabel
    }()
    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(70)
            $0.top.equalTo(15)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
            $0.top.equalTo(self.imageView.snp.bottom).offset(10)
        }
    }

    var oneKeyListen: OneKeyListenModel? {
        didSet {
            guard let model = oneKeyListen else { return }
            if model.coverRound != nil {
                self.imageView.kf.setImage(with: URL(string: model.coverRound!))
            }
            self.titleLabel.text = model.channelName
        }
    }
}
