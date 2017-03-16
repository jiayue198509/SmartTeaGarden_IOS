//
//  ChartView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/15.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit
import Charts

let kStandardColor = [NSUIColor.init(red: 247/255, green: 128/255, blue: 104/255, alpha: 1), NSUIColor.init(red: 22/255, green: 158/255, blue: 244/255, alpha: 1), NSUIColor.init(red: 36/255, green: 199/255, blue: 136/255, alpha: 1)]
class ChartView: UIView {
    
    fileprivate let area: [String] = ["一区", "二区", "三区", "四区", "五区", "六区", "七区", "八区", "九区", "十区", "十一区", "十二区" , "十三区"]
    weak var axisFormatDelegate: IAxisValueFormatter?
    fileprivate var data = BarChartData()
    var dataSource : [ChartModel]? {
        didSet {
            setupUI()
        }
    }
    
    @IBOutlet var barCharView: BarChartView!
    
    var lowerLimit: Double = 0.0
    var upperLimit: Double = 0.0
    
    lazy var colors:[UIColor] = []
    lazy var arrays:[BarChartDataEntry] = []
    
}


//数据更新
extension ChartView {
    //设置图表样式
    private func setStyle(){
        self.barCharView.noDataText = NSLocalizedString("no_data", comment: "")//没有数据时的文字提示
        self.barCharView.drawValueAboveBarEnabled = true//数值显示在柱形的上面还是下面
        self.barCharView.highlightFullBarEnabled = false;//点击柱形图是否显示箭头
        self.barCharView.drawBarShadowEnabled = false;//是否绘制柱形的阴影背景
        
        self.barCharView.xAxis.labelPosition = .bottom
        self.barCharView.gridBackgroundColor = NSUIColor.white
        self.barCharView.chartDescription?.text = ""
        self.barCharView.xAxis.drawGridLinesEnabled = false
        
        self.barCharView.dragEnabled = false
        self.barCharView.doubleTapToZoomEnabled = false
        axisFormatDelegate = self
        self.barCharView.xAxis.valueFormatter = axisFormatDelegate
        
        self.barCharView.xAxis.labelRotationAngle = 30
        self.barCharView.leftAxis.drawGridLinesEnabled = false
        
        self.barCharView.legend.enabled = false//不显示图例说明
        
        self.barCharView.rightAxis.enabled = false
        
//        self.barCharView.xAxis.spaceMin = 4
    }
    
    private func setDataEntry() {
        if(dataSource != nil && (dataSource?.count)! > 0){
            colors.removeAll()
            arrays.removeAll()
            data.clearValues()
            var xValue = 0
            for item in dataSource! {
                let cde = BarChartDataEntry(x: Double(xValue), y: item.value)
                if(item.value > upperLimit) {
                    colors.append(kStandardColor[0])
                }else if(item.value < lowerLimit){
                    colors.append(kStandardColor[1])
                }else {
                    colors.append(kStandardColor[2])
                }
                arrays.append(cde)
                xValue = xValue + 1
            }
            
            let cds = BarChartDataSet(values: arrays, label: "")
            cds.colors = colors
            data.addDataSet(cds)
            data.barWidth = 0.5
            self.barCharView.xAxis.labelCount = arrays.count
        }
    }
    
    fileprivate func setData() {
        data.clearValues()
        setDataEntry()
        barCharView.xAxis.axisLineWidth=0.5
        barCharView.data = data
    }
    
    func setupUI(){
        setStyle()
        setData()
        self.barCharView.animate(xAxisDuration: 0, yAxisDuration: 2.0)
    }
    
    func setThreshold(min: Double, max: Double){
        self.lowerLimit = min
        self.upperLimit = max
        
        let chartLowerLimit = ChartLimitLine(limit: 10.0, label: "")
        chartLowerLimit.lineColor = kStandardColor[2]
        chartLowerLimit.lineWidth = 1
        self.barCharView.leftAxis.addLimitLine(chartLowerLimit)
        
        let chartUpperLimit = ChartLimitLine(limit: 20.0, label: "")
        chartUpperLimit.lineColor = kStandardColor[0]
        chartUpperLimit.lineWidth = 1
        self.barCharView.leftAxis.addLimitLine(chartUpperLimit)
    }
}

extension ChartView {
    class func chartView() -> ChartView {
        return Bundle.main.loadNibNamed("ChartView", owner: nil, options: nil)?.first as! ChartView
    }
}

extension ChartView: IAxisValueFormatter {

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return area[Int(value)]
    }
    
}
