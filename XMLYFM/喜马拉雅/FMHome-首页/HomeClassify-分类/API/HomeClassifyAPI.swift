
//
//  HomeClassifyAPI.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/24.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import Moya

let HomeClassifProvider = MoyaProvider<HomeClassifyAPI>()

//请求分类
public enum HomeClassifyAPI {
    case classifyList
}

//请求配置
extension HomeClassifyAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .classifyList:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .classifyList:
            return "/mobile/discovery/v5/categories/1532410996452?channel=ios-b1&code=43_310000_3100&device=iPhone&gender=9&version=6.5.3%20HTTP/1.1"
//            return "/chaos/v2/feed/list/followings"
        }
    }
    
//
//    public var method: Moya.Method { return .get }
//    public var task: Task {
//        let parmeters = [
//            "sign":0,
//            "size":10,
//            "timeline":0,
//            "uid":124057809,
//            "ts": Int32(Date().timeIntervalSince1970)] as [String : Any]
//        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
//    }
//
//    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
//    public var headers: [String : String]? { return nil }
//
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }

    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .classifyList:
            return .requestPlain
        }
    }

    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }

    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }

    //请求头
    public var headers: [String: String]? {
        return nil
    }
}
