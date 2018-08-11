
//
//  HomeLiveAPI.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/28.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import Moya

let HomeLiveProvider = MoyaProvider<HomeLiveAPI>()

//请求分类
public enum HomeLiveAPI {
    case liveClassifyList 
    case liveBannerList
    case liveRankList
    case liveList
}

//请求配置
extension HomeLiveAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .liveBannerList:
            return URL(string: "http://adse.ximalaya.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .liveClassifyList:
            return "/lamia/v1/homepage/materials HTTP/1.1"
        case .liveRankList:
            return "/lamia/v2/live/rank_list"
        case .liveList:
            return "/lamia/v8/live/homepage"
        default:
            return "/focusPicture/ts-1532427241140"
        }
    }
    
    
    public var method: Moya.Method { return .get }
    public var task: Task {
        let parmeters = [
            "appid":0,
            "categoryId":-3,
            "network":"WIFI",
            "operator":3,
            "scale":3,
            "uid":0,
            "device":"iPhone",
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString] as [String : Any]
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    public var headers: [String : String]? { return nil }
}


