//
//  HomeGuessYouLikeMoreController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/19.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class HomeGuessYouLikeMoreController: HYBaseViewController {
    var guessYouLikeList: [GuessYouLikeModel]?
    
    let HotAudiobookCCellID = "HotAudiobookCCell"
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HotAudiobookCCell.self, forCellWithReuseIdentifier: HotAudiobookCCellID)
        return collectionView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "猜你喜欢"
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.right.height.top.equalToSuperview()
        }
        loadData()
    }
    
    func loadData() {
        HYRecommendProvider.request(.guessYouLikeMoreList) { (result) in
            if case let .success(response) = result {
                /// 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let guessYouLikeModel = JSONDeserializer<GuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.guessYouLikeList = guessYouLikeModel as? [GuessYouLikeModel]
                    self.collectionView.reloadData()
                }
                
            }
        }
    }

}

extension HomeGuessYouLikeMoreController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.guessYouLikeList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: HotAudiobookCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotAudiobookCCellID, for: indexPath) as! HotAudiobookCCell
        cell.guessYouLikeModel = self.guessYouLikeList?[indexPath.row]
        return cell
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0;
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: ScreenWidth-30,height:120)
    }
}
