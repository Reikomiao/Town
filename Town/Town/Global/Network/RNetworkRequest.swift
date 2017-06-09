//
//  RNetworkRequest.swift
//  Town
//
//  Created by 冯振玲 on 2017/6/9.
//  Copyright © 2017年 Reiko. All rights reserved.
//

import UIKit

class RNetworkRequest: NSObject {
    static func townCityStoryList(paramters:[String:AnyObject]?, response:@escaping RResponseClousure){
        let handle = RNetworkHandle()
        handle.request(type: "get", url: "https://m.wecash.net/platform/index/query", paramters: paramters, response: response)
    }

}
