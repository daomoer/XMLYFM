//
//  RadioSquareCell.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/2.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class RadioSquareCell: UICollectionViewCell {
    private lazy var imageView : UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.height.width.equalTo(40)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
        }
        
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
    }
    
    var radioSquareModel: RadioSquareResultsModel? {
        didSet {
            guard let model = radioSquareModel else {return}
            self.imageView.kf.setImage(with: URL(string: model.icon!))
            self.titleLabel.text = model.title
            }
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
