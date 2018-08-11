//
//  HomeVipViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeVipViewModel: NSObject {
    
     var homevipData :HomeVipModel?
     var focusImages: [FocusImagesData]?
     var categoryList:[CategoryList]?
     var categoryBtnList: [CategoryBtnModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
    
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        switch section {
        case HomeVipSectionVip:
            return self.categoryList?[section].list?.count ?? 0
        default:
            return 1
        }
    }
    // 高度
    func heightForRowAt(indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case HomeVipSectionBanner:
            return 150
        case HomeVipSectionGrid:
            return 80
        case HomeVipSectionHot:
            return 190
        case HomeVipSectionEnjoy:
            return 230
        default:
            return 120
        }
    }
    
    //header高度
    func heightForHeaderInSection(section:Int) ->CGFloat {
        if section == HomeVipSectionBanner || section == HomeVipSectionGrid {
            return 0.0
        }else {
            return 50
        }
    }
    
    //footer 高度
    func heightForFooterInSection(section:Int) ->CGFloat {
        if section == HomeVipSectionBanner {
            return 0.0
        }else {
            return 10
        }
    }
}

// Mark:-请求数据
extension HomeVipViewModel {
    func refreshDataSource() {
        //        //首页vip接口请求
        HomeVipProvider.request(.homeVipList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<HomeVipModel>.deserializeFrom(json: json.description) {
                        self.homevipData = mappedObject
                        self.focusImages = mappedObject.focusImages?.data
                        self.categoryList = mappedObject.categoryContents?.list
                    }
                if let categorybtn = JSONDeserializer<CategoryBtnModel>.deserializeModelArrayFrom(json:json["categoryContents"]["list"][0]["list"].description){
                    self.categoryBtnList = categorybtn as? [CategoryBtnModel]
                    }
                self.updataBlock?()
                }
            }
        }
}



