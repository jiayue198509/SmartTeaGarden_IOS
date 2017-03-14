//
//  CollectionHeaderView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/14.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}


// MARK:- 从Xib中快速创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
