
//
//  FMPlayModel.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import Foundation
import HandyJSON
struct FMPlayModel:HandyJSON {
    var ret:Int = 0
    var albumInfo:FMPlayAlbumInfo?
    var associationAlbumsInfo:[FMPlayAssociationAlbumsInfo]?
    var noCacheInfo:FMPlayNoCacheInfo?
    var trackInfo:FMPlayTrackInfo?
    var userInfo:FMPlayUserInfo?
}

struct FMPlayAlbumInfo:HandyJSON {
    
}

struct FMPlayAssociationAlbumsInfo:HandyJSON {
    
}
struct FMPlayNoCacheInfo:HandyJSON {
    
}
struct FMPlayTrackInfo:HandyJSON {
    var albumId:Int = 0
    var bulletSwitchType:Int = 0
    var categoryId:Int = 0
    var comments:Int = 0
    var createdAt:Int = 0
    var downloadAacSize:Int = 0
    var downloadSize:Int = 0
    var duration:Int = 0
    var likes:Int = 0
    var playtimes:Int = 0
    var priceTypeEnum:Int = 0
    var priceTypeId:Int = 0
    var processState:Int = 0
    var relatedId:Int = 0
    var ret:Int = 0
    var sampleDuration:Int = 0
    var shares:Int = 0
    var status:Int = 0
    var trackId:Int = 0
    var type:Int = 0
    var uid:Int = 0
    var isAuthorized:Bool = false
    var isDraft:Bool = false
    var isFree:Bool = false
    var isLike:Bool = false
    var isPaid:Bool = false
    var isPublic:Bool = false
    var isRichAudio:Bool = false
    var isVideo:Bool = false
    var isVipFree:Bool = false
    var albumTitle:String?
    var categoryName:String?
    var coverLarge:String?
    var coverMiddle:String?
    var coverSmall:String?
    var downloadAacUrl:String?
    var downloadUrl:String?
    var intro:String?
    var playPathAacv164:String?
    var playPathAacv224:String?
    var playPathHq:String?
    var playUrl32:String?
    var playUrl64:String?
    var shortRichIntro:String?
    var title:String?

    var images:[Any]?
    var priceTypes:[Any]?

}


struct FMPlayUserInfo:HandyJSON {
    var albums:Int = 0
    var anchorGrade:Int = 0
    var answerCount:Int = 0
    var followers:Int = 0
    var tracks:Int = 0
    var uid:Int = 0
    var verifyType:Int = 0

    var isOpenAskAndAnswer:Bool = false
    var isVerified:Bool = false
    var isVip:Bool = false
    
    var askAndAnswerBrief:String?
    var askPrice:String?
    var nickname:String?
    var personDescribe:String?
    var personalSignature:String?
    var ptitle:String?
    var skilledTopic:String?
    var smallLogo:String?
}



