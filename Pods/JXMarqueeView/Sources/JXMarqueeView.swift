//
//  JXMarqueeView.swift
//  DQGuess
//
//  Created by jiaxin on 2018/4/27.
//  Copyright © 2018年 jingbo. All rights reserved.
//

import UIKit

public enum JXMarqueeType {
    case left
    case right
    case reverse
}

public class JXMarqueeView: UIView {
    public var marqueeType: JXMarqueeType = .left
    public var contentMargin: CGFloat = 12                     //两个视图之间的间隔
    public var frameInterval: Int = 1                          //多少帧回调一次，一帧时间1/60秒
    public var pointsPerFrame: CGFloat = 0.5                   //每次回调移动多少点
    public var contentView: UIView? {
        didSet {
            self.setNeedsLayout()
        }
    }
    private let containerView = UIView()
    private var marqueeDisplayLink: CADisplayLink?
    private var isReversing = false

    override open func willMove(toSuperview newSuperview: UIView?) {
        //骚操作：当视图将被移除父视图的时候，newSuperview就为nil。在这个时候，停止掉CADisplayLink，断开循环引用，视图就可以被正确释放掉了。
        if newSuperview == nil {
            self.stopMarquee()
        }
    }

    public init() {
        super.init(frame: CGRect.zero)

        self.initializeViews()
    }

    override public init(frame: CGRect) {
        super.init(frame: frame)

        self.initializeViews()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.initializeViews()
    }

    func initializeViews() {
        self.backgroundColor = UIColor.clear
        self.clipsToBounds = true

        containerView.backgroundColor = UIColor.clear
        self.addSubview(containerView)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        guard let validContentView = contentView else {
            return
        }
        for view in containerView.subviews {
            view.removeFromSuperview()
        }

        //对于复杂的视图，需要自己重写contentView的sizeThatFits方法，返回正确的size
        validContentView.sizeToFit()
        validContentView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
        containerView.addSubview(validContentView)

        if marqueeType == .reverse{
            containerView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
        }else {
            containerView.frame = CGRect(x: 0, y: 0, width: validContentView.bounds.size.width*2 + contentMargin, height: self.bounds.size.height)
        }

        if validContentView.bounds.size.width > self.bounds.size.width {
            if marqueeType != .reverse {
                //骚操作：UIView是没有遵从拷贝协议的。可以通过UIView支持NSCoding协议，间接来复制一个视图
                let otherContentViewData = NSKeyedArchiver.archivedData(withRootObject: validContentView)
                let otherContentView = NSKeyedUnarchiver.unarchiveObject(with: otherContentViewData) as! UIView
                otherContentView.frame = CGRect(x: validContentView.bounds.size.width + contentMargin, y: 0, width: validContentView.bounds.size.width, height: self.bounds.size.height)
                containerView.addSubview(otherContentView)
            }

            self.startMarquee()
        }
    }

    //如果你的contentView的内容在初始化的时候，无法确定。需要通过网络等延迟获取，那么在内容赋值之后，在调用该方法即可。
    public func reloadData() {
        self.setNeedsLayout()
    }

    fileprivate func startMarquee() {
        self.stopMarquee()

        if marqueeType == .right {
            var frame = self.containerView.frame
            frame.origin.x = self.bounds.size.width - frame.size.width
            self.containerView.frame = frame
        }

        self.marqueeDisplayLink = CADisplayLink.init(target: self, selector: #selector(processMarquee))
        self.marqueeDisplayLink?.frameInterval = self.frameInterval
        self.marqueeDisplayLink?.add(to: RunLoop.main, forMode: .commonModes)
    }

   fileprivate  func stopMarquee()  {
        self.marqueeDisplayLink?.invalidate()
        self.marqueeDisplayLink = nil
    }

    @objc fileprivate func processMarquee() {
        var frame = self.containerView.frame

        switch marqueeType {
        case .left:
            let targetX = -(self.contentView!.bounds.size.width + self.contentMargin)
            if frame.origin.x <= targetX {
                frame.origin.x = 0
                self.containerView.frame = frame
            }else {
                frame.origin.x -= pointsPerFrame
                if frame.origin.x < targetX {
                    frame.origin.x = targetX
                }
                self.containerView.frame = frame
            }
        case .right:
            let targetX = self.bounds.size.width - self.contentView!.bounds.size.width
            if frame.origin.x >= targetX {
                frame.origin.x = self.bounds.size.width - self.containerView.bounds.size.width
                self.containerView.frame = frame
            }else {
                frame.origin.x += pointsPerFrame
                if frame.origin.x > targetX {
                    frame.origin.x = targetX
                }
                self.containerView.frame = frame
            }
        case .reverse:
            if isReversing {
                let targetX: CGFloat = 0
                if frame.origin.x > targetX {
                    frame.origin.x = 0
                    self.containerView.frame = frame
                    isReversing = false
                }else {
                    frame.origin.x += pointsPerFrame
                    if frame.origin.x > 0 {
                        frame.origin.x = 0
                        isReversing = false
                    }
                    self.containerView.frame = frame
                }
            }else {
                let targetX = self.bounds.size.width - self.containerView.bounds.size.width
                if frame.origin.x <= targetX {
                    isReversing = true
                }else {
                    frame.origin.x -= pointsPerFrame
                    if frame.origin.x < targetX {
                        frame.origin.x = targetX
                        isReversing = true
                    }
                    self.containerView.frame = frame
                }
            }
        }

    }

}
