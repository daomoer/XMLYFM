//
//  FindDudController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/6.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON

class FindDudController:  UIViewController , LTTableViewProtocal{
    private var findDudList: [FindDudModel]?
    
    private let FindDudCellID = "FindDudCell"
    
    private lazy var tableView: UITableView = {
        let tableView = tableViewConfig(CGRect(x: 0, y: 0, width:YYScreenWidth, height: YYScreenHeigth-56-64), self, self, nil)
        tableView.register(FindDudCell.self, forCellReuseIdentifier: FindDudCellID)
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none
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
        
        loadData()
    }
    
    func loadData(){
        //1 获取json文件路径
        let path = Bundle.main.path(forResource: "FindDud", ofType: "json")
        //2 获取json文件里面的内容,NSData格式
        let jsonData=NSData(contentsOfFile: path!)
        //3 解析json内容
        let json = JSON(jsonData!)
        if let mappedObject = JSONDeserializer<FMFindDudModel>.deserializeFrom(json: json.description) {
            self.findDudList = mappedObject.data
            self.tableView.reloadData()
        }
    }
}




extension FindDudController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.findDudList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:FindDudCell = tableView.dequeueReusableCell(withIdentifier: FindDudCellID, for: indexPath) as! FindDudCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.findDudModel = self.findDudList?[indexPath.row]
        return cell
    }
}
