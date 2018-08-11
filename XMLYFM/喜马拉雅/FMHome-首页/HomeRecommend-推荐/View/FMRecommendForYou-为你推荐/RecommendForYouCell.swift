//
//  RecommendForYouCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class RecommendForYouCell: UICollectionViewCell {
    // 图片
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    // 标题
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    // 子标题
    private var subLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray
        return label
    }()
    
    // 子标题
    private var numLabel : UILabel = {
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
            make.bottom.equalToSuperview().offset(-15)
            make.width.equalTo(80)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.text = "明朝那些事"
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.imageView.snp.right).offset(10)
            make.right.equalToSuperview()
            make.top.equalTo(self.imageView)
            make.height.equalTo(20)
        }
        
        self.addSubview(self.subLabel)
        self.subLabel.text = "说服力的积分乐山大佛大"
        self.subLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(10)
        }
        
        self.addSubview(self.numLabel)
        self.numLabel.text = "> 2.5亿 1284集"
        self.numLabel.snp.makeConstraints { (make) in
            make.left.right.height.equalTo(self.subLabel)
            make.bottom.equalToSuperview().offset(-15)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
