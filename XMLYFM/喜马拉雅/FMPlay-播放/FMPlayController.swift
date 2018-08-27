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
    // 外部传值请求接口如此那
    private var albumId :Int = 0
    private var trackUid:Int = 0
    private var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0, uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
    private let FMPlayHeaderViewID      = "FMPlayHeaderView"
    private let FMPlayFooterViewID      = "FMPlayFooterView"
    
    private let FMPlayCellID            = "FMPlayCell"
    private let FMPlayCommentCellID     = "FMPlayCommentCell"
    private let FMPlayAnchorCellID      = "FMPlayAnchorCell"
    private let FMPlayCircleCellID      = "FMPlayCircleCell"
  
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // MARK -注册头视图和尾视图
        collection.register(FMPlayHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMPlayHeaderViewID)
        collection.register(FMPlayFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMPlayFooterViewID)
        // MARK -注册不同分区cell
        collection.register(FMPlayCell.self, forCellWithReuseIdentifier: FMPlayCellID)
        collection.register(FMPlayCommentCell.self, forCellWithReuseIdentifier: FMPlayCommentCellID)
        collection.register(FMPlayAnchorCell.self, forCellWithReuseIdentifier: FMPlayAnchorCellID)
        collection.register(FMPlayCircleCell.self, forCellWithReuseIdentifier: FMPlayCircleCellID)

        return collection
    }()
    
    lazy var viewModel: FMPlayViewModel = {
        return FMPlayViewModel(albumId:self.albumId,trackUid:self.trackUid, uid:self.uid)
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
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    //    // 控制向上滚动显示导航栏标题和左右按钮
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if (offsetY > 0)
        {
            let alpha = offsetY / CGFloat(kNavBarBottom)
            navBarBackgroundAlpha = alpha
            print("lala")
        }else{
            navBarBackgroundAlpha = 0
            print("zhege")
        }
    }
}

extension FMPlayController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell:FMPlayCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMPlayCellID, for: indexPath) as! FMPlayCell
            cell.playTrackInfo = viewModel.playTrackInfo
            return cell
        }else if indexPath.section == 1{
            let cell:FMPlayAnchorCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMPlayAnchorCellID, for: indexPath) as! FMPlayAnchorCell
            cell.userInfo = viewModel.userInfo
            return cell
        }else if indexPath.section == 2{
            let cell:FMPlayCircleCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMPlayCircleCellID, for: indexPath) as! FMPlayCircleCell
            cell.communityInfo = viewModel.communityInfo
            return cell
        }else{
            let cell:FMPlayCommentCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMPlayCommentCellID, for: indexPath) as! FMPlayCommentCell
            cell.playCommentInfo = viewModel.playCommentInfo?[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = YYNavigationController.init(rootViewController: FMPlayDetailController())
        self.navigationController?.pushViewController(vc, animated: true)
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
        if kind == UICollectionElementKindSectionHeader {
            let headerView : FMPlayHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMPlayHeaderViewID, for: indexPath) as! FMPlayHeaderView
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : FMPlayFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMPlayFooterViewID, for: indexPath) as! FMPlayFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
