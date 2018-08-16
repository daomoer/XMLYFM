//
//  ListenChannelController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/14.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView

class ListenChannelController: UIViewController,LTTableViewProtocal {
    
    //Mark:- footerView
    private lazy var footerView:FMListenFooterView = {
        let view = FMListenFooterView.init(frame: CGRect(x:0, y:0, width:YYScreenWidth, height:100))
        view.listenFooterViewTitle = "➕添加频道"
        view.delegate = self
        return view
    }()
    
    private let ListenChannelCellID = "ListenChannelCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 5, width:YYScreenWidth, height: YYScreenHeigth-64), self, self, nil)
        tableView.register(ListenChannelCell.self, forCellReuseIdentifier: ListenChannelCellID)
        tableView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        tableView.tableFooterView = self.footerView
        return tableView
    }()
    
    lazy var viewModel: ListenChannelViewModel = {
        return ListenChannelViewModel()
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
    
    extension ListenChannelController : UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfRowsInSection(section: section)
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell:ListenChannelCell = tableView.dequeueReusableCell(withIdentifier: ListenChannelCellID, for: indexPath) as! ListenChannelCell
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            cell.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
            cell.channelResults = viewModel.channelResults?[indexPath.row]
            return cell
        }
}

//Mark: - 底部添加频道按钮点击delegate
extension ListenChannelController : FMListenFooterViewDelegate {
    func listenFooterAddBtnClick() {
        let vc = ListenMoreChannelController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
