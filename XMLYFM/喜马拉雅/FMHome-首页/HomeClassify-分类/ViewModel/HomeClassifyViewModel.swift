 //
//  HomeClassifyViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class HomeClassifyViewModel: NSObject {
    var classifyModel:[ClassifyModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension HomeClassifyViewModel {
    func refreshDataSource() {
        //首页分类接口请求
        HomeClassifProvider.request(.classifyList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<HomeClassifyModel>.deserializeFrom(json: json.description) { // 从字符串转换为对象实例
                    self.classifyModel = mappedObject.list
                }
                self.updataBlock?()
            }
        }
    }
}

// Mark:-collectionview数据
extension HomeClassifyViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return self.classifyModel?.count ?? 0
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        return self.classifyModel?[section].itemList?.count ?? 0
    }
    //每个分区的内边距
    func insetForSectionAt(section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 2.5, 0, 2.5)
    }
    
    //最小 item 间距
    func minimumInteritemSpacingForSectionAt(section:Int) ->CGFloat {
        return 0
    }
    
    //最小行间距
    func minimumLineSpacingForSectionAt(section:Int) ->CGFloat {
        return 2
    }
    
    // item 尺寸
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 || indexPath.section == 1 || indexPath.section == 2 {
            return CGSize.init(width:(YYScreenWidth-10)/4,height:40)
        }else {
            return CGSize.init(width:(YYScreenWidth-7.5)/3,height:40)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 || section == 1 || section == 2 {
            return .zero
        }else {
            return CGSize.init(width: YYScreenHeigth, height:30)
        }
    }
    
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: YYScreenWidth, height: 8.0)
    }
}

