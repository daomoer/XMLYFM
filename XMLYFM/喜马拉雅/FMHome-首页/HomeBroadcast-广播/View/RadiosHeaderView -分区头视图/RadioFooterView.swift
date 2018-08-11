//
//  RadioFooterView.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/2.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class RadioFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = FooterViewColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
