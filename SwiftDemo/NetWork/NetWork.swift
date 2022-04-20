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

class NetWork: NSObject {
    
    public static let share  = NetWork()
    
    private func baseRequestWithModel<T: BaseModelProtocol>(url: String, method: HTTPMethod = .post, parameters: [String: Any]? = nil, token: String? = nil, type: T.Type = (BaseModelProtocol.self as! T.Type), success:((T) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        let urlStr = NetWork.baseUrl + url
        
        var headers: HTTPHeaders?
        
        if let token = token {
            headers = ["token": token]
        }

        let allHeaders = HTTPHeaders(defaultHeaders.dictionary.merging((headers ?? []).dictionary) { $1 })
        
        var response: DataResponse<BaseDataModel<T>, AFError>?
        AF.request(urlStr, method: method, parameters: parameters, encoding: URLEncoding.default, headers: allHeaders)
//            .validate(statusCode: 200..<300)
            .uploadProgress(closure: { progress in
                debugPrint("progress = \(progress)")
            })
            .downloadProgress(closure: { progress in
                debugPrint("progress = \(progress)")
            })
            .responseDecodable(of: BaseDataModel<T>.self) { (closureResponse) in
                response = closureResponse
                debugPrint("返回值:", response?.result)

                switch response?.result {
                case .success(let value):
                    //可添加统一解析
                    DispatchQueue.main.async {
                        if value.code == 0, let model = value.data {
                            success?(model)
                        } else {
                            debugPrint("msg: \(value.msg)")
                        }
                    }
                    break
                case .failure(let error):
                    DispatchQueue.main.async {
                        failure?(error)
                        debugPrint("error: \(error.errorDescription)")

                    }
                    break
                case .none:
                    break
                }
        }
    }
    
    private static let baseUrl: String = "http://43.156.25.182:10000"

    private var defaultHeaders: HTTPHeaders {
        let headers: HTTPHeaders = ["device-type": "ios", "device-info": ""]
        return headers
    }
    
}

//MARK: - public
extension NetWork {
    func postUrlWithModel<T: BaseModelProtocol>(path: String, param: [String: Any]? = nil, token: String? = nil, type: T.Type = (BaseModelProtocol.self as! T.Type), success:((T) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        baseRequestWithModel(url: path, method: .post, parameters: param, token: token, type: type, success: success, failure: failure)
    }

    func getUrlWithModel<T: BaseModelProtocol>(path: String, param: [String: Any]? = nil, token: String? = nil, type: T.Type = (BaseModelProtocol.self as! T.Type), success:((T) -> Void)? = nil, failure: ((Error?) -> Void)? = nil) {
        baseRequestWithModel(url: path, method: .get, parameters: param, token: token, type: type, success: success, failure: failure)
    }
}
