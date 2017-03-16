//
//  WeatherStationView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/16.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

class WeatherStationView: UIView {


}

extension WeatherStationView {
    class func weatherStationView() -> WeatherStationView {
        return Bundle.main.loadNibNamed("WeatherStationView", owner: nil, options: nil)?.first as! WeatherStationView
    }
}
