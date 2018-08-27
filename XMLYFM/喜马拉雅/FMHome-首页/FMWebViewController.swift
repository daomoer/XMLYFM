//
//  FMWebViewController.swift
//  XMLYFM
//
//  Created by Domo on 2018/8/26.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import WebKit

class FMWebViewController: UIViewController {
    private var url:String = ""
    
    convenience init(url: String = "") {
        self.init()
        self.url = url
    }
    private lazy var webView:WKWebView = {
        let webView = WKWebView(frame: self.view.bounds)
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(webView)
        webView.load(URLRequest.init(url: URL.init(string: self.url)!))
    }
}

