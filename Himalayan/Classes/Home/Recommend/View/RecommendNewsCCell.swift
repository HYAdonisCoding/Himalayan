//
//  RecommendNewsCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class RecommendNewsCCell: HYBaseCollectionViewCell {
    
    private var topBuzz: [TopBuzzModel]?
    
    private lazy var imageView: UIImageView = {
        let name = UIImageView()
        name.image = UIImage(named: "news.png")
        return name
    }()
    
    private lazy var moreBtn: UIButton = {
        let name = UIButton.init(type: UIButton.ButtonType.custom)
        name.setTitle("| 更多", for: UIControl.State.normal)
        name.setTitleColor(UIColor.gray, for: UIControl.State.normal)
        name.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return name
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let name = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = UICollectionView.ScrollDirection.vertical
        name.contentSize = CGSize(width: (ScreenWidth-150), height: 40)
        name.delegate = self
        name.dataSource = self
        name.backgroundColor = UIColor.white
        name.showsVerticalScrollIndicator = false
        name.showsHorizontalScrollIndicator = false
        name.isPagingEnabled = true
        name.isScrollEnabled = false
        name.register(NewsCell.self, forCellWithReuseIdentifier: "NewsCell")
        return name
    }()
    
    var timer: Timer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        startTimer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(-5)
            $0.width.equalTo(60)
            $0.height.equalTo(30)
            $0.top.equalTo(10)
        }
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-5)
            $0.width.equalTo(60)
            $0.height.equalTo(40)
            $0.top.equalTo(6)
        }
        self.addSubview(self.collectionView)
        // FIXME: 未来记得回来修改哦: 没约束啊
        print("未来记得回来修改哦")

    }
    
    var topBuzzList: [TopBuzzModel]? {
        didSet {
            guard let model = topBuzzList else { return }
            self.topBuzz = model
            self.collectionView.reloadData()
        }
    }


}

extension RecommendNewsCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.topBuzz?.count ?? 0)*100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.titleLabel.text = self.topBuzzList?[indexPath.row%(self.topBuzz?.count)!].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row%(self.topBuzz?.count)!)
    }
    /// 开启定时器
    func startTimer() {
        let timer = Timer.init(timeInterval: 2, target: self, selector: #selector(nextPage), userInfo: nil, repeats: true)
        // 这一句代码涉及到runloop 和 主线程的知识,则在界面上不能执行其他的UI操作
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
        self.timer = timer
    }

    /// 在1秒后,自动跳转到下一页
    @objc func nextPage() {
        // 获取 x滚动偏移量
        let currentOffsetY = collectionView.contentOffset.y
        let offsetY = currentOffsetY + collectionView.bounds.height
        /// 滚动该位置
        collectionView.setContentOffset(CGPoint(x: 0, y: offsetY), animated: true)
        
    }
    
    /// 当collectionView开始拖动的时候,取消定时器
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timer?.invalidate()
        self.timer = nil
    }
    /// 当用户停止拖动的时候,开启定时器
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        startTimer()
    }
}

class NewsCell: HYBaseCollectionViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override func setupUI() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
