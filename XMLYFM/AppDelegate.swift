//
//  AppDelegate.swift
//  XMLYFM
//
//  Created by Domo on 2018/7/30.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit
import ESTabBarController_swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let tab = self.customIrregularityStyle(delegate: self as? UITabBarControllerDelegate)
        self.window?.rootViewController = tab
        self.window?.makeKeyAndVisible()

        // 静态图片引导页
        self.setStaticGuidePage()
        // 动态图片引导页
        //self.setDynamicGuidePage()
        // 视频引导页
        //self.setVideoGuidePage()
    
        return true
    }
    
    func setStaticGuidePage() {
        let imageNameArray: [String] = ["lead01", "lead02", "lead03"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setDynamicGuidePage() {
        let imageNameArray: [String] = ["guideImage6.gif", "guideImage7.gif", "guideImage8.gif"]
        let guideView = HHGuidePageHUD.init(imageNameArray: imageNameArray, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }
    
    func setVideoGuidePage() {
        let urlStr = Bundle.main.path(forResource: "qidong.mp4", ofType: nil)
        let videoUrl = NSURL.fileURL(withPath: urlStr!)
        let guideView = HHGuidePageHUD.init(videoURL: videoUrl, isHiddenSkipButton: false)
        self.window?.rootViewController?.view.addSubview(guideView)
    }

    // 加载底部tabbar样式
     func customIrregularityStyle(delegate: UITabBarControllerDelegate?) -> ESTabBarController {
        let tabBarController = ESTabBarController()
        tabBarController.delegate = delegate
        tabBarController.title = "Irregularity"
        tabBarController.tabBar.shadowImage = UIImage(named: "transparent")
        tabBarController.shouldHijackHandler = {
            tabbarController, viewController, index in
            if index == 2 {
                return true
            }
            return false
        }
        tabBarController.didHijackHandler = {
            [weak tabBarController] tabbarController, viewController, index in
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//                let vc = FMPlayController()
//                tabBarController?.present(vc, animated: true, completion: nil)
            }
        }
        
        let v1 = FMHomeController()
        let v2 = FMListenController()
        let v3 = FMPlayController()
        let v4 = FMFindController()
        let v5 = FMMineController()
        
        v1.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "首页", image: UIImage(named: "home"), selectedImage: UIImage(named: "home_1"))
        v2.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我听", image: UIImage(named: "find"), selectedImage: UIImage(named: "find_1"))
        v3.tabBarItem = ESTabBarItem.init(YYIrregularityContentView(), title: nil, image: UIImage(named: "tab_play"), selectedImage: UIImage(named: "tab_play"))
        v4.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "发现", image: UIImage(named: "favor"), selectedImage: UIImage(named: "favor_1"))
        v5.tabBarItem = ESTabBarItem.init(YYIrregularityBasicContentView(), title: "我的", image: UIImage(named: "me"), selectedImage: UIImage(named: "me_1"))
        let n1 = YYNavigationController.init(rootViewController: v1)
        let n2 = YYNavigationController.init(rootViewController: v2)
        let n3 = YYNavigationController.init(rootViewController: v3)
        let n4 = YYNavigationController.init(rootViewController: v4)
        let n5 = YYNavigationController.init(rootViewController: v5)
        v1.title = "首页"
        v2.title = "我听"
        v3.title = "播放"
        v4.title = "发现"
        v5.title = "我的"
        
        tabBarController.viewControllers = [n1, n2, n3, n4, n5]
        return tabBarController
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

