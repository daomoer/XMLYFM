//
//  HomeLiveBannerCell.swift
//  YYSwiftProject
//
//  Created by Domo on 2018/7/28.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import FSPagerView

class HomeLiveBannerCell: UICollectionViewCell {
    var liveBanner: [HomeLiveBanerList]?
    
    // MARK: - 懒加载滚动图片浏览器
    private lazy var pagerView : FSPagerView = {
        let pagerView = FSPagerView()
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.automaticSlidingInterval =  3
        pagerView.isInfinite = !pagerView.isInfinite
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "HomeLiveBannerCell")
        return pagerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.pagerView)
        self.pagerView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var bannerList: [HomeLiveBanerList]? {
        didSet {
            guard let model = bannerList else { return }
            self.liveBanner = model
            self.pagerView.reloadData()
        }
    }
}

extension HomeLiveBannerCell: FSPagerViewDelegate, FSPagerViewDataSource {
    // MARK:- FSPagerView Delegate
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.liveBanner?.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "HomeLiveBannerCell", at: index)
        cell.imageView?.kf.setImage(with: URL(string:(self.liveBanner?[index].cover)!))
        return cell
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        
    }
}

