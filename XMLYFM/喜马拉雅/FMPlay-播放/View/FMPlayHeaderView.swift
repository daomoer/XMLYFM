//
//  FMPlayHeaderView.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/23.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import StreamingKit

class FMPlayHeaderView: UICollectionViewCell {
    var playUrl:String?

    // 标题
    private var titleLabel:UILabel = {
       let label = UILabel()
        label.textAlignment = NSTextAlignment.center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    // 图片
    private var imageView:UIImageView = {
       let imageView = UIImageView()
        return imageView
    }()
    //弹幕按钮
    private lazy var barrageBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "NPProDMOff_24x24_"), for: UIControlState.normal)
        return button
    }()
    //播放机器按钮
    private lazy var machineBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "npXPlay_30x30_"), for: UIControlState.normal)
        return button
    }()
    //设置按钮
    private lazy var setBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "NPProSet_25x24_"), for: UIControlState.normal)
        return button
    }()
    // 进度条
    private lazy var slider:UISlider = {
        let slider = UISlider(frame: CGRect.zero)
        slider.setThumbImage(UIImage(named: "playProcessDot_n_7x16_"), for: .normal)
        slider.maximumTrackTintColor = UIColor.lightGray
        slider.minimumTrackTintColor = DominantColor
        return slider
    }()
    //当前时间
    private lazy var currentTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = DominantColor
        return label
    }()
    //总时间
    private lazy var totalTime:UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = DominantColor
        label.textAlignment = NSTextAlignment.right
        return label
    }()
    //播放暂停按钮
    private lazy var playBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "toolbar_play_n_p_78x78_"), for: UIControlState.normal)
        button.addTarget(self, action: #selector(playBtn(button:)), for: UIControlEvents.touchUpInside)
        return button
    }()
    //上一曲按钮
    private lazy var prevBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "toolbar_prev_n_p_24x24_"), for: UIControlState.normal)
        return button
    }()
    
    //下一曲按钮
    private lazy var nextBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "toolbar_next_n_p_24x24_"), for: UIControlState.normal)
        return button
    }()
    //消息列表按钮
    private lazy var msgBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "playpage_icon_list_24x24_"), for: UIControlState.normal)
        return button
    }()
    //定时按钮
    private lazy var timingBtn:UIButton = {
        let button = UIButton.init(type: UIButtonType.custom)
        button.setImage(UIImage(named: "playpage_icon_timing_24x24_"), for: UIControlState.normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }

    
    func setUpUI(){
        // 标题
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(60)
        }
        // 图片
        self.addSubview(self.imageView)
        self.imageView.backgroundColor = UIColor.purple
        self.imageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
            make.height.equalTo(YYScreenHeigth*0.8-260)
        }
        //弹幕按钮
        self.addSubview(self.barrageBtn)
        self.barrageBtn.snp.makeConstraints { (make) in
            make.left.equalTo(20)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        //设置按钮
        self.addSubview(self.setBtn)
        self.setBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        //播放机器按钮
        self.addSubview(self.machineBtn)
        self.machineBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.setBtn.snp.left).offset(-20)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.height.width.equalTo(30)
        }
        // 进度条
        self.addSubview(self.slider)
        self.slider.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-90)
        }
        //当前时间
        self.addSubview(self.currentTime)
        self.currentTime.text = "00:33"
        self.currentTime.snp.makeConstraints { (make) in
            make.left.equalTo(self.slider)
            make.top.equalTo(self.slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        //总时间
        self.addSubview(self.totalTime)
        self.totalTime.text = "21:33"
        self.totalTime.snp.makeConstraints { (make) in
            make.right.equalTo(self.slider)
            make.top.equalTo(self.slider.snp.bottom).offset(5)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        //播放暂停按钮
        self.addSubview(self.playBtn)
        self.playBtn.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(60)
            make.centerX.equalToSuperview()
        }
        //上一曲按钮
        self.addSubview(self.prevBtn)
        self.prevBtn.snp.makeConstraints { (make) in
            make.right.equalTo(self.playBtn.snp.left).offset(-30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.playBtn)
        }
        //下一曲按钮
        self.addSubview(self.nextBtn)
        self.nextBtn.snp.makeConstraints { (make) in
            make.left.equalTo(self.playBtn.snp.right).offset(30)
            make.height.width.equalTo(25)
            make.centerY.equalTo(self.playBtn)
        }
        //消息列表按钮
        self.addSubview(self.msgBtn)
        self.msgBtn.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
        //定时按钮
        self.addSubview(self.timingBtn)
        self.timingBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-15)
            make.bottom.equalToSuperview().offset(-20)
            make.height.width.equalTo(40)
        }
    }
    
    var playTrackInfo:FMPlayTrackInfo?{
        didSet{
            guard let model = playTrackInfo else {return}
            self.titleLabel.text = model.title
            self.imageView.kf.setImage(with: URL(string: model.coverLarge!))
            self.totalTime.text = getMMSSFromSS(duration: model.duration)
            self.playUrl = model.playUrl64
        }
    }

    func getMMSSFromSS(duration:Int)->(String){
        let str_minute = duration / 60
        let str_second = duration % 60
        let format_time = "\(str_minute):\(str_second)"
        return format_time
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func playBtn(button:UIButton){
        let audioPlayer = STKAudioPlayer()
        audioPlayer.play(URL(string: self.playUrl!)!)
    }

}
