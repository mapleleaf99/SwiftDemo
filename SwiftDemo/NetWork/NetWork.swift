//
//  NetWork.swift
//  SwiftDemo
//
//  Created by 叫我锅先生 on 2021/8/3.
//  Copyright © 2021 叫我锅先生. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class BaseModel: Codable {
    var id: Int
    var name: String
    var age: Int
    var isMale: Bool

    var country: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "Name"
        case age = "Age"
        case isMale
    }
}

class NetWork: NSObject {
    
    public static let share  = NetWork()

    private func baseRequest(url: String, method: HTTPMethod = .post, parameters: [String: Any]? = nil, token: String? = nil, success:(([String: Any]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        let urlStr = NetWork.baseUrl + url
        
        var headers: HTTPHeaders?
        
        if let token = token {
            headers = ["token": token]
        }

        let allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })
        
        AF.request(urlStr, method: method, parameters: parameters, encoding: URLEncoding.default, headers: allHeaders)
            .validate(statusCode: 200..<300)
            .responseJSON { response in

              
            debugPrint("返回值:", response);

            switch response.result {
            case .success(let value):
                //可添加统一解析
                if let dic = value as? [String: Any],
                    let jsonData = try? JSONSerialization.data(withJSONObject: dic, options: .prettyPrinted),
                    let jsonString = String(data: jsonData, encoding: .utf8){
                    DispatchQueue.main.async {
                        success?(dic)
                    }
                }
                break
            case .failure(let error):
                DispatchQueue.main.async {
                    failure?(error)
                }
                break
            }
        }
    }
    
    private func baseRequestWithModel<T: BaseModel>(url: String, method: HTTPMethod = .post, parameters: [String: Any]? = nil, token: String? = nil, type: T.Type = (BaseModel.self as! T.Type), success:((T) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        let urlStr = NetWork.baseUrl + url
        
        var headers: HTTPHeaders?
        
        if let token = token {
            headers = ["token": token]
        }

        let allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })
        
        var response: DataResponse<T, AFError>?
        AF.request(urlStr, method: method, parameters: parameters, encoding: URLEncoding.default, headers: allHeaders)
            .validate(statusCode: 200..<300)
            .uploadProgress(closure: { progress in
                debugPrint("progress = \(progress)")
            })
            .downloadProgress(closure: { progress in
                debugPrint("progress = \(progress)")
            })
            .responseDecodable(of: type) { (closureResponse) in
                response = closureResponse
                debugPrint("返回值:", response?.result)

                switch response?.result {
                case .success(let value):
                    //可添加统一解析
                    DispatchQueue.main.async {
                        success?(value)
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        failure?(error)
                    }
                    break
                case .none:
                    break
                }
        }
    }
    
    private static let baseUrl: String = "http://43.128.102.151:10000"

    private var defaultHeaders: HTTPHeaders {
        let headers: HTTPHeaders = ["device-type": "ios", "device-info": ""]
        return headers
    }
    
}

//MARK: - public
extension NetWork {
    func post(path: String, param: [String: Any]? = nil, token: String? = nil, success:(([String: Any]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        baseRequest(url: path, method: .post, parameters: param, token: token, success: success, failure: failure)
    }
    
    func get(path: String, param: [String: Any]? = nil, token: String? = nil, success:(([String: Any]) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
//        baseRequest(url: path, method: .get, parameters: param, token: token, success: success, failure: failure)
        baseRequestWithModel(url: path, method: .get, parameters: param, token: token) { a in
            
        } failure: { error in
            
        }
    }
}
