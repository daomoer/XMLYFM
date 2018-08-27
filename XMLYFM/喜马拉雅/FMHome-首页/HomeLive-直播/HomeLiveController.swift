//
//  HomeLiveController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

let HomeLiveSectionGrid     = 0   // 分类section
let HomeLiveSectionBanner   = 1   // 滚动图片section
let HomeLiveSectionRank     = 2   // 排行榜section
let HomeLiveSectionLive     = 3   // 直播section

/// 首页直播控制器
class HomeLiveController: HomeBaseViewController {
    var lives:[LivesModel]?

    private let HomeLiveHeaderViewID = "HomeLiveHeaderView"
    private let RecommendLiveCellID = "RecommendLiveCell"
    private let HomeLiveGridCellID   = "HomeLiveGridCell"
    private let HomeLiveBannerCellID = "HomeLiveBannerCell"
    private let HomeLiveRankCellID   = "HomeLiveRankCell"
    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.showsVerticalScrollIndicator = false
        // MARK -注册头视图和尾视图
        collection.register(HomeLiveHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeLiveHeaderViewID)
//        // MARK -注册不同分区cell
        collection.register(RecommendLiveCell.self, forCellWithReuseIdentifier: RecommendLiveCellID)
        collection.register(HomeLiveGridCell.self, forCellWithReuseIdentifier:HomeLiveGridCellID)
        collection.register(HomeLiveBannerCell.self, forCellWithReuseIdentifier:HomeLiveBannerCellID)
        collection.register(HomeLiveRankCell.self, forCellWithReuseIdentifier:HomeLiveRankCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadLiveData() }
        return collection
    }()
    
    lazy var viewModel: HomeLiveViewModel = {
        return HomeLiveViewModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        //刚进页面进行刷新
        self.collectionView.uHead.beginRefreshing()
        loadLiveData()
    }
    
    func loadLiveData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}
// MARK: - collectionviewDelegate
extension HomeLiveController: UICollectionViewDelegate, UICollectionViewDataSource ,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case HomeLiveSectionGrid:
            let cell:HomeLiveGridCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLiveGridCellID, for: indexPath) as! HomeLiveGridCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.delegate = self
            return cell
        case HomeLiveSectionBanner:
            let cell:HomeLiveBannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLiveBannerCellID, for: indexPath) as! HomeLiveBannerCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.bannerList = viewModel.homeLiveBanerList
            return cell
        case HomeLiveSectionRank:
            let cell:HomeLiveRankCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeLiveRankCellID, for: indexPath) as! HomeLiveRankCell
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            cell.backgroundColor = UIColor.red
            cell.multidimensionalRankVos = viewModel.multidimensionalRankVos
            return cell
        default:
            let cell:RecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendLiveCellID, for: indexPath) as! RecommendLiveCell
            cell.liveData = viewModel.lives?[indexPath.row]
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : HomeLiveHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HomeLiveHeaderViewID, for: indexPath) as! HomeLiveHeaderView
            headerView.delegate = self
            headerView.backgroundColor = UIColor.white
            return headerView
        }else {
            return UICollectionReusableView()
            
        }
    }
}

// Mark: - 点击顶部分类按钮 delegate
extension HomeLiveController:HomeLiveGridCellDelegate{
    func homeLiveGridCellItemClick(channelId: Int,title:String) {
        let vc = LiveCategoryListController(channelId: channelId)
        vc.title = title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// Mark: - 点击中间直播item上分类按钮 delegate
extension HomeLiveController:HomeLiveHeaderViewDelegate{
    func homeLiveHeaderViewCategoryBtnClick(button: UIButton) {
        viewModel.categoryType = button.tag - 988
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshCategoryLiveData()
    }
}


