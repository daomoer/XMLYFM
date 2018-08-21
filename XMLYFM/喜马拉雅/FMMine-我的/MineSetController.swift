//
//  MineSetController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/16.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class MineSetController: UIViewController {
    private lazy var dataSource: Array = {
        return [[["title": "智能硬件"]],
            
                [["title": "特色闹铃"],
                 ["title": "定时关闭"]],
                
                [["title": "账号与安全"]],
                
                [["title": "推送设置"],
                 ["title": "收听偏好设置"],
                 ["title": "隐私设置"]],
                
                [["title": "断点续听"],
                 ["title": "2G/3G/4G播放和下载"],
                 ["title": "下载音质"],
                 ["title": "清理占用空间"]],
                
                [["title": "特色功能"],
                 ["title": "新版本介绍"],
                 ["title": "给喜马拉雅好评"],
                 ["title": "关于"]]]
    }()
    
    // 懒加载TableView
    private lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame:CGRect(x:0, y:0, width:YYScreenWidth, height:YYScreenHeigth), style: UITableViewStyle.plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = FooterViewColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "设置"
        self.view.addSubview(self.tableView)
    }
}

extension MineSetController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let sectionArray = dataSource[indexPath.section]
            let dict: [String: String] = sectionArray[indexPath.row]
            cell.textLabel?.text = dict["title"]
            if indexPath.section == 3 && indexPath.row == 1{
                let cellSwitch = UISwitch.init()
                cell.accessoryView = cellSwitch
            }else {
                cell.accessoryType = .disclosureIndicator
            }
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = FooterViewColor
        return footerView
    }
}
