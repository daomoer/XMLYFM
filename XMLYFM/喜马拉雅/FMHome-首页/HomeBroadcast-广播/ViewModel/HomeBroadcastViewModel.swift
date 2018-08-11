//
//  HomeBroadcastViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeBroadcastViewModel: NSObject {
     var isUnfold: Bool = false// 更多电台分类是否展开状态
    /// 一下三个model是控制展开收起时电台数据显示
     let bottomModel = RadiosCategoriesModel.init(id: 10000, name: "arrows_bottom.png")
     let topModel = RadiosCategoriesModel.init(id: 10000, name:"arrows_top.png")
     let coverModel = RadiosCategoriesModel.init(id: 10000, name:" ")
    
     var titleArray = ["上海","排行榜"]
    // 数据模型
     var categories: [RadiosCategoriesModel]?
     var localRadios: [LocalRadiosModel]?
     var radioSquareResults: [RadioSquareResultsModel]?
     var topRadios: [TopRadiosModel]?
    
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension HomeBroadcastViewModel {
    func refreshDataSource() {
        //首页广播接口请求
        HomeBroadcastProvider.request(.homeBroadcastList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<HomeBroadcastModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.categories = mappedObject.data?.categories
                    self.localRadios = mappedObject.data?.localRadios
                    self.radioSquareResults = mappedObject.data?.radioSquareResults
                    self.topRadios = mappedObject.data?.topRadios
                    self.categories?.insert(self.bottomModel, at: 7)
                    self.categories?.append(self.topModel)
                    
                    self.updataBlock?()
                }
            }
        }
    }
}

// Mark:-collectionview数据
extension HomeBroadcastViewModel {
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == HomeBroadcastSectionTel {
            return 1
        }else if section == HomeBroadcastSectionMoreTel {
            if self.isUnfold {
                return self.categories?.count ?? 0
            }else {
                let num:Int = self.categories?.count ?? 0
                return num/2
            }
        }else if section == HomeBroadcastSectionLocal {
            return self.localRadios?.count ?? 0
        }else {
            return self.topRadios?.count ?? 0
        }
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        if section == HomeBroadcastSectionMoreTel {
            return 1
        }else {
            return 0.0
        }
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        if section == HomeBroadcastSectionMoreTel {
            return 1
        }else {
            return 0.0
        }
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == HomeBroadcastSectionTel {
            return CGSize.init(width:YYScreenWidth,height:90)
        }else if indexPath.section == HomeBroadcastSectionMoreTel {
            return CGSize.init(width:(YYScreenWidth-5)/4,height:45)
        }else {
            return CGSize.init(width:YYScreenWidth,height:120)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == HomeBroadcastSectionTel || section == HomeBroadcastSectionMoreTel {
            return .zero
        }else {
            return CGSize.init(width: YYScreenWidth, height: 40)
        }
    }
    
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        if section == HomeBroadcastSectionTel || section == HomeBroadcastSectionMoreTel {
            return .zero
        }else {
            return CGSize.init(width: YYScreenWidth, height: 10)
        }
    }
}
