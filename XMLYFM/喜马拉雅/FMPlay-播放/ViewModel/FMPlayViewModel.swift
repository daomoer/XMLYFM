//
//  FMPlayViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class FMPlayViewModel: NSObject {
    // 外部传值请求接口如此那
    var albumId :Int = 0
    var trackUid:Int = 0
    var uid:Int = 0
    convenience init(albumId: Int = 0, trackUid: Int = 0,uid:Int = 0) {
        self.init()
        self.albumId = albumId
        self.trackUid = trackUid
        self.uid = uid
    }
    
     var playTrackInfo:FMPlayTrackInfo?
     var playCommentInfo:[FMPlayCommentInfo]?
     var userInfo:FMPlayUserInfo?
     var communityInfo:FMPlayCommunityInfo?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension FMPlayViewModel {
    func refreshDataSource() {
 FMPlayProvider.request(FMPlayAPI.fmPlayData(albumId:self.albumId,trackUid:self.trackUid,uid:self.uid)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let playTrackInfo = JSONDeserializer<FMPlayTrackInfo>.deserializeFrom(json: json["trackInfo"].description) { // 从字符串转换为对象实例
                    self.playTrackInfo = playTrackInfo
                }
                if let commentInfo = JSONDeserializer<FMPlayCommentInfoList>.deserializeFrom(json: json["noCacheInfo"]["commentInfo"].description) { // 从字符串转换为对象实例
                    self.playCommentInfo = commentInfo.list
                }
                if let userInfoData = JSONDeserializer<FMPlayUserInfo>.deserializeFrom(json: json["userInfo"].description) { // 从字符串转换为对象实例
                    self.userInfo = userInfoData
                }
                if let communityInfoData = JSONDeserializer<FMPlayCommunityInfo>.deserializeFrom(json: json["noCacheInfo"]["communityInfo"].description) { // 从字符串转换为对象实例
                    self.communityInfo = communityInfoData
                }
                self.updataBlock?()
            }
        }
    }
}

// Mark:-collectionview数据
extension FMPlayViewModel {
    func numberOfSections(collectionView:UICollectionView) ->Int {
        return 4
    }
    // 每个分区显示item数量
    func numberOfItemsIn(section: NSInteger) -> NSInteger {
        if section == 3{
            return self.playCommentInfo?.count ?? 0
        }
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
        if indexPath.section == 0{
            return CGSize.init(width:YYScreenWidth,height:YYScreenHeigth*0.7)
        }else if indexPath.section == 3{
            let textHeight = height(for: self.playCommentInfo?[indexPath.row])+100
            return CGSize.init(width:YYScreenWidth,height:textHeight)
        }else{
            return CGSize.init(width:YYScreenWidth,height:140)
        }
    }
    
    // 分区头视图size
    func referenceSizeForHeaderInSection(section: Int) -> CGSize {
        if section == 0 {
            return .zero
        }
        return CGSize.init(width: YYScreenHeigth, height:40)
    }
    
    // 分区尾视图size
    func referenceSizeForFooterInSection(section: Int) -> CGSize {
        return CGSize.init(width: YYScreenWidth, height: 10.0)
    }
    
    // 计算文本高度
    func height(for commentModel: FMPlayCommentInfo?) -> CGFloat {
        var height: CGFloat = 10
        guard let model = commentModel else { return height }
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.text = model.content
        height += label.sizeThatFits(CGSize(width: YYScreenWidth - 80, height: CGFloat.infinity)).height
        return height
    }
}

