//
//  FMListenFooterView.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
/// 添加按钮点击代理方法
protocol FMListenFooterViewDelegate:NSObjectProtocol {
    func listenFooterAddBtnClick()
}

/// 订阅和一键听底部添加按钮
class FMListenFooterView: UIView {
    weak var delegate : FMListenFooterViewDelegate?
    
    private var addButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = UIColor.white
        button.addTarget(self, action: #selector(addButtonClick), for: UIControlEvents.touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(addButton)
        addButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(40)
            make.width.equalTo(120)
            make.centerX.equalToSuperview()
        }
        addButton.layer.masksToBounds = true
        addButton.layer.cornerRadius = 20
    }
    
    var listenFooterViewTitle:String?{
        didSet {
            addButton.setTitle(listenFooterViewTitle, for: UIControlState.normal)
        }
    }
    
    @objc func addButtonClick(){
        delegate?.listenFooterAddBtnClick()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
