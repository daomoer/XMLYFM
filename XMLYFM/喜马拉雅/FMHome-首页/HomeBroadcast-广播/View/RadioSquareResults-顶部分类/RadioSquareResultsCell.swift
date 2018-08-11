//
//  RadioSquareResultsCell.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/1.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class RadioSquareResultsCell: UICollectionViewCell {
    private var radioSquareResults:[RadioSquareResultsModel]?
    // MARK: - 懒加载九宫格分类按钮
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width:YYScreenWidth/5, height:self.frame.size.height)
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.register(RadioSquareCell.self, forCellWithReuseIdentifier:"RadioSquareCell")
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
           make.left.right.height.width.equalToSuperview()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var radioSquareResultsModel : [RadioSquareResultsModel]? {
        didSet {
            guard let model = radioSquareResultsModel else {return}
                self.radioSquareResults = model
                self.collectionView.reloadData()
            }
        }
}

extension RadioSquareResultsCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.radioSquareResults?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:RadioSquareCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RadioSquareCell", for: indexPath) as! RadioSquareCell
        cell.backgroundColor = UIColor.white
        cell.radioSquareModel = self.radioSquareResults?[indexPath.row]
        return cell
    }
}
