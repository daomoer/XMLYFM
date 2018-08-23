//
//  PlayDetailProgramHeaderView.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class PlayDetailProgramHeaderView: UIView {
    private lazy var playBtn:UIButton = {
        // 收听全部
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("收听全部", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(named: "play"), for: UIControlState.normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(2, 5, 2, 0)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        button.backgroundColor = DominantColor
        button.isHidden = true
        return button
    }()
    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        setUpUI()
//    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setUpUI(){
        self.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.width.equalTo(80)
            make.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
