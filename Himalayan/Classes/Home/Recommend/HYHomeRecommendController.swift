//
//  HYHomeRecommendController.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

/// 首页推荐控制器
class HYHomeRecommendController: HYHomeBaseViewController {
    let otherMessages = SwiftMessages()
    // MARK: - 数据模型
    var recommendAdvertList: [RecommendAdvertModel]? // 穿插的广告数据
    
    //MARK - cell 注册ID
    private let HYRecommendHeaderViewID     = "HYRecommendHeaderView"
    private let HYRecommendFooterViewID     = "HYRecommendFooterView"

    private let HYRecommendHeaderCellID     = "HYRecommendHeaderCCell"
    private let HYRecommendGuessLikeCellID  = "HYRecommendGuessLikeCCell"
    private let HYHotAudiobookCellID        = "HYHotAudiobookCCell"
    private let HYAdvertCellID              = "HYAdvertCCell"
    private let HYOneKeyListenCellID        = "HYOneKeyListenCCell"
    private let HYRecommendForYouCellID     = "HYRecommendForYouCCell"
    private let HomeRecommendLiveCellID     = "HomeRecommendLiveCCell"
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        /// 注册头视图和尾视图
        collectionView.register(HYRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HYRecommendHeaderViewID)
        collectionView.register(HYRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HYRecommendFooterViewID)
        
        /// 注册不同分区cell
        collectionView.register(HYRecommendHeaderCCell.self, forCellWithReuseIdentifier: HYRecommendHeaderCellID)
        collectionView.register(HYRecommendGuessLikeCCell.self, forCellWithReuseIdentifier: HYRecommendGuessLikeCellID)
        collectionView.register(HYHotAudiobookCCell.self, forCellWithReuseIdentifier: HYHotAudiobookCellID)
        collectionView.register(HYAdvertCCell.self, forCellWithReuseIdentifier: HYAdvertCellID)
        collectionView.register(HYOneKeyListenCCell.self, forCellWithReuseIdentifier: HYOneKeyListenCellID)
        collectionView.register(HYRecommendForYouCCell.self, forCellWithReuseIdentifier: HYOneKeyListenCellID)
        collectionView.register(HomeRecommendLiveCCell.self, forCellWithReuseIdentifier: HomeRecommendLiveCellID)
        collectionView.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return collectionView
    }()
    
    lazy var viewModel: HomeRecommendViewModel = {
        return HomeRecommendViewModel()
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        self.collectionView.uHead.beginRefreshing()
        loadData()
        loadRecommendAdData()
    }
    

    /// 加载数据
    func loadData() {
        /// 加载数据
        viewModel.updateBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    /// 加载广告数据
    func loadRecommendAdData() {
        HYRecommendProvider.request(.recommendAdList) { (result) in
            if case let .success(response) = result {
                /// 解析
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let advertList = JSONDeserializer<RecommendAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) {
                    self.recommendAdvertList = advertList as? [RecommendAdvertModel]
                    self.collectionView.reloadData()
                }
                
            }
        }
    }


}

extension HYHomeRecommendController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView: collectionView)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
            let cell: HYRecommendHeaderCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYRecommendHeaderCellID, for: indexPath) as! HYRecommendHeaderCCell
            cell.focusModel = viewModel.focus
            cell.squareList = viewModel.squareList
            cell.topBuzzListData = viewModel.topBuzzList
            cell.delegate = self
            return cell
        } else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            /// 横排布局
            let cell: HYRecommendGuessLikeCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYRecommendGuessLikeCellID, for: indexPath) as! HYRecommendGuessLikeCCell
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        } else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore" {
            /// 竖排布局
            let cell: HYHotAudiobookCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYHotAudiobookCellID, for: indexPath) as! HYHotAudiobookCCell
            
            cell.delegate = self
            cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
            return cell
        } else if moduleType == "ad" {
            let cell: HYAdvertCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYAdvertCellID, for: indexPath) as! HYAdvertCCell
            if indexPath.section == 7 {
                cell.adModel = self.recommendAdvertList?[0]
            } else if indexPath.section == 13 {
                cell.adModel = self.recommendAdvertList?[1]
            } else if indexPath.section == 17 {
                cell.adModel = self.recommendAdvertList?[2]
            }
            return cell
        } else if moduleType == "oneKeyListen" {
            let cell: HYOneKeyListenCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYOneKeyListenCellID, for: indexPath) as! HYOneKeyListenCCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
            return cell
        } else if moduleType == "live" {
            let cell: HomeRecommendLiveCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendLiveCellID, for: indexPath) as! HomeRecommendLiveCCell
            
            cell.liveList = viewModel.liveList
            return cell
        } else {
            let cell: HYRecommendForYouCCell = collectionView.dequeueReusableCell(withReuseIdentifier: HYRecommendForYouCellID, for: indexPath) as! HYRecommendForYouCCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return viewModel.insetForSectionAt(section: section)
    }

    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumInteritemSpacingForSectionAt(section: section)
    }

    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewModel.minimumLineSpacingForSectionAt(section: section)
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return viewModel.referenceSizeForHeaderInSection(section: section)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
       return viewModel.referenceSizeForFooterInSection(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView: HYRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HYRecommendHeaderViewID, for: indexPath) as! HYRecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendList?[indexPath.section]
            /// 分区头右边更多按钮点击跳转
            headerView.headerMoreBtnClick = { [weak self]() in
                if moduleType == "guessYouLike" {
                    let vc = HomeGuessYouLikeMoreController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if moduleType == "paidCategory" {
                    let vc = HYHomeVIPController()
                    vc.title = "精品"
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else if moduleType == "live" {
                    let vc = HYHomeLiveController()
                    vc.title = "直播"
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else { return }
                    if categoryId != 0 {
                        let vc = ClassifySubMenuController(categoryId: categoryId, isVipPush: false)
                        vc.title = self?.viewModel.homeRecommendList?[indexPath.section].title
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView: HYRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: HYRecommendFooterViewID, for: indexPath) as! HYRecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}

// Mark:- 点击顶部分类按钮进入相对应界面
extension HYHomeRecommendController: HYRecommendHeaderCellDelegate {
    func recommendHeaderBtnClick(categoryId: String, title: String, url: String) {
        if url == "" {
            if categoryId == "0" {
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].randomElement()!
                warning.configureContent(title: "Warning", body: "别点了, 暂时没数据啦!!!", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
                
            } else {
                // TODO: 等待将来回来做: ClassifySubMenuController
                print("等待将来回来做")
            }
        } else {
            let vc = HYWebViewController(url: url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func recommendHeaderBannerClick(url: String) {
        let status = MessageView.viewFromNib(layout: .statusLine)
        status.backgroundView.backgroundColor = DominantColor
        status.bodyLabel?.textColor = UIColor.white
        status.configureContent(body: "哎呀呀!咋没反应呢???")
        var statusConfig = SwiftMessages.defaultConfig
        statusConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
        statusConfig.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: statusConfig, view: status)
    }
}

extension HYHomeRecommendController: HYRecommendGuessLikeCCellDelegate {
    func recommendGGuessLikeCellItemClick(model: RecommendListModel) {
        // TODO: 等待将来回来做: 1234
        print("等待将来回来做")
    }
    
    
}

extension HYHomeRecommendController: HYHotAudiobookCCellDelegate {
    func hotAudiobookCCellItemClick(model: RecommendListModel) {
        // TODO: 等待将来回来做: <#DESC#>
        print("等待将来回来做")
    }
    
    
}
