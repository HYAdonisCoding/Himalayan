//
//  HomeRecommendLiveCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeRecommendLiveCCell: HYBaseCollectionViewCell {
    private var live: [LiveModel]?
    let recommendLiveCCellID = "RecommendLiveCCell"
    private lazy var changeBtn: UIButton = {
        let btn = UIButton.init(type: UIButton.ButtonType.custom)
        btn.setTitle("换一批", for: UIControl.State.normal)
        btn.setTitleColor(DominantColor, for: UIControl.State.normal)
        btn.backgroundColor = UIColor.init(r: 254, g: 232, b: 227)
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = 5.0
        btn.addTarget(self, action: #selector(updateBtnClick(button:)), for: UIControl.Event.touchUpInside)
        return btn
    }()
    /// MARK: - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(RecommendLiveCCell.self, forCellWithReuseIdentifier: recommendLiveCCellID)
        return collectionView
    }()
    
    override func setupUI() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints {
            $0.left.top.equalTo(15)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }

    var liveList: [LiveModel]? {
        didSet {
            guard let model = liveList else { return }
            self.live = model
            self.collectionView.reloadData()
        }
    }
    /// 更换一批按钮刷新cell
    @objc func updateBtnClick(button: UIButton) {
        /// 接口请求
        HYRecommendProvider.request(.changeLiveList) { (result) in
            if case let .success(respone) = result {
                /// 解析数据
                let data = try? respone.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["data"]["list"].description) {
                    self.live = mappedObject as? [LiveModel]
                    self.collectionView.reloadData()
                }
                
                
            }
        }
    }
    
}

extension HomeRecommendLiveCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.live?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: RecommendLiveCCell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendLiveCCellID, for: indexPath) as! RecommendLiveCCell
        cell.recommendLiveData = self.live?[indexPath.row]
        return cell
        
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
        return CGSize.init(width: (ScreenWidth-55)/3,height:180)
    }
    
}
