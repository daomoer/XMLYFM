//
//  FMOneKeyListenCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class FMOneKeyListenCell: UICollectionViewCell {
    private var oneKeyListen:[OneKeyListenModel]?
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("换一批", for: UIControlState.normal)
        button.setTitleColor(DominantColor, for: UIControlState.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(updataBtnClick(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    // MARK: - 懒加载九宫格分类按钮
    private lazy var gridView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (YYScreenWidth-45)/3, height:120)
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(OneKeyListenCell.self, forCellWithReuseIdentifier: "OneKeyListenCell")
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    // 初始化
    func setUpUI(){
        self.addSubview(self.gridView)
        self.gridView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-40)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    // 更换一批按钮刷新cell
    @objc func updataBtnClick(button:UIButton){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var oneKeyListenList:[OneKeyListenModel]? {
        didSet {
            guard let model = oneKeyListenList else { return }
            self.oneKeyListen = model
            self.gridView.reloadData()
        }
    }
}

extension FMOneKeyListenCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.oneKeyListen?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:OneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneKeyListenCell", for: indexPath) as! OneKeyListenCell
        cell.oneKeyListen = self.oneKeyListen?[indexPath.row]
        return cell
    }
}
