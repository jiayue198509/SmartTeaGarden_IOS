//
//  LocalWeatherView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/15.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

class LocalWeatherView: UIView {


}

extension LocalWeatherView {
    class func localWeatherView() -> LocalWeatherView{
        return Bundle.main.loadNibNamed("LocalWeatherView", owner: nil, options: nil)?.first as! LocalWeatherView
    }
}
