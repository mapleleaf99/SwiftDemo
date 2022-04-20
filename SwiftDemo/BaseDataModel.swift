//
//  BaseModel.swift
//  SwiftDemo
//
//  Created by 郭飞锋 on 2022/4/20.
//

import UIKit

class BaseDataModel<T: BaseModelProtocol>: Codable {
    var code: Int?
    var data: T?
    var msg: String = ""
    

}
