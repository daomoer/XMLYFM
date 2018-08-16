//
//  FindRecommendController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class FindRecommendController: UIViewController , LTTableViewProtocal{
    
    private let FindRecommendCellID = "FindRecommendCell"
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth-56-64), self, self, nil)
        tableView.register(FindRecommendCell.self, forCellReuseIdentifier: FindRecommendCellID)
        return tableView
    }()
    
    lazy var viewModel: FindRecommendViewModel = {
        return FindRecommendViewModel()
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

extension FindRecommendController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRowAt(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FindRecommendCell = tableView.dequeueReusableCell(withIdentifier: FindRecommendCellID, for: indexPath) as! FindRecommendCell
            cell.streamModel = viewModel.streamList?[indexPath.row]
        return cell
    }
}

