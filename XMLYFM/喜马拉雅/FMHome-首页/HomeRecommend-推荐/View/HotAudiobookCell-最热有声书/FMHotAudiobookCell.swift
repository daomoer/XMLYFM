//
//  FMHotAudiobookCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
/// 添加cell点击代理方法
protocol FMHotAudiobookCellDelegate:NSObjectProtocol {
    func hotAudiobookCellItemClick(model:RecommendListModel)
}

class FMHotAudiobookCell: UICollectionViewCell {
    weak var delegate : FMHotAudiobookCellDelegate?

    private var recommendList:[RecommendListModel]?

    private let HotAudiobookCellID = "HotAudiobookCell"
    private lazy var changeBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("换一批", for: UIControlState.normal)
        button.setTitleColor(DominantColor, for: UIControlState.normal)
        button.backgroundColor = UIColor.init(red: 254/255.0, green: 232/255.0, blue: 227/255.0, alpha: 1)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 5.0
        return button
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collectionView = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.white
        collectionView.alwaysBounceVertical = true
        collectionView.register(HotAudiobookCell.self, forCellWithReuseIdentifier: HotAudiobookCellID)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.top.equalTo(15)
            make.bottom.equalToSuperview().offset(-50)
            make.right.equalToSuperview().offset(-15)
        }
        
        self.addSubview(self.changeBtn)
        self.changeBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var recommendListData:[RecommendListModel]? {
        didSet{
            guard let model = recommendListData else { return }
            self.recommendList = model
            self.collectionView.reloadData()
        }
    }
}

extension FMHotAudiobookCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommendList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:HotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: HotAudiobookCellID, for: indexPath) as! HotAudiobookCell
        cell.recommendData = self.recommendList?[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.hotAudiobookCellItemClick(model: (self.recommendList?[indexPath.row])!)
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
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
        return CGSize.init(width:YYScreenWidth-30,height:120)
    }
}
