//
//  HYOneKeyListenCCell.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import UIKit

class HYOneKeyListenCCell: HYBaseCollectionViewCell {
    private var oneKeyListen: [OneKeyListenModel]?
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
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(OneKeyListenCCell.self, forCellWithReuseIdentifier: "OneKeyListenCCell")
        return collectionView
    }()
    
    override func setupUI() {
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints {
            $0.left.top.equalToSuperview().offset(15)
            $0.right.equalToSuperview().offset(-15)
            $0.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(30)
            $0.width.equalTo(100)
        }
    }

    /// 更换一批按钮刷新cell
    @objc func updateBtnClick(button: UIButton) {
        // TODO: 等待将来回来做: <#DESC#>
        print("等待将来回来做")
    }
    
    var oneKeyListenList: [OneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            self.oneKeyListen = model
            self.gridView.reloadData()
        }
    }
}

extension HYOneKeyListenCCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: OneKeyListenCCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneKeyListenCCell", for: indexPath) as! OneKeyListenCCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }
    
    
}
