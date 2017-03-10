//
//  LeftMenuTableViewCell.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/10.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

struct LeftMenuTableViewCellData {
    
    init(image: UIImage, text: String) {
        self.image = image
        self.text = text
    }
    var image: UIImage
    var text: String
}

class LeftMenuTableViewCell : BaseTableViewCell {
    
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var dataText: UILabel!
    
    override func awakeFromNib() {
        self.dataText?.font = UIFont.italicSystemFont(ofSize: 16)
        self.dataText?.textColor = UIColor(hex: "9E9E9E")
    }
    
    override class func height() -> CGFloat {
        return 60
    }
    
    override func setData(_ data: Any?) {
        if let data = data as? LeftMenuTableViewCellData {
            self.dataImage.image = data.image
            self.dataText.text = data.text
        }
    }
}

