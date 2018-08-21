//
//  ClassifySubRecommendController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/17.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ClassifySubRecommendController: UIViewController {
    //Mark: - 上页面传过来请求接口必须的参数
    private var categoryId: Int = 0
    convenience init(categoryId:Int = 0) {
        self.init()
        self.categoryId = categoryId
    }
    
    
    private var classifyCategoryContentsList:[ClassifyCategoryContentsList]?
    private var classifyModuleType14List:[ClassifyModuleType14Model]?
    private var classifyModuleType19List:[ClassifyModuleType19Model]?
    private var classifyModuleType20Model:[ClassifyModuleType20Model]?
    private var classifyVerticalModel:[ClassifyVerticalModel]?
    private var focus:FocusModel?


    private let ClassifySubHeaderViewID = "ClassifySubHeaderView"
    private let ClassifySubFooterViewID = "ClassifySubFooterView"

    private let ClassifySubHeaderCellID = "ClassifySubHeaderCell"
    private let ClassifySubHorizontalCellID = "ClassifySubHorizontalCell"
    private let ClassifySubVerticalCellID = "ClassifySubVerticalCell"
    private let ClassifySubModuleType20CellID = "ClassifySubModuleType20Cell"
    private let ClassifySubModuleType19CellID = "ClassifySubModuleType19Cell"
    private let ClassifySubModuleType17CellID = "ClassifySubModuleType17Cell"
    private let ClassifySubModuleType4CellID = "ClassifySubModuleType4Cell"
    private let ClassifySubModuleType16CellID = "ClassifySubModuleType16Cell"
    private let ClassifySubModuleType23CellID = "ClassifySubModuleType23Cell"

    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        let collection = UICollectionView.init(frame:.zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        // MARK -注册头视图和尾视图
        collection.register(ClassifySubHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ClassifySubHeaderViewID)
        collection.register(ClassifySubFooterView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ClassifySubFooterViewID)
//
        // MARK -注册不同分区cell
        collection.register(ClassifySubHeaderCell.self, forCellWithReuseIdentifier: ClassifySubHeaderCellID)
        collection.register(ClassifySubHorizontalCell.self, forCellWithReuseIdentifier: ClassifySubHorizontalCellID)
        collection.register(ClassifySubVerticalCell.self, forCellWithReuseIdentifier: ClassifySubVerticalCellID)
        collection.register(ClassifySubModuleType20Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType20CellID)
        collection.register(ClassifySubModuleType19Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType19CellID)
        collection.register(ClassifySubModuleType17Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType17CellID)
        collection.register(ClassifySubModuleType4Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType4CellID)
        collection.register(ClassifySubModuleType16Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType16CellID)
        collection.register(ClassifySubModuleType23Cell.self, forCellWithReuseIdentifier: ClassifySubModuleType23CellID)

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
        loadRecommendData()
    }
    func loadRecommendData(){
            //分类二级界面推荐接口请求
        ClassifySubMenuProvider.request(ClassifySubMenuAPI.classifyRecommendList(categoryId: self.categoryId)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifyCategoryContentsList>.deserializeModelArrayFrom(json:json["categoryContents"]["list"].description) { // 从字符串转换为对象实例
                    self.classifyCategoryContentsList = mappedObject as? [ClassifyCategoryContentsList]
                }
                // 顶部滚动视图数据
                if let focusModel = JSONDeserializer<FocusModel>.deserializeFrom(json:json["focusImages"].description) { // 从字符串转换为对象实例
                    self.focus = focusModel
                }
                self.collectionView.reloadData()
            }
        }
    }
}

extension ClassifySubRecommendController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.classifyCategoryContentsList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if moduleType == 14 || moduleType == 19 || moduleType == 20{
            return 1
        }else {
            return self.classifyCategoryContentsList?[section].list?.count ?? 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cardClass = self.classifyCategoryContentsList?[indexPath.section].cardClass
        let moduleType = self.classifyCategoryContentsList?[indexPath.section].moduleType
        if moduleType == 14 {
            let cell:ClassifySubHeaderCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubHeaderCellID, for: indexPath) as! ClassifySubHeaderCell
            cell.focusModel = self.focus
            cell.classifyCategoryContentsListModel = self.classifyCategoryContentsList?[indexPath.section]
            return cell
        }else if moduleType == 3 {
            if cardClass == "horizontal" {
                let cell:ClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubHorizontalCellID, for: indexPath) as! ClassifySubHorizontalCell
                cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }else {
                let cell:ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubVerticalCellID, for: indexPath) as! ClassifySubVerticalCell
                cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }
        }else if moduleType == 5{
            if cardClass == "horizontal" {
                let cell:ClassifySubHorizontalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubHorizontalCellID, for: indexPath) as! ClassifySubHorizontalCell
                cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }else {
                let cell:ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubVerticalCellID, for: indexPath) as! ClassifySubVerticalCell
                cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
                return cell
            }
        }else if moduleType == 20 {
            let cell:ClassifySubModuleType20Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType20CellID, for: indexPath) as! ClassifySubModuleType20Cell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 19 {
            let cell:ClassifySubModuleType19Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType19CellID, for: indexPath) as! ClassifySubModuleType19Cell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 17 {
            let cell:ClassifySubModuleType17Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType17CellID, for: indexPath) as! ClassifySubModuleType17Cell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 4 {
            let cell:ClassifySubModuleType4Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType4CellID, for: indexPath) as! ClassifySubModuleType4Cell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 16 {
            let cell:ClassifySubModuleType16Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType16CellID, for: indexPath) as! ClassifySubModuleType16Cell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 23{
            let cell:ClassifySubModuleType23Cell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubModuleType23CellID, for: indexPath) as! ClassifySubModuleType23Cell
//            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else if moduleType == 18{
            let cell:ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubVerticalCellID, for: indexPath) as! ClassifySubVerticalCell
            cell.classifyVerticalModel = self.classifyCategoryContentsList?[indexPath.section].list?[indexPath.row]
            return cell
        }else {
            let cell:ClassifySubVerticalCell = collectionView.dequeueReusableCell(withReuseIdentifier: ClassifySubVerticalCellID, for: indexPath) as! ClassifySubVerticalCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //每个分区的内边距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if cardClass == "horizontal" || moduleType == 16 {
            return UIEdgeInsetsMake(5, 5, 5, 5)
        }
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if cardClass == "horizontal" || moduleType == 16{
            return 5
        }
        return 0
    }
    
    //最小行间距
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        let cardClass = self.classifyCategoryContentsList?[section].cardClass
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if cardClass == "horizontal" || moduleType == 16 {
            return 5
        }
        return 0
    }
    
    //item 的尺寸
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let moduleType = self.classifyCategoryContentsList?[indexPath.section].moduleType
        let cardClass = self.classifyCategoryContentsList?[indexPath.section].cardClass
        if moduleType == 14 {
            let num:Int = (self.classifyCategoryContentsList?[indexPath.section].list?.count)!
            if num >= 10 {
                return CGSize.init(width:YYScreenWidth,height:310)
            }else {
                return CGSize.init(width:YYScreenWidth,height:230)
            }
        }else if moduleType == 3 || moduleType == 5 || moduleType == 18{
            if cardClass == "horizontal" {
                return CGSize.init(width:(YYScreenWidth-30)/3,height:180)
            }else{
                return CGSize.init(width:YYScreenWidth,height:120)
            }
        }else if moduleType == 20{
            return CGSize.init(width:YYScreenWidth,height:300)
        }else if moduleType == 19{
            return CGSize.init(width: YYScreenWidth, height: 200)
        }else if moduleType == 17{
            return CGSize.init(width: YYScreenWidth, height: 180)
        }else if moduleType == 16{
            return CGSize.init(width:(YYScreenWidth-30)/3,height:180)
        }else if moduleType == 4{
            return CGSize.init(width:YYScreenWidth,height:120)
        }else {
            return .zero
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let moduleType = self.classifyCategoryContentsList?[section].moduleType
        if moduleType == 14 || moduleType == 17 || moduleType == 20{
            return .zero
        }
        return CGSize.init(width:YYScreenWidth,height:40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width:YYScreenWidth,height:10)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView : ClassifySubHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ClassifySubHeaderViewID, for: indexPath) as! ClassifySubHeaderView
            headerView.classifyCategoryContents = self.classifyCategoryContentsList?[indexPath.section]
            return headerView
        }else if kind == UICollectionElementKindSectionFooter {
            let footerView : ClassifySubFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter, withReuseIdentifier: ClassifySubFooterViewID, for: indexPath) as! ClassifySubFooterView
            return footerView
        }
        return UICollectionReusableView()
    }
}
