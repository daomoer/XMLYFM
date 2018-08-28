//
//  PlayDetailLikeController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/21.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView
import SwiftyJSON
import HandyJSON

class PlayDetailLikeController: UIViewController , LTTableViewProtocal{
    private var albumResults:[ClassifyVerticalModel]?
    private let PlayDetailLikeCellID = "PlayDetailLikeCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth), self, self, nil)
        tableView.register(PlayDetailLikeCell.self, forCellReuseIdentifier: PlayDetailLikeCellID)
        tableView.uHead = URefreshHeader{ [weak self] in self?.loadData() }
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
        //刚进页面进行刷新
        self.tableView.uHead.beginRefreshing()
        loadData()
    }
    func loadData(){
        FMPlayDetailProvider.request(.playDetailLikeList(albumId:12825974)) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let mappedObject = JSONDeserializer<ClassifyVerticalModel>.deserializeModelArrayFrom(json: json["albums"].description) {
                    self.albumResults = mappedObject as? [ClassifyVerticalModel]
                    self.tableView.uHead.endRefreshing()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

extension PlayDetailLikeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albumResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:PlayDetailLikeCell = tableView.dequeueReusableCell(withIdentifier: PlayDetailLikeCellID, for: indexPath) as! PlayDetailLikeCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.classifyVerticalModel = self.albumResults?[indexPath.row]
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumId = self.albumResults?[indexPath.row].albumId ?? 0
        let vc = FMPlayDetailController(albumId: albumId)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

