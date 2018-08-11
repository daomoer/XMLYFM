//
//  HomeVipCategoriesCell.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/2.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class HomeVipCategoriesCell: UITableViewCell {
    private var categoryBtnList:[CategoryBtnModel]?
    // MARK: - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:YYScreenWidth/5, height:80)
        layout.scrollDirection = UICollectionViewScrollDirection.horizontal
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.contentSize = CGSize.init(width: YYScreenWidth, height: 80)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(VipCategoryCell.self, forCellWithReuseIdentifier:"VipCategoryCell")
        
        return collectionView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.right.height.width.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var categoryBtnModel : [CategoryBtnModel]? {
        didSet {
            guard let model = categoryBtnModel else {return}
            self.categoryBtnList = model
            self.collectionView.reloadData()
        }
    }
}

extension HomeVipCategoriesCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.categoryBtnList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:VipCategoryCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VipCategoryCell", for: indexPath) as! VipCategoryCell
        cell.backgroundColor = UIColor.white
        cell.categoryBtnModel = self.categoryBtnList?[indexPath.row]
        return cell
    }
}
