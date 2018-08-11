//
//  HomeRecommendViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeRecommendViewModel: NSObject {
    // MARK - 数据模型
     var fmhomeRecommendModel:FMHomeRecommendModel?
     var homeRecommendList:[HomeRecommendModel]?
     var recommendList : [RecommendListModel]?
     var focus:FocusModel?
     var squareList:[SquareModel]?
     var topBuzzList: [TopBuzzModel]?
     var guessYouLikeList: [GuessYouLikeModel]?
     var paidCategoryList: [PaidCategoryModel]?
     var playlist: PlaylistModel?
     var oneKeyListenList: [OneKeyListenModel]?
     var liveList: [LiveModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension HomeRecommendViewModel {
    func refreshDataSource() {
        //首页推荐接口请求
        FMRecommendProvider.request(.recommendList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<FMHomeRecommendModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.fmhomeRecommendModel = mappedObject
                    self.homeRecommendList = mappedObject.list
                    if let recommendList = JSONDeserializer<RecommendListModel>.deserializeModelArrayFrom(json: json["list"].description) {
                        self.recommendList = recommendList as? [RecommendListModel]
                    }
                    
                    if let focus = JSONDeserializer<FocusModel>.deserializeFrom(json: json["list"][0]["list"][0].description) {
                        self.focus = focus
                    }
                    if let square = JSONDeserializer<SquareModel>.deserializeModelArrayFrom(json: json["list"][1]["list"].description) {
                        self.squareList = square as? [SquareModel]
                    }
                    if let topBuzz = JSONDeserializer<TopBuzzModel>.deserializeModelArrayFrom(json: json["list"][2]["list"].description) {
                        self.topBuzzList = topBuzz as? [TopBuzzModel]
                    }
                    
                    if let oneKeyListen = JSONDeserializer<OneKeyListenModel>.deserializeModelArrayFrom(json: json["list"][9]["list"].description) {
                        self.oneKeyListenList = oneKeyListen as? [OneKeyListenModel]
                    }
                    
                    if let live = JSONDeserializer<LiveModel>.deserializeModelArrayFrom(json: json["list"][14]["list"].description) {
                        self.liveList = live as? [LiveModel]
                    }
                    self.updataBlock?()
                }
            }
        }
    }
}

// Mark:-collectionview数据
extension HomeRecommendViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return (self.homeRecommendList?.count) ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return 1
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let HeaderAndFooterHeight:Int = 90
        let itemNums = (self.homeRecommendList?[indexPath.section].list?.count)!/3
        let count = self.homeRecommendList?[indexPath.section].list?.count
        let moduleType = self.homeRecommendList?[indexPath.section].moduleType
        if moduleType == "focus" {
            return CGSize.init(width:YYScreenWidth,height:360)
        }else if moduleType == "square" || moduleType == "topBuzz" {
            return CGSize.zero
        }else if moduleType == "guessYouLike" || moduleType == "paidCategory" || moduleType == "categoriesForLong" || moduleType == "cityCategory" || moduleType == "live"{
            return CGSize.init(width:YYScreenWidth,height:CGFloat(HeaderAndFooterHeight+180*itemNums))
        }else if moduleType == "categoriesForShort" || moduleType == "playlist" || moduleType == "categoriesForExplore"{
            return CGSize.init(width:YYScreenWidth,height:CGFloat(HeaderAndFooterHeight+120*count!))
        }else if moduleType == "ad" {
            return CGSize.init(width:YYScreenWidth,height:240)
        }else if moduleType == "oneKeyListen" {
            return CGSize.init(width:YYScreenWidth,height:180)
        }else {
            return .zero
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" || moduleType == "topBuzz" || moduleType == "ad" || section == 18 {
            return CGSize.zero
        }else {
            return CGSize.init(width: YYScreenHeigth, height:40)
        }
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        let moduleType = self.homeRecommendList?[section].moduleType
        if moduleType == "focus" || moduleType == "square" {
            return CGSize.zero
        }else {
            return CGSize.init(width: YYScreenWidth, height: 10.0)
        }
    }
}
