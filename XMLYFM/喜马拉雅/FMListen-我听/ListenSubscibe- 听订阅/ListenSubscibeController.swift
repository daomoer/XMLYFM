//
//  ListenSubscibeController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class ListenSubscibeController: UIViewController,LTTableViewProtocal {
    private lazy var footerView:FMListenFooterView = {
        let view = FMListenFooterView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:100))
        view.listenFooterViewTitle = "➕添加订阅"
        return view
    }()
    
    private let ListenSubscibeCellID = "ListenSubscibeCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth-64), self, self, nil)
        tableView.register(ListenSubscibeCell.self, forCellReuseIdentifier: ListenSubscibeCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
//        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: ListenSubscibeViewModel = {
        return ListenSubscibeViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tableView)
        glt_scrollView = tableView
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        loadData()
    }
    
    func loadData() {
        // 加载数据
        viewModel.updataBlock = { [unowned self] in
            // 更新列表数据
            self.tableView.reloadData()
        }
        viewModel.refreshDataSource()
    }
    
}

extension ListenSubscibeController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ListenSubscibeCell = tableView.dequeueReusableCell(withIdentifier: ListenSubscibeCellID, for: indexPath) as! ListenSubscibeCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.albumResults = viewModel.albumResults?[indexPath.row]
        return cell
    }
}

