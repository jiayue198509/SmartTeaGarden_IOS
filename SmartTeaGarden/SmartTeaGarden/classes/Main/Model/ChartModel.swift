//
//  ChartModel.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/15.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import Foundation

class ChartModel: NSObject {
    //温湿度数值
    var value: Double = 0.0
    //区域
    var area: String = ""
    
    init(dict : [String : Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
