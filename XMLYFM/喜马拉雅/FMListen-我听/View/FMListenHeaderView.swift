//
//  FMListenHeaderView.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class FMListenHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        setUpUI()
        
        let view = UIView()
        view.backgroundColor = FooterViewColor
        self.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(10)
        }
    }
    
    func setUpUI(){
        let margin:CGFloat = self.frame.width/9
        let titleArray = ["下载","历史","已购","喜欢"]
        let imageArray = ["download","history","buy","like"]
        let numArray = ["暂无","8","暂无","25"]
        for index in 0..<4 {
            let button = UIButton.init(frame: CGRect(x:margin*CGFloat(index)*2+margin,y:10,width:margin,height:margin))
            button.setImage(UIImage(named: imageArray[index]), for: UIControlState.normal)
            self.addSubview(button)

            let titleLabel = UILabel()
            titleLabel.textAlignment = .center
            titleLabel.text = titleArray[index]
            titleLabel.font = UIFont.systemFont(ofSize: 15)
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+20)
                make.top.equalTo(margin+10+5)
            })
            
            let numLabel = UILabel()
            numLabel.textAlignment = .center
            numLabel.text = numArray[index]
            numLabel.font = UIFont.systemFont(ofSize: 14)
            self.addSubview(numLabel)
            numLabel.snp.makeConstraints({ (make) in
                make.centerX.equalTo(button)
                make.width.equalTo(margin+20)
                make.top.equalTo(margin+10+5+25)
            })
            button.tag = index
//            button.addTarget(self, action: #selector(gridBtnClick(button:)), for: UIControlEvents.touchUpInside)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
