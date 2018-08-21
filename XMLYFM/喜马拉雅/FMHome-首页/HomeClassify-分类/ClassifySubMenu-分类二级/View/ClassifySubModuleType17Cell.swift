//
//  ClassifySubModuleType17Cell.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/20.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class ClassifySubModuleType17Cell: UICollectionViewCell {
    private var imageView:UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
        }
    }
    var classifyVerticalModel: ClassifyVerticalModel? {
        didSet {
            guard let model = classifyVerticalModel else {return}
            self.imageView.kf.setImage(with: URL(string: model.coverPath!))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
