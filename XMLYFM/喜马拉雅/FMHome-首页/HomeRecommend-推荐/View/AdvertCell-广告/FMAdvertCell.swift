//
//  FMAdvertCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class FMAdvertCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.imageView)
        self.imageView.image = UIImage(named: "pic1.jpeg")
        self.imageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-60)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "明朝那些事"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.imageView.snp.bottom)
            make.height.equalTo(30)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.text = "说服力的积分乐山大佛大士力架反倒是浪费接口都是雷锋精神的陆丰收代理费吉林省的"
        self.subLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.top.equalTo(self.titleLabel.snp.bottom)
            make.height.equalTo(30)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var adModel:RecommnedAdvertModel? {
        didSet {
            guard let model = adModel else {return}
            self.titleLabel.text = model.name
            self.subLabel.text = model.description
            self.imageView.kf.setImage(with: URL(string: model.cover!))
            }
        }
}
