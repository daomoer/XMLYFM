
//
//  HomeBroadcastModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/1.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import HandyJSON
/// 首页广播数据模型
struct HomeBroadcastModel : HandyJSON {
    var data:RadiosModel?
    var ret: Int = 0
}

struct RadiosModel: HandyJSON {
    var categories: [RadiosCategoriesModel]?
    var localRadios: [LocalRadiosModel]?
    var location: String?
    var radioSquareResults: [RadioSquareResultsModel]?
    var topRadios: [TopRadiosModel]?
}

struct RadiosCategoriesModel: HandyJSON{
    var id: Int = 0
    var name: String?
}

struct LocalRadiosModel :HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [RadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}

struct RadiosPlayUrlModel :HandyJSON {
    var aac24: String?
    var aac64: String?
    var ts24: String?
    var ts64: String?
}

struct RadioSquareResultsModel: HandyJSON {
    var icon: String?
    var id: Int = 0
    var title: String?
    var uri: String?
}

struct TopRadiosModel: HandyJSON {
    var coverLarge: String?
    var coverSmall: String?
    var fmUid: Int = 0
    var id: Int = 0
    var name: String?
    var playCount: Int = 0
    var playUrl: [RadiosPlayUrlModel]?
    var programId: Int = 0
    var programName: String?
    var programScheduleId: Int = 0
}
