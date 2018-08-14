//
//  ListenSubscibeViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ListenSubscibeViewModel: NSObject {
    var albumResults:[AlbumResultsModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension ListenSubscibeViewModel {
    func refreshDataSource() {
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "listenSubscibe", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<AlbumResultsModel>.deserializeModelArrayFrom(json: json["data"]["albumResults"].description) {
            self.albumResults = mappedObject as? [AlbumResultsModel]
            self.updataBlock?()
        }
    }
}

extension ListenSubscibeViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.albumResults?.count ?? 0
    }
}
