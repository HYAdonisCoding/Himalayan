//
//  HYRecommendGridCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class HYRecommendGridCCell: HYBaseCollectionViewCell {
    private lazy var imageView: UIImageView = {
        let name = UIImageView()
        
        return name
    }()
    private lazy var titleLabel: UILabel = {
        let name = UILabel()
        name.font = UIFont.systemFont(ofSize: 13)
        name.textAlignment = NSTextAlignment.center
        return name
    }()
    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.height.width.equalTo(40)
            $0.centerX.equalToSuperview()
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.height.equalTo(20)
            $0.top.equalTo(self.imageView.snp.bottom).offset(5)
        }
    }

    var square: SquareModel? {
        didSet {
            guard let model = square else { return }
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
            self.titleLabel.text = model.title
        }
    }
}
