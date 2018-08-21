//
//  PlayDetailIntroController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class PlayDetailIntroController: UIViewController, LTTableViewProtocal{
    private let PlayContentIntroCellID = "PlayContentIntroCell"
    private let PlayAnchorIntroCellID  = "PlayAnchorIntroCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth-56-64), self, self, nil)
        tableView.register(PlayContentIntroCell.self, forCellReuseIdentifier: PlayContentIntroCellID)
        tableView.register(PlayAnchorIntroCell.self, forCellReuseIdentifier: PlayAnchorIntroCellID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    var playDetailAlbumModel:FMPlayDetailAlbumModel? {
        didSet{
            guard let model = playDetailAlbumModel else {return}
            print(model)
        }
    }
}

extension PlayDetailIntroController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:PlayContentIntroCell = tableView.dequeueReusableCell(withIdentifier: PlayContentIntroCellID, for: indexPath) as! PlayContentIntroCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }else {
            let cell:PlayAnchorIntroCell = tableView.dequeueReusableCell(withIdentifier: PlayAnchorIntroCellID, for: indexPath) as! PlayAnchorIntroCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
    }
}


