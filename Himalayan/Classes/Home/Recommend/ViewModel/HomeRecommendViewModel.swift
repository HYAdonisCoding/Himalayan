//
//  HomeRecommendViewModel.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/18.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeRecommendViewModel: NSObject {
    // MARK: - 数据模型
    var hyHomeRecommendModel: HYHomeRecommendModel?
    var homeRecommendList: [HomeRecommendModel]?
    var recommendList: [RecommendListModel]?
    var focus: FocusModel?
    var squareList: [SquareModel]?
    var topBuzzList: [TopBuzzModel]?
    var guessYouLikeList: [GuessYouLikeModel]?
    var paidCategoryList: [PaidCategoryModel]?
    var playList: PlaylistModel?
    var oneKeyListenList: [OneKeyListenModel]?
    var liveList: [LiveModel]?
    
    // MARK: - 数据源更新
    typealias AddDataBlock = () -> Void
    var updateBlock: AddDataBlock?
}

// MARK: - 请求数据
extension HomeRecommendViewModel {
    func refreshDataSource() {
        // 首页推荐接口
        HYRecommendProvider.request(.recommendList) { (result) in
            if case let .success(response) = result {
                /// 解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HYHomeRecommendModel>.deserializeFrom(json: json.description) {
                    /// 从字符串转换为对象实例
                    self.hyHomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [RecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    
                    if let topBuzzList = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzzList as? [TopBuzzModel]
                    }
                    if let oneKeyListenList = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListenList as? [OneKeyListenModel]
                    }
                    if let liveList = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = liveList as? [LiveModel]
                    }
                    self.updateBlock?()
                }
                
            }
        }
    }
}

/// MARK: - 数据
extension HomeRecommendViewModel {
    func numberOfSections(collectionView: UICollectionView) -> Int {
        return (self.homeRecommendList?.count) ?? 0
    }
    /// 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    /// 每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /// 最小 item 间距
    func minmumInteritemSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    
    /// 最小行间距
    func minimumLineSpacingForSectionAt(section: Int) -> CGFloat {
        return 0
    }
    
    /// item尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let headerAndFooterHeight: Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width: ScreenWidth, height: 360)
        } else if moduleType == "square" || moduleType == "topBuzz" {
            return .zero
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live" {
            return CGSize.init(width: ScreenWidth, height: CGFloat(headerAndFooterHeight+180*itemNums))
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore" {
            return CGSize.init(width: ScreenWidth, height: CGFloat(headerAndFooterHeight+120*count!))
        } else if moduleType == "ad" {
            return CGSize.init(width: ScreenWidth, height: 240)
        } else if moduleType == "oneKeyListen" {
            return CGSize.init(width: ScreenWidth, height: 180)
        } else {
            return .zero
        }
        
    }
    /// 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let modleType = self.homeRecommendList?[section].moduleType
        if modleType == "focus" || modleType == "square" || modleType == "topBuzz" || modleType == "ad" || section == 18 {
            return .zero
        } else {
            return CGSize.init(width: ScreenWidth, height: 40)
        }
    }
    
    /// 分区尾视图
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let modleType = self.homeRecommendList?[section].moduleType
        if modleType == "focus" || modleType == "square" {
            return .zero
        } else {
            return CGSize.init(width: ScreenWidth, height: 10)
        }
    }
}
