//
//  HYRecommendHeaderCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import FSPagerView

/// 添加按钮代理方法
protocol HYRecommendHeaderCellDelegate: NSObjectProtocol {
    func recommendHeaderBtnClick(categoryId: String, title: String, url: String)
    func recommendHeaderBannerClick(url: String)
}

class HYRecommendHeaderCCell: HYBaseCollectionViewCell {
    weak var delegate: HYRecommendHeaderCellDelegate?
    
    
    private var focus: FocusModel?
    private var square: [SquareModel]?
    private var topBuzzList: [TopBuzzModel]?
    /// 懒加载滚动图片浏览器
    private lazy var pagerView: FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval = 3
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 15
        pagerView.transformer = FSPagerViewTransformer(type: .linear)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        return pagerView
    }()
    
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let name = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        name.delegate = self
        name.dataSource = self
        name.backgroundColor = UIColor.white
        name.register(HYRecommendGridCCell.self, forCellWithReuseIdentifier: "HYRecommendGridCCell")
        name.register(RecommendNewsCCell.self, forCellWithReuseIdentifier: "RecommendNewsCCell")
        return name
    }()
    
    override func setupUI() {
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(150)
        }
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.pagerView.snp.bottom)
            make.height.equalTo(210)
        }
        self.pagerView.itemSize = CGSize.init(width: ScreenWidth-60, height: 140)
    }
    
    var focusModel: FocusModel? {
        didSet {
            guard let model = focusModel else { return }
            self.focus = model
            self.pagerView.reloadData()
        }
    }
    
    var squareList: [SquareModel]? {
        didSet {
            guard let model = squareList else { return }
            self.square = model
            self.gridView.reloadData()
        }
    }
    
    var topBuzzListData: [TopBuzzModel]? {
        didSet {
            guard let model = topBuzzListData else { return }
            self.topBuzzList = model
            self.gridView.reloadData()
        }
    }

}

extension HYRecommendHeaderCCell: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.focus?.data?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.kf.setImage(with: URL(string: (self.focus?.data?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        let url: String = self.focus?.data?[index].link ?? ""
        delegate?.recommendHeaderBannerClick(url: url)
    }
}
extension HYRecommendHeaderCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return self.square?.count ?? 0
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell: HYRecommendGridCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HYRecommendGridCCell", for: indexPath) as! HYRecommendGridCCell
            cell.square = self.square?[indexPath.row]
            return cell
        } else {
            let cell: RecommendNewsCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendNewsCCell", for: indexPath) as! RecommendNewsCCell
            cell.topBuzzList = self.topBuzzList
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        if indexPath.section == 0 {
            return CGSize.init(width: (ScreenWidth-5), height: 80)
        } else {
            return CGSize.init(width: ScreenWidth, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let string = self.square?[indexPath.row].properties?.uri else {
            let categoryId: String = "0"
            let title: String = self.square?[indexPath.row].title ?? ""
            let url: String = self.square?[indexPath.row].url ?? ""
            delegate?.recommendHeaderBtnClick(categoryId: categoryId, title: title, url: url)
            return
        }
        let categoryId: String = getUrlCategoryId(url: string)
        let title: String = self.square?[indexPath.row].title ?? ""
        let url: String = self.square?[indexPath.row].url ?? ""
        delegate?.recommendHeaderBtnClick(categoryId: categoryId, title: title, url: url)
    }
    
    
}


func getUrlCategoryId(url: String) -> String {
    // 判断是否有参数
    if !url.contains("?") {
        return ""
    }
    var params = [String: Any]()
    /// 截取参数
    let split = url.split(separator: "?")
    let string = split[1]
    /// 判断是单个还是多个参数
    if string.contains("&") {
        // 多个参数 分割
        let urlComponents = string.split(separator: "&")
        for keyValuePair in urlComponents {
            // 生成key value
            let pairComponents = keyValuePair.split(separator: "=")
            let key: String = String(pairComponents[0])
            let value: String = String(pairComponents[1])
            params[key] = value
        }
        
    } else {
        // 单个参数
        let pairComponents = string.split(separator: "=")
        if pairComponents.count == 1 {
            return "nil"
        }
        let key: String = String(pairComponents[0])
        let value: String = String(pairComponents[1])
        params[key] = value
    }
    
    return params["category_id"] as! String
}
