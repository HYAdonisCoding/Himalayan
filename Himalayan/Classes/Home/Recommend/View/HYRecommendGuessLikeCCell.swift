//
//  HYRecommendGuessLikeCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

/// 添加cell点击代理方法
protocol HYRecommendGuessLikeCCellDelegate: NSObjectProtocol {
    func recommendGGuessLikeCellItemClick(model: RecommendListModel)
}
class HYRecommendGuessLikeCCell: HYBaseCollectionViewCell {
    weak var delegate: HYRecommendGuessLikeCCellDelegate?
    private var recommendList: [RecommendListModel]?
    
    private let HYGuessYouLikeCellID = "HYGuessYouLikeCCell"
    
    private lazy var changeBtn: UIButton = {
        let button = UIButton.init(type: .custom)
        button.setTitle("换一批", for: UIControl.State.normal)
        button.setTitleColor(DominantColor, for: UIControl.State.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(RecommendGuessLikeCCell.self, forCellWithReuseIdentifier: HYGuessYouLikeCellID)
        return collectionView
    }()
    
    override func setupUI() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.top.equalTo(15)
            $0.bottom.equalToSuperview().offset(-50)
            $0.right.equalToSuperview().offset(-15)
        }
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.height.equalTo(30)
            $0.width.equalTo(100)
            $0.centerX.equalToSuperview()
        }
    }
    var recommendListData: [RecommendListModel]? {
        didSet {
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
    
    /// 更换一匹按钮刷新cell
    @objc func updataBtnClick(button: UIButton) {
        /// 首页推荐接口请求
        HYRecommendProvider.request(.changeGuessYouLikeList) { (result) in
            if case let .success(respones) = result {
                //解析数据
                let data = try? respones.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.recommendList = mappedObject as? [RecommendListModel]
                    self.collectionView.reloadData()
                }
                
                
            }
        }
    }
}

extension HYRecommendGuessLikeCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendGuessLikeCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYGuessYouLikeCellID, for: indexPath) as! RecommendGuessLikeCCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recommendGGuessLikeCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:(ScreenWidth-55)/3,height:180)
    }
}
