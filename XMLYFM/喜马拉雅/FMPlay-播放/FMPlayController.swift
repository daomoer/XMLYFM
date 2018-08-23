//
//  FMPlayController.swift
//  XMLYFM
//
//  Created by Domo on 2018/7/30.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class FMPlayController: UIViewController {
//    private let FMPlayHeaderViewID      = "FMPlayHeaderView"
//    private let ClassifySubFooterViewID = "ClassifySubFooterView"
    
    var playTrackInfo:FMPlayTrackInfo?
    private let FMPlayHeaderViewID = "FMPlayHeaderView"

    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // MARK -注册头视图和尾视图
//        collection.register(FMPlayHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMPlayHeaderViewID)
//        collection.register(ClassifySubFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ClassifySubFooterViewID)
        //
        // MARK -注册不同分区cell
        collection.register(FMPlayHeaderView.self, forCellWithReuseIdentifier: FMPlayHeaderViewID)

        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.width.height.equalToSuperview()
            make.center.equalToSuperview()
        }
        loadData()
    }
    func loadData(){
        FMPlayProvider.request(FMPlayAPI.fmPlayData(albumId:2863318,trackUid:1076337)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let playTrackInfo = JSONDeserializer<FMPlayTrackInfo>.deserializeFrom(json: json["trackInfo"].description) { // 从字符串转换为对象实例
                    self.playTrackInfo = playTrackInfo
                    self.collectionView.reloadData()
                }
            }
        }
    }
}

extension FMPlayController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell:FMPlayHeaderView = collectionView.dequeueReusableCell(withReuseIdentifier: FMPlayHeaderViewID, for: indexPath) as! FMPlayHeaderView
        cell.playTrackInfo = self.playTrackInfo
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:YYScreenWidth,height:YYScreenHeigth*0.8)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize.init(width:YYScreenWidth,height:400)
//        }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        return CGSize.init(width:YYScreenWidth,height:10)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        if kind == UICollectionElementKindSectionHeader {
//            let headerView : FMPlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMPlayHeaderViewID, for: indexPath) as! FMPlayHeaderView
//            return headerView
//        }else if kind == UICollectionElementKindSectionFooter {
//            let footerView : ClassifySubFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ClassifySubFooterViewID, for: indexPath) as! ClassifySubFooterView
//            return footerView
//        }
//        return UICollectionReusableView()
//    }
}
