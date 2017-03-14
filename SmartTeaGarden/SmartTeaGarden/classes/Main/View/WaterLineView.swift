//
//  WaterLineView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/14.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

let kWaterLineCellID = "kWaterLineCellID"
class WaterLineView: UIView {
    
    // MARK: 从Xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}


extension WaterLineView {
    class func waterLineView() -> WaterLineView {
        return Bundle.main.loadNibNamed("WaterLineView", owner: nil, options: nil)?.first as! WaterLineView
    }
}

