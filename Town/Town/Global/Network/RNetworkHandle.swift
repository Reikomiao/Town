//
//  RNetworkHandle.swift
//  WELivenessSDK
//
//  Created by 冯振玲 on 2017/6/9.
//  Copyright © 2017年 wecash. All rights reserved.
//

import UIKit
public typealias RResponseClousure = ((Bool, [String:AnyObject]?) -> ())

class RNetworkHandle: NSObject {
    
    
    
    func request(type:String = "get", url:String, paramters:[String: AnyObject]?,response:@escaping RResponseClousure){
        let request = requestURL(type: type, url: url, paramters: paramters)
        jsonAnalysis(request: request!, response: response)
        
        }
    
        
    
    
    private func requestURL(type:String, url:String, paramters: [String: AnyObject]?) -> URLRequest? {
        if let tempUrl = URL.init(string: url) {
            let mutableDic = paramters ?? [:]
            var request = URLRequest.init(url: tempUrl)
            var urlAppend = url;
            if type.lowercased()=="get" {
                urlAppend  = "\(tempUrl.absoluteString)?\(urlAppendingParameters(parameters: mutableDic))"
            }else if type.lowercased() == "post"{
                request.httpBody = urlAppendingParameters(parameters: mutableDic).data(using: .utf8)
            }else{
                return nil
            }
            
            request.url = URL(string: urlAppend)!
            request.httpMethod = type
            return request
        }
        return nil
    }
    // 拼接参数
    private func urlAppendingParameters(parameters:[String:AnyObject]?) -> String {
        
        var pathArray = [String]()
        if let parameters = parameters{
            for (key,value) in parameters {
               let codeingKey = key.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
               let codedingValue = value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                let path = "\(codeingKey!)=\(codedingValue!)"
                pathArray.append(path)
            }
           let appendPath = pathArray.joined(separator: "&")
           return appendPath
           
        }else{
           return ""
        }
    }
    
    private func jsonAnalysis(request:URLRequest, response:@escaping ((Bool, [String:AnyObject]?) -> ())){        
        URLSession.shared.dataTask(with: request) { (data, tempresponse, error) in
            
            do {
                let result = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableLeaves)
                if let dict = result as? [String: AnyObject] {
                    response(true,dict)
                }else {
                    response(false,nil)
                }

            }catch(let exception) {
                print(exception)
            }
        }.resume()
    }
    
}




