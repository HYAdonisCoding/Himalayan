//
//  HYRecommendAPI.swift
//  Himalayan
//
//  Created by Adonis_HongYang on 2020/3/17.
//  Copyright © 2020 Adonis_HongYang. All rights reserved.
//

import Foundation
import Moya
import HandyJSON

/// 首页推荐主接口
let HYRecommendProvider = MoyaProvider<HYRecommendAPI>()

enum HYRecommendAPI {
    case recommendList//推荐列表
    case recommendForYouList // 为你推荐
    case recommendAdList // 推荐页面穿插的广告
    case guessYouLikeMoreList // 猜你喜欢更多
    
    case changeGuessYouLikeList // 更换猜你喜欢
    case changePaidCategoryList //更换精品
    case changeLiveList // 更换直播
    case changeOtherCategory(categoryId:Int)// 更换其他
}

extension HYRecommendAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .recommendAdList:
            return URL(string: "http://adse.ximalaya.com")!
        default:
            return URL(string: "http://mobile.ximalaya.com")!
        }
    }

    var path: String {
        switch self {
        case .recommendList: return "/discovery-firstpage/v2/explore/ts-1532411485052"
        case .recommendForYouList: return "/mobile/discovery/v4/recommend/albums"
        case .recommendAdList: return "/ting/feed/ts-1532656780625"
        case .guessYouLikeMoreList: return "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
        case .changeGuessYouLikeList: return "/discovery-firstpage/guessYouLike/cycle/ts-1535167862593"
        case .changePaidCategoryList: return "/mobile/discovery/v1/guessYouLike/paidCategory/ts-1535167980873"
        case .changeLiveList: return "/lamia/v1/hotpage/exchange"
        case .changeOtherCategory: return "/mobile/discovery/v4/albums/ts-1535168024113"
        }
    }

    var method: Moya.Method { return .get }
    var task: Task {
        var parmeters:[String:Any] = [:]
        switch self {
        case .recommendList:
            parmeters = [
                "device":"iPhone",
                            "appid":0,
                            "categoryId":-2,
                            "channel":"ios-b1",
                            "code":"43_310000_3100",
                            "includeActivity":true,
                            "includeSpecial":true,
                            "network":"WIFI",
                            "operator":3,
                            "pullToRefresh":true,
                            "scale":3,
                            "uid":0,
                            "version":"6.5.3",
                            "xt": Int32(Date().timeIntervalSince1970),
                            "deviceId": UIDevice.current.identifierForVendor!.uuidString]
        case .recommendForYouList:
            parmeters = [
                "device":"iPhone",
            "excludedAlbumIds":"3144231%2C3160816%2C5088879%2C3703879%2C9723091%2C12580785%2C12610571%2C13507836%2C11501536%2C12642314%2C4137349%2C10587045%2C6233693%2C4436043%2C16302530%2C15427120%2C13211141%2C61%2C220565%2C3475911%2C3179882%2C10596891%2C261506%2C7183288%2C203355%2C3493173%2C7054736%2C10728301%2C2688602%2C13048404",
                "appid":0,
                "categoryId":-2,
                "pageId":1,
                "pageSize":20,
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case .recommendAdList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "name":"find_native",
                "network":"WIFI",
                "operator":3,
                "scale":3,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970)
            ]
            /*
             http://mobile.ximalaya.com/discovery-firstpage/guessYouLike/list/ts-1534815616591?appid=0&device=iPhone&deviceId=5DC0EF2A-01F6-41D1-8455-C4A1BF927E36&inreview=false&network=WIFI&operator=3&pageId=1&pageSize=20&scale=3&uid=124057809&version=6.5.3&xt=1534815616592%20HTTP/1.1
             */
        case .guessYouLikeMoreList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":20,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case .changeGuessYouLikeList:
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "excludedAdAlbumIds":"8258116%2C8601255%2C16514340",
                "excludedAlbumIds":"4169245%2C4156778%2C4078652%2C8601255%2C4177638%2C16514340%2C5993267%2C12201334%2C13089888%2C4310827%2C4792267%2C2912127%2C13403391%2C4193171%2C5411224%2C8258116%2C4323493%2C10829913",
                "excludedRoomIds":"",
                "excludedSpecialIds":"",
                
                "excludedOffset":18,
                "inreview":false,
                "loopIndex":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":6,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            
        case .changePaidCategoryList:
        parmeters = [
            "device":"iPhone",
            "appid":0,
            "excludedAdAlbumIds":13616258,
            "excludedOffset":18,
            "network":"WIFI",
            "operator":3,
            "pageId":1,
            "pageSize":3,
            "scale":3,
            "uid":0,
            "version":"6.5.3",
            "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString]

            
        case .changeLiveList:
            parmeters = [
                "currentRecordIds":"1655918%2C1671613%2C1673030%2C1670774%2C1673082%2C1672407",
                "pageId":1,
                "pageSize":6,
                "device":"iPhone"
            ]
            
        case .changeOtherCategory(let categoryId):
            parmeters = [
                "appid":0,
                "excludedAlbumIds":"7024810%2C8424399%2C8125936",
                "excludedAdAlbumIds":"13616258",
                "excludedOffset":3,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":3,
                "scale":3,
                "uid":0,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString
            ]
            parmeters["categoryId"] = categoryId
        }
        

        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }

    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    var headers: [String : String]? { return nil }
}

let ClassifySubMenuProvider = MoyaProvider<ClassifySubMenuAPI>()
//请求分类
public enum ClassifySubMenuAPI {
    case headerCategoryList(categoryId: Int) // 顶部分类传参categoryId
    case classifyRecommendList(categoryId: Int) //推荐传参categoryId
    case classifyOtherContentList(keywordId: Int, categoryId: Int) //其他分类传参categoryId
}

//请求配置
extension ClassifySubMenuAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .headerCategoryList:
            return "/discovery-category/keyword/all/1534468874767"
        case .classifyRecommendList:
            return "/discovery-category/v2/category/recommend/ts-1534469064622"
        case .classifyOtherContentList:
            return "/mobile/discovery/v2/category/metadata/albums/ts-1534469378814"
        }
    }
    
    
    public var method: Moya.Method { return .get }
    public var task: Task {
        var parmeters = [String:Any]()
        switch self {
        case .headerCategoryList(let categoryId):
            parmeters = ["device":"iPhone","gender":9]
            parmeters["categoryId"] = categoryId
        case .classifyRecommendList(let categoryId):
            parmeters = ["appid":0,
                         "device":"iPhone",
                         "gender":9,
                         "inreview":false,
                         "network":"WIFI",
                         "operator":3,
                         "scale":3,
                         "uid":124057809,
                         "version":"6.5.3",
                         "xt": Int32(Date().timeIntervalSince1970),
            "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            parmeters["categoryId"] = categoryId
            
        case .classifyOtherContentList(let keywordId, let categoryId):
            parmeters = ["calcDimension":"hot",
                         "device":"iPhone",
                         "pageId":1,
                         "pageSize":20,
                         "status":0,
                         "version":"6.5.3"]
            parmeters["keywordId"] = keywordId
            parmeters["categoryId"] = categoryId
        }
        return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
    }
    
    public var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    public var headers: [String : String]? { return nil }
}
