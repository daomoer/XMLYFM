//
//  HomeLiveHeaderView.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/28.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import SwiftyJSON
import HandyJSON

/// 添加cell点击代理方法
protocol HomeLiveHeaderViewDelegate:NSObjectProtocol {
    func homeLiveHeaderViewCategoryBtnClick(button:UIButton)
}

class HomeLiveHeaderView: UICollectionReusableView{
    weak var delegate : HomeLiveHeaderViewDelegate?

    private var btnArray = NSMutableArray()
    private var lineView : UIView = {
        let view = UIView()
        view.backgroundColor = DominantColor
        return view
    }()
    private var moreBtn: UIButton = {
       let button = UIButton.init(type: UIButtonType.custom)
        button.setTitle("更多 >", for: UIControlState.normal)
        button.setTitleColor(UIColor.gray, for: UIControlState.normal)
        button.addTarget(self, action: #selector(moreBtnClick), for: UIControlEvents.touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        let num = ["热门","情感","有声","新秀","二次元"]
        let margin:CGFloat = 50
        for index in 0..<num.count {
            let btn = UIButton.init(type: UIButtonType.custom)
            btn.frame = CGRect(x:margin*CGFloat(index),y:2.5,width:margin,height:25)
            btn.setTitle(num[index], for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            btn.tag = index+1000
            if btn.tag == 1000 {
                btn.setTitleColor(DominantColor, for: UIControlState.normal)
                self.lineView.frame = CGRect(x:margin*CGFloat(btn.tag-1000)+12.5,y:30,width:margin/2,height:2)
            }else {
                btn.setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            }
            self.btnArray.add(btn)
            btn.addTarget(self, action: #selector(btnClick(button:)), for: UIControlEvents.touchUpInside)
            self.addSubview(btn)
        }
        
        self.addSubview(self.lineView)
        self.addSubview(self.moreBtn)
        self.moreBtn.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(25)
            make.width.equalTo(50)
            make.top.equalTo(2.5)
        }
        
    }
    @objc func btnClick(button:UIButton) {
        let margin:CGFloat = 50
        self.lineView.frame = CGRect(x:margin*CGFloat(button.tag-1000)+12.5,y:30,width:margin/2,height:2)
        for btn in self.btnArray {
            if (btn as AnyObject).tag == button.tag {
                (btn as AnyObject).setTitleColor(DominantColor, for: UIControlState.normal)
            }else {
                (btn as AnyObject).setTitleColor(UIColor.lightGray, for: UIControlState.normal)
            }
        }
        delegate?.homeLiveHeaderViewCategoryBtnClick(button: button)
    }
    
    @objc func moreBtnClick(){
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
