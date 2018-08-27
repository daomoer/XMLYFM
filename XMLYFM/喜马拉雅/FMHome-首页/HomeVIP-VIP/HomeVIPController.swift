//
//  HomeVIPController.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftMessages

let HomeVipSectionBanner    = 0   // 滚动图片section
let HomeVipSectionGrid      = 1   // 分类section
let HomeVipSectionHot       = 2   // 热section
let HomeVipSectionEnjoy     = 3   // 尊享section
let HomeVipSectionVip       = 4   // vip section

/// 首页vip控制器
class HomeVIPController: HomeBaseViewController {
    //Mark: - 上页面传过来请求接口必须的参数
    convenience init(isRecommendPush:Bool = false) {
        self.init()
        self.tableView.frame = CGRect(x:0,y:0,width:YYScreenWidth,height:YYScreenHeigth)
    }
    
    private let HomeVIPCellID           = "HomeVIPCell"
    
    private let HomeVipHeaderViewID     = "HomeVipHeaderView"
    private let HomeVipFooterViewID     = "HomeVipFooterView"
    private let HomeVipBannerCellID     = "HomeVipBannerCell"
    private let HomeVipCategoriesCellID = "HomeVipCategoriesCell"
    private let HomeVipHotCellID        = "HomeVipHotCell"
    private let HomeVipEnjoyCellID      = "HomeVipEnjoyCell"

    
    private var currentTopSectionCount: Int64 = 0
    
    lazy var headView : UIView = {
        let view = UIView.init(frame: CGRect(x:0, y:0, width: YYScreenWidth, height: 30))
        view.backgroundColor = UIColor.purple
        return view
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0, y:0, width: YYScreenWidth, height:YYScreenHeigth-64-44-49), style: UITableViewStyle.grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        // 注册头尾视图
        tableView.register(HomeVipHeaderView.self, forHeaderFooterViewReuseIdentifier: HomeVipHeaderViewID)
        tableView.register(HomeVipFooterView.self, forHeaderFooterViewReuseIdentifier: HomeVipFooterViewID)
        // 注册分区cell
        tableView.register(HomeVIPCell.self, forCellReuseIdentifier: HomeVIPCellID)
        tableView.register(HomeVipBannerCell.self, forCellReuseIdentifier: HomeVipBannerCellID)
        tableView.register(HomeVipCategoriesCell.self, forCellReuseIdentifier: HomeVipCategoriesCellID)
        tableView.register(HomeVipHotCell.self, forCellReuseIdentifier: HomeVipHotCellID)
        tableView.register(HomeVipEnjoyCell.self, forCellReuseIdentifier: HomeVipEnjoyCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.loadData() }
        return tableView
    }()
    
    lazy var viewModel: HomeVipViewModel = {
        return HomeVipViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        //刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        loadData()
    }
    
    func loadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            self.tableView.uHead.endRefreshing()
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
}

extension HomeVIPController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.categoryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case HomeVipSectionBanner:
            let cell:HomeVipBannerCell = tableView.dequeueReusableCell(withIdentifier: HomeVipBannerCellID, for: indexPath) as! HomeVipBannerCell
            cell.vipBannerList = viewModel.focusImages
            cell.delegate = self
            return cell
        case HomeVipSectionGrid:
            let cell:HomeVipCategoriesCell = tableView.dequeueReusableCell(withIdentifier: HomeVipCategoriesCellID, for: indexPath) as! HomeVipCategoriesCell
            cell.categoryBtnModel = viewModel.categoryBtnList
            cell.delegate = self
            return cell
        case HomeVipSectionHot:
            let cell:HomeVipHotCell = tableView.dequeueReusableCell(withIdentifier: HomeVipHotCellID, for: indexPath) as! HomeVipHotCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        case HomeVipSectionEnjoy:
            let cell:HomeVipEnjoyCell = tableView.dequeueReusableCell(withIdentifier: HomeVipEnjoyCellID, for: indexPath) as! HomeVipEnjoyCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list
            cell.delegate = self
            return cell
        default:
            let cell:HomeVIPCell = tableView.dequeueReusableCell(withIdentifier: HomeVIPCellID, for: indexPath) as! HomeVIPCell
            cell.categoryContentsModel = viewModel.categoryList?[indexPath.section].list?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FMPlayDetailController(albumId: (viewModel.categoryList?[indexPath.section].list?[indexPath.row].albumId)!)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewModel.heightForHeaderInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:HomeVipHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeVipHeaderViewID) as! HomeVipHeaderView
        headerView.titStr = viewModel.categoryList?[section].title
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return viewModel.heightForFooterInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = FooterViewColor
        return view
    }
}
extension HomeVIPController:HomeVipBannerCellDelegate{
    func homeVipBannerCellClick(url: String) {
        let warning = MessageView.viewFromNib(layout: .cardView)
        warning.configureTheme(.warning)
        warning.configureDropShadow()
        
        let iconText = ["🤔", "😳", "🙄", "😶"].sm_random()!
        warning.configureContent(title: "Warning", body: "哎呀呀!咋没反应呢???", iconText: iconText)
        warning.button?.isHidden = true
        var warningConfig = SwiftMessages.defaultConfig
        warningConfig.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        SwiftMessages.show(config: warningConfig, view: warning)
    }
}

// Mark: - 点击顶部分类按钮 delegate
extension HomeVIPController:HomeVipCategoriesCellDelegate{
    func homeVipCategoriesCellItemClick(id: String, url: String,title:String) {
        if url == ""{
            let vc = ClassifySubMenuController(categoryId: Int(id)!,isVipPush:true)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            let vc = FMWebViewController(url:url)
            vc.title = title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
// Mark: - 点击Vip尊享课item delegate
extension HomeVIPController:HomeVipEnjoyCellDelegate{
    func homeVipEnjoyCellItemClick(model: CategoryContents) {
        let vc = FMPlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
// Mark: - 点击热播item delegate
extension HomeVIPController:HomeVipHotCellDelegate{
    func homeVipHotCellItemClick(model: CategoryContents) {
        let vc = FMPlayDetailController(albumId: model.albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
