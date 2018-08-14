//
//  ListenChannelViewModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

class ListenChannelViewModel: NSObject {
    var channelResults:[ChannelResultsModel]?
    // Mark: -数据源更新
    typealias AddDataBlock = () ->Void
    var updataBlock:AddDataBlock?
}

// Mark:-请求数据
extension ListenChannelViewModel {
    func refreshDataSource() {
        //一键听接口请求
        FMListenProvider.request(.listenChannelList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                
                if let mappedObject = JSONDeserializer<ChannelResultsModel>.deserializeModelArrayFrom(json: json["data"]["channelResults"].description) { // 从字符串转换为对象实例
                    self.channelResults = mappedObject as? [ChannelResultsModel]
                    self.updataBlock?()
                }
            }
        }
    }
}

extension ListenChannelViewModel {
    // 每个分区显示item数量
    func numberOfRowsInSection(section: NSInteger) -> NSInteger {
        return self.channelResults?.count ?? 0
    }
}
