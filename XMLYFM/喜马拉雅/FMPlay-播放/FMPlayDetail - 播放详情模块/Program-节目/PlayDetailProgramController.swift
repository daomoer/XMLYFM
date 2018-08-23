//
//  PlayDetailProgramController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class PlayDetailProgramController: UIViewController, LTTableViewProtocal{
    private var playDetailTracks:FMPlayDetailTracksModel?

    private let PlayDetailProgramCellID        = "PlayDetailProgramCell"
//    private let PlayDetailProgramHeaderViewID  = "PlayDetailProgramHeaderView"
//    private lazy var headerView:PlayDetailProgramHeaderView = {
//        let view = PlayDetailProgramHeaderView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:40))
//        view.backgroundColor = UIColor.red
//        return view
//    }()
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y:0, width:YYScreenWidth, height: YYScreenHeigth-64), self, self, nil)
//        tableView.backgroundColor = UIColor.gray
        tableView.register(PlayDetailProgramCell.self, forCellReuseIdentifier: PlayDetailProgramCellID)
//        tableView.register(PlayDetailProgramHeaderView.self, forCellReuseIdentifier: PlayDetailProgramHeaderViewID)
//        tableView.tableHeaderView = self.headerView
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
    
    var playDetailTracksModel:FMPlayDetailTracksModel?{
        didSet{
            guard let model = playDetailTracksModel else {return}
            self.playDetailTracks = model
            self.tableView.reloadData()
        }
    }
}

extension PlayDetailProgramController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.playDetailTracks?.list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:PlayDetailProgramCell = tableView.dequeueReusableCell(withIdentifier: PlayDetailProgramCellID, for: indexPath) as! PlayDetailProgramCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.playDetailTracksList = self.playDetailTracks?.list?[indexPath.row]
            cell.indexPath = indexPath
            return cell
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
////        let headView:PlayDetailProgramHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: PlayDetailProgramHeaderViewID) as! PlayDetailProgramHeaderView
////        return headView
//        let headerView = PlayDetailProgramHeaderView()
//        headerView.backgroundColor = UIColor.red
//        return headerView
//    }
}


