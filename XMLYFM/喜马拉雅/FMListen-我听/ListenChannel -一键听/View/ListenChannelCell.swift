//
//  ListenChannelCell.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import JXMarqueeView

class ListenChannelCell: UITableViewCell {
    private var marqueeView = JXMarqueeView()
    
    // 背景大图
    private var picView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 5
        return imageView
    }()
    // 标题
    private var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 25)
        return label
    }()
    
    // 滚动文字
    private var scrollLabel : UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "测试啊多胡搜费货收到了粉红色的龙卷风"
        return label
    }()
    
    // 播放按钮
    private var playBtn : UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "whitePlay"), for: UIControlState.normal)
        return btn
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpUI()
    }
    
    func setUpUI(){
        self.addSubview(self.picView)
        self.picView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.picView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(20)
            make.width.equalTo(150)
            make.height.equalTo(30)
        }
        
        self.picView.addSubview(self.scrollLabel)
        self.scrollLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(5)
            make.height.equalTo(25)
            make.width.equalTo(200)
        }
        marqueeView.contentView = self.scrollLabel
        marqueeView.contentMargin = 10
        marqueeView.marqueeType = .left
        marqueeView.backgroundColor = UIColor.red
        self.picView.addSubview(marqueeView)
        
        
        self.picView.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.bottom.right.equalToSuperview().offset(-15)
            make.width.height.equalTo(45)
        }
    }
    
    var channelResults:ChannelResultsModel? {
        didSet {
            guard let model = channelResults else {return}
           self.picView.kf.setImage(with: URL(string: model.bigCover!))
            self.titleLabel.text = model.channelName
           self.scrollLabel.text = model.slogan
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
