//
//  FindAttentionController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class FindAttentionController: UIViewController , LTTableViewProtocal{

    private let FindAttentionCellID = "FindAttentionCell"

    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth-56-64), self, self, nil)
        tableView.register(FindAttentionCell.self, forCellReuseIdentifier: FindAttentionCellID)
        return tableView
    }()
    
    
    lazy var viewModel: FindAttentionViewModel = {
        return FindAttentionViewModel()
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

extension FindAttentionController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FindAttentionCell = tableView.dequeueReusableCell(withIdentifier: FindAttentionCellID, for: indexPath) as! FindAttentionCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.eventInfosModel = viewModel.eventInfos?[indexPath.row]
        return cell
    }
}

