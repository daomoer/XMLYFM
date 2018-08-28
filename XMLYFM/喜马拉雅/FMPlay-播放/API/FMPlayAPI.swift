//
//  FMPlayAPI.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 播放页接口
let FMPlayProvider = MoyaProvider<FMPlayAPI>()

enum FMPlayAPI {
    case fmPlayData(albumId:Int,trackUid:Int, uid:Int)
}

extension FMPlayAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
            return URL(string: "http://mobile.ximalaya.com")!
    }
    
    var path: String {
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            return "/mobile/track/v2/playpage/\(trackUid)"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        // http://mobile.ximalaya.com/mobile/track/v2/playpage/8281672/ts-1535003263717?ac=WIFI&albumId=2863318&appid=0&device=iPhone&deviceId=5DC0EF2A-01F6-41D1-8455-C4A1BF927E36&network=WIFI&operator=3&scale=3&trackUid=1076337&uid=124057809&version=6.5.3&xt=1535003263718 HTTP/1.1
        var parmeters = [
            "device":"iPhone",
            "operator":3,
            "scale":3,
            "appid":0,
            "ac":"WIFI",
            "network":"WIFI",
            "version":"6.5.3",
            "uid":124057809,
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        switch self {
        case .fmPlayData(let albumId, let trackUid, let uid):
            parmeters["albumId"] = albumId
            parmeters["trackUid"] = uid
//            parmeters["uid"] = uid
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}
