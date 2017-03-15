//
//  PieItemView.swift
//  SmartTeaGarden
//
//  Created by jiaerdong on 2017/3/14.
//  Copyright © 2017年 tianciqinyun. All rights reserved.
//

import UIKit

class PieItemView: UIView {
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var waveIndicator: WaveLoadingIndicator!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialFromXib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialFromXib()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    func initialFromXib() {
        let contentView =  Bundle.main.loadNibNamed(
            "PieItemView", owner: self, options: nil)?.first as! UIView
        contentView.frame = bounds
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(contentView)
    }
}
