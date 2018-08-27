//
//  HomeRecommendController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON
import SwiftMessages

/// 首页推荐控制器
class HomeRecommendController: HomeBaseViewController {
    let otherMessages = SwiftMessages()
    // MARK - 数据模型
    private var recommnedAdvertList:[RecommnedAdvertModel]? // 穿插的广告数据
    //MARK - cell 注册ID
    private let FMRecommendHeaderViewID     = "FMRecommendHeaderView"
    private let FMRecommendFooterViewID     = "FMRecommendFooterView"

    private let FMRecommendHeaderCellID     = "FMRecommendHeaderCell"
    private let FMRecommendGuessLikeCellID  = "FMRecommendGuessLikeCell"
    private let FMHotAudiobookCellID        = "FMHotAudiobookCell"
    private let FMAdvertCellID              = "FMAdvertCell"
    private let FMOneKeyListenCellID        = "FMOneKeyListenCell"
    private let FMRecommendForYouCellID     = "FMRecommendForYouCell"
    private let HomeRecommendLiveCellID     = "HomeRecommendLiveCell"

    
    lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // MARK -注册头视图和尾视图
        collection.register(FMRecommendHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID)

        // MARK -注册不同分区cell
        collection.register(FMRecommendHeaderCell.self, forCellWithReuseIdentifier: FMRecommendHeaderCellID)
        collection.register(FMRecommendGuessLikeCell.self, forCellWithReuseIdentifier: FMRecommendGuessLikeCellID)
        collection.register(FMHotAudiobookCell.self, forCellWithReuseIdentifier: FMHotAudiobookCellID)
        collection.register(FMAdvertCell.self, forCellWithReuseIdentifier: FMAdvertCellID)
        collection.register(FMOneKeyListenCell.self, forCellWithReuseIdentifier: FMOneKeyListenCellID)
        collection.register(FMRecommendForYouCell.self, forCellWithReuseIdentifier: FMRecommendForYouCellID)
        collection.register(HomeRecommendLiveCell.self, forCellWithReuseIdentifier: HomeRecommendLiveCellID)
        collection.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return collection
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
    
    func loadData(){
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.collectionView.uHead.endRefreshing()
            // 更新列表数据
            self.collectionView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
    func loadRecommendAdData() {
        //        //首页穿插广告接口请求
        FMRecommendProvider.request(.recommendAdList) { result in
        if case let .success(response) = result {
        //解析数据
            let data = try? response.mapJSON()
            let json = JSON(data!)
            if let advertList = JSONDeserializer<RecommnedAdvertModel>.deserializeModelArrayFrom(json: json["data"].description) { // 从字符串转换为对象实例
                self.recommnedAdvertList = advertList as? [RecommnedAdvertModel]
                self.collectionView.reloadData()
            }
        }
      }
    }
}

// MARK - collectionDelegate
extension HomeRecommendController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections(collectionView:collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let moduleType = viewModel.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" {
                let cell:FMRecommendHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderCell
                cell.focusModel = viewModel.focus
                cell.squareList = viewModel.squareList
                cell.topBuzzListData = viewModel.topBuzzList
                cell.delegate = self
                return cell
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory"{
            ///横式排列布局cell
                let cell:FMRecommendGuessLikeCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendGuessLikeCellID, for: indexPath) as! FMRecommendGuessLikeCell
                cell.delegate = self
                cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
                return cell
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            // 竖式排列布局cell
                let cell:FMHotAudiobookCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMHotAudiobookCellID, for: indexPath) as! FMHotAudiobookCell
            cell.delegate = self
                cell.recommendListData = viewModel.homeRecommendList?[indexPath.section].list
                return cell
        }else if moduleType == "ad" {
                let cell:FMAdvertCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMAdvertCellID, for: indexPath) as! FMAdvertCell
            if indexPath.section == 7 {
                cell.adModel = self.recommnedAdvertList?[0]
            }else if indexPath.section == 13 {
                cell.adModel = self.recommnedAdvertList?[1]
//            }else if indexPath.section == 17 {
//                cell.adModel = self.recommnedAdvertList?[2]
            }
                return cell
        }else if moduleType == "oneKeyListen" {
                let cell:FMOneKeyListenCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMOneKeyListenCellID, for: indexPath) as! FMOneKeyListenCell
            cell.oneKeyListenList = viewModel.oneKeyListenList
                return cell
        }else if moduleType == "live" {
            let cell:HomeRecommendLiveCell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeRecommendLiveCellID, for: indexPath) as! HomeRecommendLiveCell
            cell.liveList = viewModel.liveList
            return cell
        }
        else {
                let cell:FMRecommendForYouCell = collectionView.dequeueReusableCell(withReuseIdentifier: FMRecommendForYouCellID, for: indexPath) as! FMRecommendForYouCell
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
        if kind == UICollectionElementKindSectionHeader {
            let headerView : FMRecommendHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: FMRecommendHeaderCellID, for: indexPath) as! FMRecommendHeaderView
            headerView.homeRecommendList = viewModel.homeRecommendList?[indexPath.section]
            // 分区头右边更多按钮点击跳转
            headerView.headerMoreBtnClick = {[weak self]() in
                if moduleType == "guessYouLike"{
                    let vc = HomeGuessYouLikeMoreController()
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "paidCategory" {
                    let vc = HomeVIPController(isRecommendPush:true)
                    vc.title = "精品"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else if moduleType == "live"{
                    let vc = HomeLiveController()
                    vc.title = "直播"
                    self?.navigationController?.pushViewController(vc, animated: true)
                }else {
                    guard let categoryId = self?.viewModel.homeRecommendList?[indexPath.section].target?.categoryId else {return}
                    if categoryId != 0 {
                        let vc = ClassifySubMenuController(categoryId:categoryId,isVipPush:false)
                        vc.title = self?.viewModel.homeRecommendList?[indexPath.section].title
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : FMRecommendFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: FMRecommendFooterViewID, for: indexPath) as! FMRecommendFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}

// Mark:- 点击顶部分类按钮进入相对应界面
extension HomeRecommendController:FMRecommendHeaderCellDelegate {
    func recommendHeaderBannerClick(url: String) {
        let status2 = MessageView.viewFromNib(layout: .statusLine)
        status2.backgroundView.backgroundColor = DominantColor
        status2.bodyLabel?.textColor = UIColor.white
        status2.configureContent(body: "哎呀呀!咋没反应呢???")
        var status2Config = SwiftMessages.defaultConfig
        status2Config.presentationContext = .window(windowLevel: UIWindowLevelNormal)
        status2Config.preferredStatusBarStyle = .lightContent
        SwiftMessages.show(config: status2Config, view: status2)
    }
    
    func recommendHeaderBtnClick(categoryId:String,title:String,url:String){
        if url == ""{
            if categoryId == "0"{
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
                warning.configureContent(title: "Warning", body: "别点了,接口变了,暂时没数据啦!!!", iconText: iconText)
                warning.button?.isHidden = true
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            }else{
                let vc = ClassifySubMenuController(categoryId:Int(categoryId)!)
                vc.title = title
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let vc = FMWebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// Mark: -点击猜你喜欢cell代理方法
extension HomeRecommendController:FMRecommendGuessLikeCellDelegate {
    func recommendGuessLikeCellItemClick(model: RecommendListModel) {
        let vc = FMPlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

// Mark: -点击热门有声书等cell代理方法
extension HomeRecommendController:FMHotAudiobookCellDelegate {
    func hotAudiobookCellItemClick(model: RecommendListModel) {
        let vc = FMPlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}





