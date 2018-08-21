
//
//  FMPlayDetailAPI.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 播放详情页接口
let FMPlayDetailProvider = MoyaProvider<FMPlayDetailAPI>()

enum FMPlayDetailAPI {
    case playDetailData(albumId:Int)//播放页数据
    case playDetailLikeList(albumId: Int) // 播放页找相似
    case playDetailCircleList // 播放页圈子
}

extension FMPlayDetailAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .playDetailData:
            return URL(string: "http://mobile.ximalaya.com")!
        case .playDetailLikeList:
            return URL(string: "http://ar.ximalaya.com")!
        case .playDetailCircleList:
            return URL(string: "http://m.ximalaya.com")!
        }
    }
    
    var path: String {
        switch self {
        case .playDetailData: return "/mobile/v1/album/ts-1534832680180"
        case .playDetailLikeList: return "/rec-association/recommend/album/by_album"
        case .playDetailCircleList: return "/community/v1/communities/9"
        }
    }
    
    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
         //http://mobile.ximalaya.com/mobile/v1/album/ts-1534832680180?ac=WIFI&albumId=12825974&device=iPhone&isAsc=true&isQueryInvitationBrand=true&pageSize=20&source=4&statEvent=pageview%2Falbum%4011811544&statModule=猜你喜欢&statPage=tab%40发现_推荐%20HTTP/1.1
        case .playDetailData(let albumId):
            parmeters = [
                "device":"iPhone",
                "isAsc":false,
                "isQueryInvitationBrand":false,
                "pageSize":20,
                "source":4,
                "ac":"WIFI"]
         parmeters["albumId"] = albumId
        // http://ar.ximalaya.com/rec-association/recommend/album/by_album?albumId=12825974&appid=0&device=iPhone&deviceId=5DC0EF2A-01F6-41D1-8455-C4A1BF927E36&network=WIFI&operator=3&scale=3&uid=124057809&version=6.5.3&xt=1534833233662 HTTP/1.1
        case .playDetailLikeList(let albumId):
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            parmeters["albumId"] = albumId
        // http://m.ximalaya.com/community/v1/communities/9?orderBy=1&type=1 HTTP/1.1
        case .playDetailCircleList:
            parmeters = [
                "orderBy":1,
                "type":1
            ]
        }
        
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}
